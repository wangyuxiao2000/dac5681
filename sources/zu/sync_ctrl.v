/*************************************************************/
//function: SYNC-OSERDES数据控制
//Author  : WangYuxiao
//Email   : wyxee2000@163.com
//Data    : 2024.10.15
//Version : V 1.0
/*************************************************************/
`timescale 1 ns / 1 ps

module sync_ctrl (clk_125m,rst_n,mode,sync,sync_data,sync_en,sync_rd);
input clk_125m; /*与ODELAYE3输入时钟保持一致*/
input rst_n;    /*低电平异步复位信号*/

input mode; /*mode=0时,sync关闭; mode=1时,sync开启*/
input sync; /*sync上升沿执行SYNC同步*/

output reg [7:0] sync_data; /*正常传输时为1111_1111; 同步时SERDES上需传输1101_1111,故送入SERDES的数据为1111_1011*/
output reg sync_en;         /*SYNC发送使能,低电平有效*/
output reg sync_rd;         /*SYNC信号已启动传输,允许通过sync触发同步操作*/

/*************************************************更新delay值************************************************/
reg sync_reg;
reg [1:0] state;
localparam STATE_start=2'b00;   /*执行同步*/
localparam STATE_wait=2'b01;    /*执行同步*/
localparam STATE_running=2'b11; /*正常传输*/
localparam STATE_sync=2'b10;    /*正常传输*/

always@(posedge clk_125m or negedge rst_n)
begin
  if(!rst_n)
    sync_reg<=0;
  else
    sync_reg<=sync;
end

always@(posedge clk_125m or negedge rst_n)
begin
  if(!rst_n)
    begin
      sync_en<=1;
      sync_data<=8'b0000_0000;
      sync_rd<=0;
      state<=STATE_start;
    end
  else if(mode==0) /*sync关闭*/
    begin
      sync_en<=1;
      sync_data<=8'b0000_0000;
      sync_rd<=0;
      state<=STATE_start;
    end
  else /*启动传输*/
    begin
      case(state)
        STATE_start : begin
                        sync_en<=0;
                        sync_data<=8'b0000_0000;
                        sync_rd<=0;
                        state<=STATE_wait;
                      end

        STATE_wait : begin
                       sync_en<=0;
                       sync_data<=8'b0000_0000;
                       sync_rd<=0;
                       state<=STATE_running;
                     end

        STATE_running : begin
                          sync_en<=0;
                          sync_data<=8'b1111_1111;
                          if(sync_rd&&!sync_reg&&sync)
                            begin
                              sync_rd<=0;
                              state<=STATE_sync;
                            end
                          else
                            begin
                              sync_rd<=1;
                              state<=STATE_running;
                            end
                        end

        STATE_sync : begin
                       sync_en<=0;
                       sync_data<=8'b1111_1011;
                       sync_rd<=1;
                       state<=STATE_running;
                     end
      endcase
    end
end
/***********************************************************************************************************/

endmodule