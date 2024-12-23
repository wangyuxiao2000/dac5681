/*************************************************************/
//function: ODELAYE3-VAR_LOAD模式延迟控制
//Author  : WangYuxiao
//Email   : wyxee2000@163.com
//Data    : 2024.10.14
//Version : V 1.0
/*************************************************************/
`timescale 1 ns / 1 ps

module delay_ctrl (clk_125m,rst_n,delay_monitor,delay_value,delay_rd,delay_vtc,delay_load,delay,ready);
input clk_125m;    /*与ODELAYE3输入时钟保持一致*/
input rst_n;       /*低电平异步复位信号*/

input [8:0] delay_monitor; /*ODELAY模块当前延迟值*/
input [8:0] delay_value;   /*GPIO输入的新延迟值*/
input delay_rd;            /*ODELAY模块delay值允许更新标志信号,高电平有效*/

output reg delay_vtc;      /*空闲为高*/
output reg delay_load;     /*空闲为低*/
output reg [8:0] delay;    /*向ODELAY模块更新的延迟值*/
output reg ready;          /*允许GPIO更新delay值,高电平有效*/



/*************************************************更新delay值************************************************/
reg [4:0] state;
localparam STATE_busy=5'b00001;   /*等待ODELAY允许更新delay值*/
localparam STATE_idle=5'b00010;   /*等待有效更新输入*/
localparam STATE_wait=5'b00100;   /*拉低delay_vtc后,等待15个时钟周期*/
localparam STATE_update=5'b01000; /*拉高load信号一个时钟周期*/
localparam STATE_over=5'b10000;   /*等待15个时钟周期,拉高delay_vtc*/

reg [3:0] wait_cnt; /*等待时间计数器*/

always@(posedge clk_125m or negedge rst_n)
begin
  if(!rst_n)
    begin
      delay_vtc<=1'b1;
      delay_load<=1'b0;
      delay<=0;
      ready<=0;
      wait_cnt<=0;
      state<=STATE_busy;
    end
  else
    begin
      case(state)
        STATE_busy : begin
                       if(delay_rd)
                         begin
                           ready<=1;
                           state<=STATE_idle;
                         end
                       else
                         begin
                           ready<=0;
                           state<=STATE_busy;
                         end
                     end

        STATE_idle : begin
                       if(delay_value!=delay_monitor) /*delay值更新,拉低delay_vtc*/
                         begin
                           delay_vtc<=1'b0;
                           ready<=0;
                           wait_cnt<=wait_cnt+1;
                           state<=STATE_wait;
                         end
                       else
                         begin
                           delay_vtc<=1'b1;
                           ready<=1;
                           wait_cnt<=0;
                           state<=STATE_idle;
                         end
                     end

        STATE_wait : begin
                       if(wait_cnt==4'd15)
                         begin
                           delay<=delay_value;
                           state<=STATE_update;
                         end
                       else
                         begin
                           delay<=delay;
                           state<=STATE_wait;
                         end
                       wait_cnt<=wait_cnt+1;
                     end

        STATE_update : begin
                         delay_load<=1'b1;
                         state<=STATE_over;
                       end

        STATE_over : begin
                       delay_load<=1'b0;
                       wait_cnt<=wait_cnt+1;
                       if(wait_cnt==4'd15)
                         begin
                           delay_vtc<=1'b1;
                           state<=STATE_busy;
                         end
                       else
                         begin
                           delay_vtc<=1'b0;
                           state<=STATE_over;
                         end
                     end

        default : begin
                    delay_vtc<=1'b1;
                    delay_load<=1'b0;
                    delay<=0;
                    ready<=0;
                    wait_cnt<=0;
                    state<=STATE_busy;
                  end
      endcase
    end
end
/***********************************************************************************************************/

endmodule