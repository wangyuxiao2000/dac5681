/*************************************************************/
//function: dac5681-lvds接口驱动
//Author  : WangYuxiao
//Email   : wyxee2000@163.com
//Data    : 2024.9.20
//Version : V 1.0
/*************************************************************/
`timescale 1 ns / 1 ps

module lvds_out (clk_500m,clk_125m,rst_n,sync_en_1,dclk_en_1,data_en_1,sync1_data,dds1_in,delay_load_1,delay_vtc_1,delay_value_1,delay_result_1,dac1_sync_p,dac1_sync_n,dac1_dclk_p,dac1_dclk_n,dac1_data_p,dac1_data_n,sync_en_2,dclk_en_2,data_en_2,sync2_data,dds2_in,delay_load_2,delay_vtc_2,delay_value_2,delay_result_2,dac2_sync_p,dac2_sync_n,dac2_dclk_p,dac2_dclk_n,dac2_data_p,dac2_data_n,delay_rd);
input clk_500m;  /*串行数据时钟(1Gbps线速率,对应DDR时钟为500m)*/
input clk_125m;  /*并行数据时钟(1Gbps线速率,8bit并串转换,对应并行数据输入速率为125m)*/
input rst_n;     /*低电平异步复位信号*/

input sync_en_1;             /*SYNC发送使能,低电平有效*/
input dclk_en_1;             /*DCLK发送使能,低电平有效*/
input data_en_1;             /*LVDS数据发送使能,低电平有效*/
input [7:0] sync1_data;      /*正常传输时为1111_1111; 同步时SERDES上需传输1101_1111,故送入SERDES的数据为1111_1011*/
input [127:0] dds1_in;       /*8*16bit采样点,[MSB:LSB]=[S7,S6,...,S1,S0],其中S0为第一个采样点; 每个采样点为16bit,[MSB:LSB]=[sign,data]*/
input delay_load_1;          /*odelay调节信号*/
input delay_vtc_1;           /*odelay调节信号*/
input [8:0] delay_value_1;   /*clk_delay input*/
output [8:0] delay_result_1; /*clk_delay output*/
output dac1_sync_p;          /*DAC-SYNC*/
output dac1_sync_n;          /*DAC-SYNC*/
output dac1_dclk_p;          /*DAC数据时钟*/
output dac1_dclk_n;          /*DAC数据时钟*/
output [15:0] dac1_data_p;   /*DAC-LVDS数据*/
output [15:0] dac1_data_n;   /*DAC-LVDS数据*/

input sync_en_2;             /*SYNC发送使能,低电平有效*/
input dclk_en_2;             /*DCLK发送使能,低电平有效*/
input data_en_2;             /*LVDS数据发送使能,低电平有效*/
input [7:0] sync2_data;      /*正常传输时为1111_1111; 同步时SERDES上需传输1101_1111,故送入SERDES的数据为1111_1011*/
input [127:0] dds2_in;       /*8*16bit采样点,[MSB:LSB]=[S7,S6,...,S1,S0],其中S0为第一个采样点; 每个采样点为16bit,[MSB:LSB]=[sign,data]*/
input delay_load_2;
input delay_vtc_2;
input [8:0] delay_value_2;   /*clk_delay input*/
output [8:0] delay_result_2; /*clk_delay output*/
output dac2_sync_p;          /*DAC-SYNC*/
output dac2_sync_n;          /*DAC-SYNC*/
output dac2_dclk_p;          /*DAC数据时钟*/
output dac2_dclk_n;          /*DAC数据时钟*/
output [15:0] dac2_data_p;   /*DAC-LVDS数据*/
output [15:0] dac2_data_n;   /*DAC-LVDS数据*/

output delay_rd;             /*odelay调节信号*/



/*****************************************对异步复位信号进行同步释放****************************************/
reg [9:0] rst;
always@(posedge clk_500m or negedge rst_n)
begin
  if(!rst_n)
    rst<=10'b11_1111_1111;
  else
    rst<={1'b0,rst[9:1]};
end
/***********************************************************************************************************/



/*********************************************例化16路数据oserdes********************************************/
wire [15:0] s7_1,s6_1,s5_1,s4_1,s3_1,s2_1,s1_1,s0_1;
wire [15:0] dac1_data;
wire [15:0] dac1_data_delay;
assign s7_1=dds1_in[127:112];
assign s6_1=dds1_in[111:96];
assign s5_1=dds1_in[95:80];
assign s4_1=dds1_in[79:64];
assign s3_1=dds1_in[63:48];
assign s2_1=dds1_in[47:32];
assign s1_1=dds1_in[31:16];
assign s0_1=dds1_in[15:0];

IDELAYCTRL #(.SIM_DEVICE("ULTRASCALE")            /*仅能设置为ULTRASCALE*/
            ) IDELAYCTRL_data (.RDY(delay_rd),    /*Ready output*/
                               .REFCLK(clk_500m), /*时钟输入*/
                               .RST(rst[0])       /*高电平异步复位*/
                              );
                                    
genvar i;
generate
  for(i=0;i<=15;i=i+1)
    begin
      OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
                  .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
                  .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
                  .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
                  .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
                  .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
                 ) OSERDESE3_data1 (.OQ(dac1_data[i]),                                                     /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                                    .T_OUT(),                                                              /*1-bit output: 3-state control output to IOB*/
                                    .CLK(clk_500m),                                                        /*串行数据时钟(DDR模式)*/
                                    .CLKDIV(clk_125m),                                                     /*并行数据时钟*/
                                    .D({s7_1[i],s6_1[i],s5_1[i],s4_1[i],s3_1[i],s2_1[i],s1_1[i],s0_1[i]}), /*并行数据输入*/
                                    .RST(rst[0]||data_en_1),                                               /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                                    .T(1'b0)                                                               /*1-bit input: Tristate input from fabric*/
                                   );

      ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
                 .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
                 .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
                 .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
                 .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
                 .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
                 .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
                 .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
                 .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
                ) ODELAYE3_data1 (.CASC_OUT(),                   /*Cascade delay output to IDELAY input cascade*/
                                  .CNTVALUEOUT(),                /*Counter value output*/
                                  .DATAOUT(dac1_data_delay[i]),  /*经过延迟的输出数据*/
                                  .CASC_IN(1'b0),                /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                                  .CASC_RETURN(1'b0),            /*Cascade delay returning from slave IDELAY DATAOUT*/
                                  .CE(1'b0),                     /*VARIABLE模式下调节延迟*/
                                  .CLK(clk_125m),                /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                                  .CNTVALUEIN(0),                /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                                  .EN_VTC(1'b1),                 /*Keep delay constant over VT; When DELAY_FORMAT is TIME, EN_VTC must be pulled High*/
                                  .INC(1'b0),                    /*VARIABLE模式下调节延迟*/
                                  .LOAD(1'b0),                   /*VAR_LOAD模式下调节延迟*/
                                  .ODATAIN(dac1_data[i]),        /*输入数据*/
                                  .RST(rst[0]||data_en_1)        /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                                 );
      
      OBUFDS OBUFDS_data1 (.O(dac1_data_p[i]),    /*1-bit output: Diff_p output (connect directly to top-level port)*/
                           .OB(dac1_data_n[i]),   /*1-bit output: Diff_n output (connect directly to top-level port)*/
                           .I(dac1_data_delay[i]) /*1-bit input: Buffer input*/
                          );
    end
endgenerate
/***********************************************************************************************************/



/***********************************************例化时钟oserdes**********************************************/
wire dac1_clk;
wire dac1_clk_delay;
OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
            .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
            .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
            .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
            .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
            .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
           ) OSERDESE3_clk1 (.OQ(dac1_clk),           /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                             .T_OUT(),                /*1-bit output: 3-state control output to IOB*/
                             .CLK(clk_500m),          /*串行数据时钟(DDR模式)*/
                             .CLKDIV(clk_125m),       /*并行数据时钟*/
                             .D(8'b10101010),         /*并行数据输入*/
                             .RST(rst[0]||dclk_en_1), /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                             .T(1'b0)                 /*1-bit input: Tristate input from fabric*/
                            );

ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
           .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
           .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
           .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
           .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
           .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
           .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
           .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
           .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
          ) ODELAYE3_clk1 (.CASC_OUT(),                  /*Cascade delay output to IDELAY input cascade*/
                           .CNTVALUEOUT(delay_result_1), /*Counter value output*/
                           .DATAOUT(dac1_clk_delay),     /*经过延迟的输出数据*/
                           .CASC_IN(1'b0),               /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                           .CASC_RETURN(1'b0),           /*Cascade delay returning from slave IDELAY DATAOUT*/
                           .CE(1'b0),                    /*VARIABLE模式下调节延迟*/
                           .CLK(clk_125m),               /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                           .CNTVALUEIN(delay_value_1),   /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                           .EN_VTC(delay_vtc_1),         /*Keep delay constant over VT*/
                           .INC(1'b0),                   /*VARIABLE模式下调节延迟*/
                           .LOAD(delay_load_1),          /*VAR_LOAD模式下调节延迟*/
                           .ODATAIN(dac1_clk),           /*输入数据*/
                           .RST(rst[0]||dclk_en_1)       /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                          );

OBUFDS OBUFDS_clk1 (.O(dac1_dclk_p),   /*1-bit output: Diff_p output (connect directly to top-level port)*/
                    .OB(dac1_dclk_n),  /*1-bit output: Diff_n output (connect directly to top-level port)*/
                    .I(dac1_clk_delay) /*1-bit input: Buffer input*/
                   );
/***********************************************************************************************************/



/**********************************************例化sync-oserdes*********************************************/
wire sync_1;
wire sync1_delay;

OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
            .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
            .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
            .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
            .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
            .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
           ) OSERDESE3_sync1 (.OQ(sync_1),       /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                              .T_OUT(),          /*1-bit output: 3-state control output to IOB*/
                              .CLK(clk_500m),    /*串行数据时钟(DDR模式)*/
                              .CLKDIV(clk_125m), /*并行数据时钟*/
                              .D(sync1_data),    /*并行数据输入*/
                              .RST(rst[0]),      /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                              .T(1'b0)           /*1-bit input: Tristate input from fabric*/
                             );

ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
           .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
           .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
           .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
           .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
           .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
           .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
           .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
           .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
          ) ODELAYE3_sync1 (.CASC_OUT(),            /*Cascade delay output to IDELAY input cascade*/
                            .CNTVALUEOUT(),         /*Counter value output*/
                            .DATAOUT(sync1_delay),  /*经过延迟的输出数据*/
                            .CASC_IN(1'b0),         /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                            .CASC_RETURN(1'b0),     /*Cascade delay returning from slave IDELAY DATAOUT*/
                            .CE(1'b0),              /*VARIABLE模式下调节延迟*/
                            .CLK(clk_125m),         /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                            .CNTVALUEIN(0),         /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                            .EN_VTC(1'b1),          /*Keep delay constant over VT; When DELAY_FORMAT is TIME, EN_VTC must be pulled High*/
                            .INC(1'b0),             /*VARIABLE模式下调节延迟*/
                            .LOAD(1'b0),            /*VAR_LOAD模式下调节延迟*/
                            .ODATAIN(sync_1),       /*输入数据*/
                            .RST(rst[0]||sync_en_1) /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                           );
      
OBUFDS OBUFDS_sync1 (.O(dac1_sync_p),  /*1-bit output: Diff_p output (connect directly to top-level port)*/
                     .OB(dac1_sync_n), /*1-bit output: Diff_n output (connect directly to top-level port)*/
                     .I(sync1_delay)   /*1-bit input: Buffer input*/
                    );
/***********************************************************************************************************/


  
/*********************************************例化16路数据oserdes********************************************/
wire [15:0] s7_2,s6_2,s5_2,s4_2,s3_2,s2_2,s1_2,s0_2;
wire [15:0] dac2_data;
wire [15:0] dac2_data_delay;
assign s7_2=dds2_in[127:112];
assign s6_2=dds2_in[111:96];
assign s5_2=dds2_in[95:80];
assign s4_2=dds2_in[79:64];
assign s3_2=dds2_in[63:48];
assign s2_2=dds2_in[47:32];
assign s1_2=dds2_in[31:16];
assign s0_2=dds2_in[15:0];
                                    
generate
  for(i=0;i<=15;i=i+1)
    begin
      OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
                  .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
                  .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
                  .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
                  .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
                  .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
                 ) OSERDESE3_data2 (.OQ(dac2_data[i]),                                                     /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                                    .T_OUT(),                                                              /*1-bit output: 3-state control output to IOB*/
                                    .CLK(clk_500m),                                                        /*串行数据时钟(DDR模式)*/
                                    .CLKDIV(clk_125m),                                                     /*并行数据时钟*/
                                    .D({s7_2[i],s6_2[i],s5_2[i],s4_2[i],s3_2[i],s2_2[i],s1_2[i],s0_2[i]}), /*并行数据输入*/
                                    .RST(rst[0]||data_en_2),                                               /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                                    .T(1'b0)                                                               /*1-bit input: Tristate input from fabric*/
                                   );

      ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
                 .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
                 .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
                 .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
                 .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
                 .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
                 .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
                 .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
                 .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
                ) ODELAYE3_data2 (.CASC_OUT(),                  /*Cascade delay output to IDELAY input cascade*/
                                  .CNTVALUEOUT(),               /*Counter value output*/
                                  .DATAOUT(dac2_data_delay[i]), /*经过延迟的输出数据*/
                                  .CASC_IN(1'b0),               /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                                  .CASC_RETURN(1'b0),           /*Cascade delay returning from slave IDELAY DATAOUT*/
                                  .CE(1'b0),                    /*VARIABLE模式下调节延迟*/
                                  .CLK(clk_125m),               /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                                  .CNTVALUEIN(0),               /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                                  .EN_VTC(1'b1),                /*Keep delay constant over VT; When DELAY_FORMAT is TIME, EN_VTC must be pulled High*/
                                  .INC(1'b0),                   /*VARIABLE模式下调节延迟*/
                                  .LOAD(1'b0),                  /*VAR_LOAD模式下调节延迟*/
                                  .ODATAIN(dac2_data[i]),       /*输入数据*/
                                  .RST(rst[0]||data_en_2)       /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                                 );
      
      OBUFDS OBUFDS_data2 (.O(dac2_data_p[i]),    /*1-bit output: Diff_p output (connect directly to top-level port)*/
                           .OB(dac2_data_n[i]),   /*1-bit output: Diff_n output (connect directly to top-level port)*/
                           .I(dac2_data_delay[i]) /*1-bit input: Buffer input*/
                          );
    end
endgenerate
/***********************************************************************************************************/



/***********************************************例化时钟oserdes**********************************************/
wire dac2_clk;
wire dac2_clk_delay;
OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
            .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
            .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
            .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
            .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
            .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
           ) OSERDESE3_clk2 (.OQ(dac2_clk),           /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                             .T_OUT(),                /*1-bit output: 3-state control output to IOB*/
                             .CLK(clk_500m),          /*串行数据时钟(DDR模式)*/
                             .CLKDIV(clk_125m),       /*并行数据时钟*/
                             .D(8'b10101010),         /*并行数据输入*/
                             .RST(rst[0]||dclk_en_2), /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                             .T(1'b0)                 /*1-bit input: Tristate input from fabric*/
                            );

ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
           .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
           .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
           .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
           .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
           .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
           .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
           .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
           .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
          ) ODELAYE3_clk2 (.CASC_OUT(),                  /*Cascade delay output to IDELAY input cascade*/
                           .CNTVALUEOUT(delay_result_2), /*Counter value output*/
                           .DATAOUT(dac2_clk_delay),     /*经过延迟的输出数据*/
                           .CASC_IN(1'b0),               /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                           .CASC_RETURN(1'b0),           /*Cascade delay returning from slave IDELAY DATAOUT*/
                           .CE(1'b0),                    /*VARIABLE模式下调节延迟*/
                           .CLK(clk_125m),               /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                           .CNTVALUEIN(delay_value_2),   /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                           .EN_VTC(delay_vtc_2),         /*Keep delay constant over VT*/
                           .INC(1'b0),                   /*VARIABLE模式下调节延迟*/
                           .LOAD(delay_load_2),          /*VAR_LOAD模式下调节延迟*/
                           .ODATAIN(dac2_clk),           /*输入数据*/
                           .RST(rst[0]||dclk_en_2)       /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                          );

OBUFDS OBUFDS_clk2 (.O(dac2_dclk_p),   /*1-bit output: Diff_p output (connect directly to top-level port)*/
                    .OB(dac2_dclk_n),  /*1-bit output: Diff_n output (connect directly to top-level port)*/
                    .I(dac2_clk_delay) /*1-bit input: Buffer input*/
                   );
/***********************************************************************************************************/



/**********************************************例化sync-oserdes*********************************************/
wire sync_2;
wire sync2_delay;

OSERDESE3 #(.DATA_WIDTH(8),                /*并行输入位宽(4或8)*/
            .INIT(1'b0),                   /*Initialization value of the OSERDES flip-flops*/
            .IS_CLKDIV_INVERTED(1'b0),     /*设置为1时,将CLKDIV内部反转*/
            .IS_CLK_INVERTED(1'b0),        /*设置为1时,将CLK内部反转*/
            .IS_RST_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
            .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
           ) OSERDESE3_sync2 (.OQ(sync_2),       /*串行数据输出(按照D[0]、D[1]、D[2]...的顺序输出)*/
                              .T_OUT(),          /*1-bit output: 3-state control output to IOB*/
                              .CLK(clk_500m),    /*串行数据时钟(DDR模式)*/
                              .CLKDIV(clk_125m), /*并行数据时钟*/
                              .D(sync2_data),    /*并行数据输入*/
                              .RST(rst[0]),      /*高电平异步复位(取决于IS_RST_INVERTED参数)*/
                              .T(1'b0)           /*1-bit input: Tristate input from fabric*/
                             );

ODELAYE3 #(.CASCADE("NONE"),               /*Cascade setting (MASTER,NONE,SLAVE_END,SLAVE_MIDDLE)*/ 
           .DELAY_FORMAT("TIME"),          /*Cascade setting (COUNT,TIME); COUNT模式下不对延迟进行温度/电压补偿,无需使用IDELAYCTRL*/ 
           .DELAY_TYPE("VAR_LOAD"),        /*Cascade setting (FIXED,VARIABLE,VAR_LOAD); FIXED-延迟固定为DELAY_VALUE; VARIABLE-延迟通过CE及INC步进调整; VAR_LOAD-延迟通过LOAD及CNTVALUEIN直接调整*/
           .DELAY_VALUE(0),                /*延迟初值,COUNT模式时单位为tap(0-511),TIME模式时单位为ps(0-1250 for U, 0-1100 for U+)*/
           .IS_CLK_INVERTED(1'b0),         /*设置为1时,将CLK内部反转*/
           .IS_RST_INVERTED(1'b0),         /*0对应高电平复位,1对应低电平复位*/
           .REFCLK_FREQUENCY(500.0),       /*COUNT模式时保持默认值300.0; TIME模式时为IDELAYCTRL的输入时钟频率(MHz)*/
           .SIM_DEVICE("ULTRASCALE_PLUS"), /*xczu19eg属于U+系列器件*/
           .UPDATE_MODE("ASYNC")           /*Leave this attribute set to ASYNC to increment or decrement to the delay value independent of the data being received. When set otherwise (SYNC), the delay line is synchronously updated upon receiving changing input data. When no precautions are taken in the application design, the attribute set to SYNC might cause unwanted effects such as sudden data glitches in the design.*/
          ) ODELAYE3_sync2 (.CASC_OUT(),            /*Cascade delay output to IDELAY input cascade*/
                            .CNTVALUEOUT(),         /*Counter value output*/
                            .DATAOUT(sync2_delay),  /*经过延迟的输出数据*/
                            .CASC_IN(1'b0),         /*Cascade delay input from slave IDELAY CASCADE_OUT*/
                            .CASC_RETURN(1'b0),     /*Cascade delay returning from slave IDELAY DATAOUT*/
                            .CE(1'b0),              /*VARIABLE模式下调节延迟*/
                            .CLK(clk_125m),         /*All control inputs to the ODELAYE3 (LOAD, CE, and INC) are synchronous to CLK.The CLK must be the same CLK as the OSERDESE3 CLKDIV*/
                            .CNTVALUEIN(0),         /*VAR_LOAD模式下调节延迟,单位为tap(9bit,0-511)*/
                            .EN_VTC(1'b1),          /*Keep delay constant over VT; When DELAY_FORMAT is TIME, EN_VTC must be pulled High*/
                            .INC(1'b0),             /*VARIABLE模式下调节延迟*/
                            .LOAD(1'b0),            /*VAR_LOAD模式下调节延迟*/
                            .ODATAIN(sync_2),       /*输入数据*/
                            .RST(rst[0]||sync_en_2) /*高电平异步复位(取决于IS_RST_INVERTED参数),延迟值被复位为DELAY_VALUE*/
                           );
      
OBUFDS OBUFDS_sync2 (.O(dac2_sync_p),  /*1-bit output: Diff_p output (connect directly to top-level port)*/
                     .OB(dac2_sync_n), /*1-bit output: Diff_n output (connect directly to top-level port)*/
                     .I(sync2_delay)   /*1-bit input: Buffer input*/
                    );
/***********************************************************************************************************/

endmodule