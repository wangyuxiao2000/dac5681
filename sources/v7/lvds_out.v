/*************************************************************/
//function: dac5681-lvds接口驱动
//Author  : WangYuxiao
//Email   : wyxee2000@163.com
//Data    : 2024.9.20
//Version : V 1.0
/*************************************************************/
`timescale 1 ns / 1 ps

module lvds_out (clk_500m,clk_200m,clk_125m,rst_n,sync_en_1,dclk_en_1,data_en_1,sync1_data,dds1_in,delay_load_1,delay_vtc_1,delay_value_1,delay_result_1,dac1_sync_p,dac1_sync_n,dac1_dclk_p,dac1_dclk_n,dac1_data_p,dac1_data_n,sync_en_2,dclk_en_2,data_en_2,sync2_data,dds2_in,delay_load_2,delay_vtc_2,delay_value_2,delay_result_2,dac2_sync_p,dac2_sync_n,dac2_dclk_p,dac2_dclk_n,dac2_data_p,dac2_data_n,delay_rd);
input clk_500m;  /*串行数据时钟(1Gbps线速率,对应DDR时钟为500m)*/
input clk_200m;  /*IDELAYCTRL参考时钟*/
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

(* IODELAY_GROUP = "ODELAY_CTRL" *)
IDELAYCTRL IDELAYCTRL_inst (.RDY(delay_rd),    /*Ready output*/
                            .REFCLK(clk_200m), /*时钟输入*/
                            .RST(!rst_n)       /*高电平异步复位*/
                           );
                                    
genvar i;
generate
  for(i=0;i<=15;i=i+1)
    begin
      OSERDESE2 #(
        .DATA_RATE_OQ("DDR"),   // DDR, SDR
        .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
        .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
        .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
        .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
        .SERDES_MODE("MASTER"), // MASTER, SLAVE
        .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
        .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
        .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
        .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
        .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
      ) OSERDESE2_data1 (.OFB(),            // 1-bit output: Feedback path for data
                         .OQ(dac1_data[i]), // 1-bit output: Data path output
                         // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                         .SHIFTOUT1(),
                         .SHIFTOUT2(),
                         .TBYTEOUT(),       // 1-bit output: Byte group tristate
                         .TFB(),            // 1-bit output: 3-state control
                         .TQ(),             // 1-bit output: 3-state control
                         .CLK(clk_500m),    // 1-bit input: High speed clock
                         .CLKDIV(clk_125m), // 1-bit input: Divided clock
                         // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                         .D1(s0_1[i]),
                         .D2(s1_1[i]),
                         .D3(s2_1[i]),
                         .D4(s3_1[i]),
                         .D5(s4_1[i]),
                         .D6(s5_1[i]),
                         .D7(s6_1[i]),
                         .D8(s7_1[i]),
                         .OCE(1'b1),              // 1-bit input: Output data clock enable
                         .RST(!rst_n||data_en_1), // 1-bit input: Reset
                         // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                         .SHIFTIN1(1'b0),
                         .SHIFTIN2(1'b0),
                         // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                         .T1(1'b0),
                         .T2(1'b0),
                         .T3(1'b0),
                         .T4(1'b0),
                         .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                         .TCE(1'b0)      // 1-bit input: 3-state clock enable
                        );

      (* IODELAY_GROUP = "ODELAY_CTRL" *)
      ODELAYE2 #(
         .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
         .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
         .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
         .ODELAY_TYPE("FIXED"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
         .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
         .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
         .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
         .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
      ) ODELAYE2_data1 (.CNTVALUEOUT(),               // 5-bit output: Counter value output
                        .DATAOUT(dac1_data_delay[i]), // 1-bit output: Delayed data/clock output
                        .C(clk_125m),                 // 1-bit input: Clock input
                        .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                        .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                        .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                        .CNTVALUEIN(0),               // 5-bit input: Counter value input
                        .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                        .LD(1'b0),                    // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                        .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                        .ODATAIN(dac1_data[i]),       // 1-bit input: Output delay data input
                        .REGRST(!rst_n||data_en_1)    // 1-bit input: Active-high reset tap-delay input
                       );

      OBUFDS #(
        .IOSTANDARD("LVDS"),
        .SLEW("FAST") 
      ) OBUFDS_data1 (.O(dac1_data_p[i]),
                      .OB(dac1_data_n[i]), 
                      .I(dac1_data_delay[i])
                     );
    end
endgenerate
/***********************************************************************************************************/



/***********************************************例化时钟oserdes**********************************************/
wire dac1_clk;
wire dac1_clk_delay;
OSERDESE2 #(
  .DATA_RATE_OQ("DDR"),   // DDR, SDR
  .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
  .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
  .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
  .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
  .SERDES_MODE("MASTER"), // MASTER, SLAVE
  .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
  .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
  .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
  .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
  .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
) OSERDESE2_clk1 (.OFB(),            // 1-bit output: Feedback path for data
                  .OQ(dac1_clk),     // 1-bit output: Data path output
                  // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                  .SHIFTOUT1(),
                  .SHIFTOUT2(),
                  .TBYTEOUT(),       // 1-bit output: Byte group tristate
                  .TFB(),            // 1-bit output: 3-state control
                  .TQ(),             // 1-bit output: 3-state control
                  .CLK(clk_500m),    // 1-bit input: High speed clock
                  .CLKDIV(clk_125m), // 1-bit input: Divided clock
                  // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                  .D1(1'b0),
                  .D2(1'b1),
                  .D3(1'b0),
                  .D4(1'b1),
                  .D5(1'b0),
                  .D6(1'b1),
                  .D7(1'b0),
                  .D8(1'b1),
                  .OCE(1'b1),              // 1-bit input: Output data clock enable
                  .RST(!rst_n||dclk_en_1), // 1-bit input: Reset
                  // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                  .SHIFTIN1(1'b0),
                  .SHIFTIN2(1'b0),
                  // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                  .T1(1'b0),
                  .T2(1'b0),
                  .T3(1'b0),
                  .T4(1'b0),
                  .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                  .TCE(1'b0)      // 1-bit input: 3-state clock enable
                 );

(* IODELAY_GROUP = "ODELAY_CTRL" *)
ODELAYE2 #(
   .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
   .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
   .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
   .ODELAY_TYPE("VAR_LOAD"),        // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
   .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
   .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
   .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
   .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
) ODELAYE2_clk1 (.CNTVALUEOUT(delay_result_1), // 5-bit output: Counter value output
                 .DATAOUT(dac1_clk_delay),     // 1-bit output: Delayed data/clock output
                 .C(clk_125m),                 // 1-bit input: Clock input
                 .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                 .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                 .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                 .CNTVALUEIN(delay_value_1),   // 5-bit input: Counter value input
                 .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                 .LD(delay_load_1),            // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                 .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                 .ODATAIN(dac1_clk),           // 1-bit input: Output delay data input
                 .REGRST(!rst_n||dclk_en_1)    // 1-bit input: Active-high reset tap-delay input
                );

OBUFDS #(
  .IOSTANDARD("LVDS"),
  .SLEW("FAST") 
) OBUFDS_clk1 (.O(dac1_dclk_p),
               .OB(dac1_dclk_n), 
               .I(dac1_clk_delay)
              );
/***********************************************************************************************************/



/**********************************************例化sync-oserdes*********************************************/
wire sync_1;
wire sync1_delay;

OSERDESE2 #(
  .DATA_RATE_OQ("DDR"),   // DDR, SDR
  .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
  .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
  .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
  .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
  .SERDES_MODE("MASTER"), // MASTER, SLAVE
  .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
  .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
  .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
  .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
  .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
) OSERDESE2_sync1 (.OFB(),            // 1-bit output: Feedback path for data
                   .OQ(sync_1),      // 1-bit output: Data path output
                   // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                   .SHIFTOUT1(),
                   .SHIFTOUT2(),
                   .TBYTEOUT(),       // 1-bit output: Byte group tristate
                   .TFB(),            // 1-bit output: 3-state control
                   .TQ(),             // 1-bit output: 3-state control
                   .CLK(clk_500m),    // 1-bit input: High speed clock
                   .CLKDIV(clk_125m), // 1-bit input: Divided clock
                   // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                   .D1(sync1_data[0]),
                   .D2(sync1_data[1]),
                   .D3(sync1_data[2]),
                   .D4(sync1_data[3]),
                   .D5(sync1_data[4]),
                   .D6(sync1_data[5]),
                   .D7(sync1_data[6]),
                   .D8(sync1_data[7]),
                   .OCE(1'b1),        // 1-bit input: Output data clock enable
                   .RST(!rst_n),      // 1-bit input: Reset
                   // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                   .SHIFTIN1(1'b0),
                   .SHIFTIN2(1'b0),
                   // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                   .T1(1'b0),
                   .T2(1'b0),
                   .T3(1'b0),
                   .T4(1'b0),
                   .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                   .TCE(1'b0)      // 1-bit input: 3-state clock enable
                  );

(* IODELAY_GROUP = "ODELAY_CTRL" *)
ODELAYE2 #(
   .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
   .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
   .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
   .ODELAY_TYPE("FIXED"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
   .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
   .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
   .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
   .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
) ODELAYE2_sync1 (.CNTVALUEOUT(),               // 5-bit output: Counter value output
                  .DATAOUT(sync1_delay),        // 1-bit output: Delayed data/clock output
                  .C(clk_125m),                 // 1-bit input: Clock input
                  .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                  .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                  .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                  .CNTVALUEIN(0),               // 5-bit input: Counter value input
                  .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                  .LD(1'b0),                    // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                  .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                  .ODATAIN(sync_1),             // 1-bit input: Output delay data input
                  .REGRST(!rst_n||sync_en_1)    // 1-bit input: Active-high reset tap-delay input
                 );

OBUFDS #(
  .IOSTANDARD("LVDS"),
  .SLEW("FAST") 
) OBUFDS_sync1 (.O(dac1_sync_p),
               .OB(dac1_sync_n), 
               .I(sync1_delay)
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
      OSERDESE2 #(
        .DATA_RATE_OQ("DDR"),   // DDR, SDR
        .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
        .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
        .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
        .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
        .SERDES_MODE("MASTER"), // MASTER, SLAVE
        .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
        .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
        .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
        .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
        .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
      ) OSERDESE2_data2 (.OFB(),            // 1-bit output: Feedback path for data
                         .OQ(dac2_data[i]), // 1-bit output: Data path output
                         // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                         .SHIFTOUT1(),
                         .SHIFTOUT2(),
                         .TBYTEOUT(),       // 1-bit output: Byte group tristate
                         .TFB(),            // 1-bit output: 3-state control
                         .TQ(),             // 1-bit output: 3-state control
                         .CLK(clk_500m),    // 1-bit input: High speed clock
                         .CLKDIV(clk_125m), // 1-bit input: Divided clock
                         // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                         .D1(s0_2[i]),
                         .D2(s1_2[i]),
                         .D3(s2_2[i]),
                         .D4(s3_2[i]),
                         .D5(s4_2[i]),
                         .D6(s5_2[i]),
                         .D7(s6_2[i]),
                         .D8(s7_2[i]),
                         .OCE(1'b1),                   // 1-bit input: Output data clock enable
                         .RST(!rst_n||data_en_2),      // 1-bit input: Reset
                         // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                         .SHIFTIN1(1'b0),
                         .SHIFTIN2(1'b0),
                         // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                         .T1(1'b0),
                         .T2(1'b0),
                         .T3(1'b0),
                         .T4(1'b0),
                         .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                         .TCE(1'b0)      // 1-bit input: 3-state clock enable
                        );

      (* IODELAY_GROUP = "ODELAY_CTRL" *)
      ODELAYE2 #(
         .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
         .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
         .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
         .ODELAY_TYPE("FIXED"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
         .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
         .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
         .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
         .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
      ) ODELAYE2_data2 (.CNTVALUEOUT(),               // 5-bit output: Counter value output
                        .DATAOUT(dac2_data_delay[i]), // 1-bit output: Delayed data/clock output
                        .C(clk_125m),                 // 1-bit input: Clock input
                        .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                        .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                        .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                        .CNTVALUEIN(0),               // 5-bit input: Counter value input
                        .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                        .LD(1'b0),                    // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                        .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                        .ODATAIN(dac2_data[i]),       // 1-bit input: Output delay data input
                        .REGRST(!rst_n||data_en_2)    // 1-bit input: Active-high reset tap-delay input
                       );

      OBUFDS #(
        .IOSTANDARD("LVDS"),
        .SLEW("FAST") 
      ) OBUFDS_data2 (.O(dac2_data_p[i]),
                      .OB(dac2_data_n[i]), 
                      .I(dac2_data_delay[i])
                     );
    end
endgenerate
/***********************************************************************************************************/



/***********************************************例化时钟oserdes**********************************************/
wire dac2_clk;
wire dac2_clk_delay;

OSERDESE2 #(
  .DATA_RATE_OQ("DDR"),   // DDR, SDR
  .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
  .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
  .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
  .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
  .SERDES_MODE("MASTER"), // MASTER, SLAVE
  .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
  .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
  .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
  .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
  .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
) OSERDESE2_clk2 (.OFB(),            // 1-bit output: Feedback path for data
                  .OQ(dac2_clk),     // 1-bit output: Data path output
                  // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                  .SHIFTOUT1(),
                  .SHIFTOUT2(),
                  .TBYTEOUT(),       // 1-bit output: Byte group tristate
                  .TFB(),            // 1-bit output: 3-state control
                  .TQ(),             // 1-bit output: 3-state control
                  .CLK(clk_500m),    // 1-bit input: High speed clock
                  .CLKDIV(clk_125m), // 1-bit input: Divided clock
                  // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                  .D1(1'b0),
                  .D2(1'b1),
                  .D3(1'b0),
                  .D4(1'b1),
                  .D5(1'b0),
                  .D6(1'b1),
                  .D7(1'b0),
                  .D8(1'b1),
                  .OCE(1'b1),              // 1-bit input: Output data clock enable
                  .RST(!rst_n||dclk_en_2), // 1-bit input: Reset
                  // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                  .SHIFTIN1(1'b0),
                  .SHIFTIN2(1'b0),
                  // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                  .T1(1'b0),
                  .T2(1'b0),
                  .T3(1'b0),
                  .T4(1'b0),
                  .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                  .TCE(1'b0)      // 1-bit input: 3-state clock enable
                 );

(* IODELAY_GROUP = "ODELAY_CTRL" *)
ODELAYE2 #(
   .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
   .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
   .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
   .ODELAY_TYPE("VAR_LOAD"),        // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
   .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
   .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
   .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
   .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
) ODELAYE2_clk2 (.CNTVALUEOUT(delay_result_2), // 5-bit output: Counter value output
                 .DATAOUT(dac2_clk_delay),     // 1-bit output: Delayed data/clock output
                 .C(clk_125m),                 // 1-bit input: Clock input
                 .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                 .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                 .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                 .CNTVALUEIN(delay_value_2),   // 5-bit input: Counter value input
                 .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                 .LD(delay_load_2),            // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                 .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                 .ODATAIN(dac2_clk),           // 1-bit input: Output delay data input
                 .REGRST(!rst_n||dclk_en_2)    // 1-bit input: Active-high reset tap-delay input
                );

OBUFDS #(
  .IOSTANDARD("LVDS"),
  .SLEW("FAST") 
) OBUFDS_clk2 (.O(dac2_dclk_p),
               .OB(dac2_dclk_n), 
               .I(dac2_clk_delay)
              );
/***********************************************************************************************************/



/**********************************************例化sync-oserdes*********************************************/
wire sync_2;
wire sync2_delay;

OSERDESE2 #(
  .DATA_RATE_OQ("DDR"),   // DDR, SDR
  .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
  .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
  .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
  .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
  .SERDES_MODE("MASTER"), // MASTER, SLAVE
  .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
  .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
  .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
  .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
  .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
) OSERDESE2_sync2 (.OFB(),            // 1-bit output: Feedback path for data
                   .OQ(sync_2),       // 1-bit output: Data path output
                   // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
                   .SHIFTOUT1(),
                   .SHIFTOUT2(),
                   .TBYTEOUT(),       // 1-bit output: Byte group tristate
                   .TFB(),            // 1-bit output: 3-state control
                   .TQ(),             // 1-bit output: 3-state control
                   .CLK(clk_500m),    // 1-bit input: High speed clock
                   .CLKDIV(clk_125m), // 1-bit input: Divided clock
                   // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
                   .D1(sync2_data[0]),
                   .D2(sync2_data[1]),
                   .D3(sync2_data[2]),
                   .D4(sync2_data[3]),
                   .D5(sync2_data[4]),
                   .D6(sync2_data[5]),
                   .D7(sync2_data[6]),
                   .D8(sync2_data[7]),
                   .OCE(1'b1),        // 1-bit input: Output data clock enable
                   .RST(!rst_n),      // 1-bit input: Reset
                   // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
                   .SHIFTIN1(1'b0),
                   .SHIFTIN2(1'b0),
                   // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
                   .T1(1'b0),
                   .T2(1'b0),
                   .T3(1'b0),
                   .T4(1'b0),
                   .TBYTEIN(1'b0), // 1-bit input: Byte group tristate
                   .TCE(1'b0)      // 1-bit input: 3-state clock enable
                  );

(* IODELAY_GROUP = "ODELAY_CTRL" *)
ODELAYE2 #(
   .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
   .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
   .HIGH_PERFORMANCE_MODE("TRUE"),  // Reduced jitter ("TRUE"), Reduced power ("FALSE")
   .ODELAY_TYPE("FIXED"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
   .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
   .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
   .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
   .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
) ODELAYE2_sync2 (.CNTVALUEOUT(),               // 5-bit output: Counter value output
                  .DATAOUT(sync2_delay),        // 1-bit output: Delayed data/clock output
                  .C(clk_125m),                 // 1-bit input: Clock input
                  .CE(1'b0),                    // 1-bit input: Active high enable increment/decrement input
                  .CINVCTRL(1'b0),              // 1-bit input: Dynamic clock inversion input
                  .CLKIN(1'b0),                 // 1-bit input: Clock delay input
                  .CNTVALUEIN(0),               // 5-bit input: Counter value input
                  .INC(1'b0),                   // 1-bit input: Increment / Decrement tap delay input
                  .LD(1'b0),                    // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode, in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
                  .LDPIPEEN(1'b0),              // 1-bit input: Enables the pipeline register to load data
                  .ODATAIN(sync_2),             // 1-bit input: Output delay data input
                  .REGRST(!rst_n||sync_en_2)    // 1-bit input: Active-high reset tap-delay input
                 );

OBUFDS #(
  .IOSTANDARD("LVDS"),
  .SLEW("FAST") 
) OBUFDS_sync2 (.O(dac2_sync_p),
                .OB(dac2_sync_n), 
                .I(sync2_delay)
               );
/***********************************************************************************************************/

endmodule