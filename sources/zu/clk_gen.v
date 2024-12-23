/*************************************************************/
//function: OSERDESE3时钟生成
//Author  : WangYuxiao
//Email   : wyxee2000@163.com
//Data    : 2024.9.20
//Version : V 1.0
/*************************************************************/
`timescale 1 ns / 1 ps

module clk_gen (clk_500m_in,f125m_clk,f500m_clk);
input clk_500m_in; /*来自MMCM的500MHz时钟*/

output f125m_clk;  /*并行数据时钟(1Gbps线速率,8bit并串转换,对应并行数据输入速率为125m)*/
output f500m_clk;  /*串行数据时钟(1Gbps线速率,对应DDR时钟为500m)*/



/*********************************通过BUFG产生串行时钟,BUFGCE_DIV产生并行时钟*********************************/
BUFG BUFG_inst (.O(f500m_clk),
                .I(clk_500m_in)
               );

BUFGCE_DIV #(.BUFGCE_DIVIDE(4),             /*1-8*/
             .IS_CE_INVERTED(1'b0),         /*0对应高电平使能,1对应低电平使能*/
             .IS_CLR_INVERTED(1'b0),        /*0对应高电平复位,1对应低电平复位*/
             .IS_I_INVERTED(1'b0),          /*设置为1时,将输入时钟在内部反转*/
             .SIM_DEVICE("ULTRASCALE_PLUS") /*xczu19eg属于U+系列器件*/
            ) BUFGCE_DIV_inst (.O(f125m_clk),   /*1-bit output: Buffer*/
                               .CE(1'b1),      /*1-bit input: Buffer enable*/
                               .CLR(1'b0),     /*1-bit input: Asynchronous clear*/
                               .I(clk_500m_in) /*1-bit input: Buffer*/
                              );
/***********************************************************************************************************/

endmodule