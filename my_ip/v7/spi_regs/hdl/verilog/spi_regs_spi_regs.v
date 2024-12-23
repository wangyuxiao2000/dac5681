// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="spi_regs_spi_regs,hls_ip_2022_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7vx690t-ffg1761-2,HLS_INPUT_CLOCK=8.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=2.329000,HLS_SYN_LAT=2,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=292,HLS_SYN_LUT=322,HLS_VERSION=2022_1}" *)

module spi_regs_spi_regs (
        ap_clk,
        ap_rst_n,
        soft_rst_n_out,
        chip_out,
        cpol_out,
        cpha_out,
        w_r_mode_out,
        wr_width_out,
        rd_width_out,
        rd_target_num_out,
        wr_data_num_in,
        batch_en,
        is_r_TDATA,
        is_r_TVALID,
        is_r_TREADY,
        os_TDATA,
        os_TVALID,
        os_TREADY,
        s_axi_control_AWVALID,
        s_axi_control_AWREADY,
        s_axi_control_AWADDR,
        s_axi_control_WVALID,
        s_axi_control_WREADY,
        s_axi_control_WDATA,
        s_axi_control_WSTRB,
        s_axi_control_ARVALID,
        s_axi_control_ARREADY,
        s_axi_control_ARADDR,
        s_axi_control_RVALID,
        s_axi_control_RREADY,
        s_axi_control_RDATA,
        s_axi_control_RRESP,
        s_axi_control_BVALID,
        s_axi_control_BREADY,
        s_axi_control_BRESP
);

parameter    ap_ST_iter0_fsm_state1 = 1'd1;
parameter    ap_ST_iter1_fsm_state2 = 2'd2;
parameter    ap_ST_iter2_fsm_state3 = 2'd2;
parameter    ap_ST_iter1_fsm_state0 = 2'd1;
parameter    ap_ST_iter2_fsm_state0 = 2'd1;
parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 7;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
output  [0:0] soft_rst_n_out;
output  [6:0] chip_out;
output  [0:0] cpol_out;
output  [0:0] cpha_out;
output  [1:0] w_r_mode_out;
output  [5:0] wr_width_out;
output  [5:0] rd_width_out;
output  [15:0] rd_target_num_out;
input  [0:0] wr_data_num_in;
input  [0:0] batch_en;
input  [31:0] is_r_TDATA;
input   is_r_TVALID;
output   is_r_TREADY;
output  [31:0] os_TDATA;
output   os_TVALID;
input   os_TREADY;
input   s_axi_control_AWVALID;
output   s_axi_control_AWREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_AWADDR;
input   s_axi_control_WVALID;
output   s_axi_control_WREADY;
input  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_WDATA;
input  [C_S_AXI_CONTROL_WSTRB_WIDTH - 1:0] s_axi_control_WSTRB;
input   s_axi_control_ARVALID;
output   s_axi_control_ARREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_ARADDR;
output   s_axi_control_RVALID;
input   s_axi_control_RREADY;
output  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_RDATA;
output  [1:0] s_axi_control_RRESP;
output   s_axi_control_BVALID;
input   s_axi_control_BREADY;
output  [1:0] s_axi_control_BRESP;

 reg    ap_rst_n_inv;
wire   [0:0] soft_rst_n;
wire   [6:0] chip;
wire   [0:0] cpol;
wire   [0:0] cpha;
wire   [1:0] w_r_mode;
wire   [5:0] wr_width;
wire   [31:0] wr_data;
wire   [5:0] rd_width;
wire   [15:0] rd_target_num;
reg   [0:0] p_rd_done_V;
reg   [0:0] p_wr_done_V;
reg   [0:0] p_wr_en_V;
reg    is_r_TDATA_blk_n;
reg   [0:0] ap_CS_iter0_fsm;
wire    ap_CS_iter0_fsm_state1;
reg   [1:0] ap_CS_iter1_fsm;
wire    ap_CS_iter1_fsm_state2;
reg   [1:0] ap_CS_iter2_fsm;
wire    ap_CS_iter2_fsm_state3;
wire   [0:0] soft_rst_n_read_read_fu_164_p2;
wire   [1:0] w_r_mode_read_read_fu_220_p2;
wire   [0:0] grp_nbreadreq_fu_282_p3;
reg    os_TDATA_blk_n;
reg   [0:0] soft_rst_n_read_reg_404;
reg   [1:0] w_r_mode_read_reg_408;
reg   [0:0] p_wr_en_V_load_reg_416;
reg   [0:0] soft_rst_n_read_reg_404_pp0_iter1_reg;
reg   [1:0] w_r_mode_read_reg_408_pp0_iter1_reg;
reg   [0:0] p_wr_en_V_load_reg_416_pp0_iter1_reg;
reg   [31:0] reg_337;
reg    ap_predicate_op30_read_state1;
reg    ap_predicate_op39_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_predicate_op44_write_state2;
reg    ap_predicate_op45_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
reg    ap_predicate_op129_write_state3;
reg    ap_predicate_op134_write_state3;
wire    regslice_both_os_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_state3_io;
reg   [31:0] reg_337_pp0_iter1_reg;
wire   [0:0] p_wr_en_V_load_load_fu_342_p1;
reg   [0:0] tmp_2_reg_420;
reg   [0:0] tmp_2_reg_420_pp0_iter1_reg;
wire   [0:0] wr_data_num_in_read_read_fu_296_p2;
reg   [0:0] tmp_reg_428;
reg   [0:0] tmp_reg_428_pp0_iter1_reg;
reg   [0:0] ap_NS_iter0_fsm;
reg   [1:0] ap_NS_iter1_fsm;
reg   [1:0] ap_NS_iter2_fsm;
reg    ap_ST_iter0_fsm_state1_blk;
reg    ap_ST_iter1_fsm_state2_blk;
reg    ap_ST_iter2_fsm_state3_blk;
wire    regslice_both_is_r_U_apdone_blk;
wire   [31:0] is_r_TDATA_int_regslice;
wire    is_r_TVALID_int_regslice;
reg    is_r_TREADY_int_regslice;
wire    regslice_both_is_r_U_ack_in;
reg    os_TVALID_int_regslice;
wire    os_TREADY_int_regslice;
wire    regslice_both_os_U_vld_out;
reg    ap_condition_442;
reg    ap_condition_440;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 p_rd_done_V = 1'd0;
#0 p_wr_done_V = 1'd0;
#0 p_wr_en_V = 1'd1;
#0 ap_CS_iter0_fsm = 1'd1;
#0 ap_CS_iter1_fsm = 2'd1;
#0 ap_CS_iter2_fsm = 2'd1;
end

spi_regs_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
control_s_axi_U(
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .soft_rst_n(soft_rst_n),
    .chip(chip),
    .cpol(cpol),
    .cpha(cpha),
    .w_r_mode(w_r_mode),
    .wr_width(wr_width),
    .wr_data(wr_data),
    .rd_width(rd_width),
    .rd_target_num(rd_target_num),
    .wr_done(p_wr_done_V),
    .rd_done(p_rd_done_V),
    .rd_data(reg_337_pp0_iter1_reg)
);

spi_regs_regslice_both #(
    .DataWidth( 32 ))
regslice_both_is_r_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(is_r_TDATA),
    .vld_in(is_r_TVALID),
    .ack_in(regslice_both_is_r_U_ack_in),
    .data_out(is_r_TDATA_int_regslice),
    .vld_out(is_r_TVALID_int_regslice),
    .ack_out(is_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_is_r_U_apdone_blk)
);

spi_regs_regslice_both #(
    .DataWidth( 32 ))
regslice_both_os_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(wr_data),
    .vld_in(os_TVALID_int_regslice),
    .ack_in(os_TREADY_int_regslice),
    .data_out(os_TDATA),
    .vld_out(regslice_both_os_U_vld_out),
    .ack_out(os_TREADY),
    .apdone_blk(regslice_both_os_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_iter0_fsm <= ap_ST_iter0_fsm_state1;
    end else begin
        ap_CS_iter0_fsm <= ap_NS_iter0_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_iter1_fsm <= ap_ST_iter1_fsm_state0;
    end else begin
        ap_CS_iter1_fsm <= ap_NS_iter1_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_iter2_fsm <= ap_ST_iter2_fsm_state0;
    end else begin
        ap_CS_iter2_fsm <= ap_NS_iter2_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        p_rd_done_V <= 1'd0;
    end else begin
        if (((~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3) & (tmp_reg_428_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd0) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1)) | (~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3) & (tmp_2_reg_420_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd2) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1)))) begin
            p_rd_done_V <= 1'd1;
        end else if ((~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd0))) begin
            p_rd_done_V <= 1'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        p_wr_done_V <= 1'd0;
    end else begin
        if ((1'b1 == ap_condition_440)) begin
            if ((1'b1 == ap_condition_442)) begin
                p_wr_done_V <= 1'd1;
            end else if ((soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd0)) begin
                p_wr_done_V <= 1'd0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        p_wr_en_V <= 1'd1;
    end else begin
        if (((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (w_r_mode == 2'd2) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1) & (p_wr_en_V_load_load_fu_342_p1 == 1'd1)) | (~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (w_r_mode_read_read_fu_220_p2 == 2'd1) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1) & (p_wr_en_V_load_load_fu_342_p1 == 1'd1)))) begin
            p_wr_en_V <= 1'd0;
        end else if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (soft_rst_n_read_read_fu_164_p2 == 1'd0) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
            p_wr_en_V <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        p_wr_en_V_load_reg_416 <= p_wr_en_V;
    end
end

always @ (posedge ap_clk) begin
    if ((~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        p_wr_en_V_load_reg_416_pp0_iter1_reg <= p_wr_en_V_load_reg_416;
        reg_337_pp0_iter1_reg <= reg_337;
        soft_rst_n_read_reg_404_pp0_iter1_reg <= soft_rst_n_read_reg_404;
        tmp_2_reg_420_pp0_iter1_reg <= tmp_2_reg_420;
        tmp_reg_428_pp0_iter1_reg <= tmp_reg_428;
        w_r_mode_read_reg_408_pp0_iter1_reg <= w_r_mode_read_reg_408;
    end
end

always @ (posedge ap_clk) begin
    if (((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_predicate_op39_read_state1 == 1'b1)) | (~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_predicate_op30_read_state1 == 1'b1)))) begin
        reg_337 <= is_r_TDATA_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        soft_rst_n_read_reg_404 <= soft_rst_n;
        w_r_mode_read_reg_408 <= w_r_mode;
    end
end

always @ (posedge ap_clk) begin
    if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (w_r_mode == 2'd2) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        tmp_2_reg_420 <= grp_nbreadreq_fu_282_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (w_r_mode == 2'd0) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        tmp_reg_428 <= grp_nbreadreq_fu_282_p3;
    end
end

always @ (*) begin
    if ((((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1)))) begin
        ap_ST_iter0_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_iter0_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) begin
        ap_ST_iter1_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_iter1_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) begin
        ap_ST_iter2_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_iter2_fsm_state3_blk = 1'b0;
    end
end

always @ (*) begin
    if ((((grp_nbreadreq_fu_282_p3 == 1'd1) & (w_r_mode == 2'd2) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1)) | ((grp_nbreadreq_fu_282_p3 == 1'd1) & (w_r_mode == 2'd0) & (soft_rst_n == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1)))) begin
        is_r_TDATA_blk_n = is_r_TVALID_int_regslice;
    end else begin
        is_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_predicate_op39_read_state1 == 1'b1)) | (~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_predicate_op30_read_state1 == 1'b1)))) begin
        is_r_TREADY_int_regslice = 1'b1;
    end else begin
        is_r_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if ((((soft_rst_n_read_reg_404 == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter1_fsm_state2) & (p_wr_en_V_load_reg_416 == 1'd1) & (w_r_mode_read_reg_408 == 2'd2)) | ((soft_rst_n_read_reg_404 == 1'd1) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter1_fsm_state2) & (p_wr_en_V_load_reg_416 == 1'd1) & (w_r_mode_read_reg_408 == 2'd1)) | ((batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3) & (p_wr_en_V_load_reg_416_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd2) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1)) | ((batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3) & (p_wr_en_V_load_reg_416_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd1) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1)))) begin
        os_TDATA_blk_n = os_TREADY_int_regslice;
    end else begin
        os_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & (1'b1 == ap_CS_iter1_fsm_state2) & (ap_predicate_op45_write_state2 == 1'b1)) | (~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & (1'b1 == ap_CS_iter1_fsm_state2) & (ap_predicate_op44_write_state2 == 1'b1)))) begin
        os_TVALID_int_regslice = 1'b1;
    end else begin
        os_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_iter0_fsm)
        ap_ST_iter0_fsm_state1 : begin
            ap_NS_iter0_fsm = ap_ST_iter0_fsm_state1;
        end
        default : begin
            ap_NS_iter0_fsm = 'bx;
        end
    endcase
end

always @ (*) begin
    case (ap_CS_iter1_fsm)
        ap_ST_iter1_fsm_state2 : begin
            if ((~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & ~(((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end else if ((~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & ((1'b0 == ap_CS_iter0_fsm_state1) | ((1'b1 == ap_CS_iter0_fsm_state1) & (((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))))))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state0;
            end else begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end
        end
        ap_ST_iter1_fsm_state0 : begin
            if ((~(((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end else begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state0;
            end
        end
        default : begin
            ap_NS_iter1_fsm = 'bx;
        end
    endcase
end

always @ (*) begin
    case (ap_CS_iter2_fsm)
        ap_ST_iter2_fsm_state3 : begin
            if ((~((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & ~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
                ap_NS_iter2_fsm = ap_ST_iter2_fsm_state3;
            end else if ((~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & ((1'b0 == ap_CS_iter1_fsm_state2) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))))))) begin
                ap_NS_iter2_fsm = ap_ST_iter2_fsm_state0;
            end else begin
                ap_NS_iter2_fsm = ap_ST_iter2_fsm_state3;
            end
        end
        ap_ST_iter2_fsm_state0 : begin
            if ((~((1'b1 == ap_block_state2_io) | ((1'b1 == ap_CS_iter2_fsm_state3) & ((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)))) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1))) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
                ap_NS_iter2_fsm = ap_ST_iter2_fsm_state3;
            end else begin
                ap_NS_iter2_fsm = ap_ST_iter2_fsm_state0;
            end
        end
        default : begin
            ap_NS_iter2_fsm = 'bx;
        end
    endcase
end

assign ap_CS_iter0_fsm_state1 = ap_CS_iter0_fsm[32'd0];

assign ap_CS_iter1_fsm_state2 = ap_CS_iter1_fsm[32'd1];

assign ap_CS_iter2_fsm_state3 = ap_CS_iter2_fsm[32'd1];

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op39_read_state1 == 1'b1)) | ((is_r_TVALID_int_regslice == 1'b0) & (ap_predicate_op30_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = (((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state2 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_io = (((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_condition_440 = (~((1'b1 == ap_block_state3_io) | (regslice_both_os_U_apdone_blk == 1'b1) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op134_write_state3 == 1'b1)) | ((os_TREADY_int_regslice == 1'b0) & (ap_predicate_op129_write_state3 == 1'b1))) & (batch_en == 1'd0) & (1'b1 == ap_CS_iter2_fsm_state3));
end

always @ (*) begin
    ap_condition_442 = ((wr_data_num_in_read_read_fu_296_p2 == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd1) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op129_write_state3 = ((batch_en == 1'd0) & (p_wr_en_V_load_reg_416_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd2) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op134_write_state3 = ((batch_en == 1'd0) & (p_wr_en_V_load_reg_416_pp0_iter1_reg == 1'd1) & (w_r_mode_read_reg_408_pp0_iter1_reg == 2'd1) & (soft_rst_n_read_reg_404_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op30_read_state1 = ((grp_nbreadreq_fu_282_p3 == 1'd1) & (w_r_mode == 2'd2) & (soft_rst_n == 1'd1) & (batch_en == 1'd0));
end

always @ (*) begin
    ap_predicate_op39_read_state1 = ((grp_nbreadreq_fu_282_p3 == 1'd1) & (w_r_mode == 2'd0) & (soft_rst_n == 1'd1) & (batch_en == 1'd0));
end

always @ (*) begin
    ap_predicate_op44_write_state2 = ((soft_rst_n_read_reg_404 == 1'd1) & (batch_en == 1'd0) & (p_wr_en_V_load_reg_416 == 1'd1) & (w_r_mode_read_reg_408 == 2'd2));
end

always @ (*) begin
    ap_predicate_op45_write_state2 = ((soft_rst_n_read_reg_404 == 1'd1) & (batch_en == 1'd0) & (p_wr_en_V_load_reg_416 == 1'd1) & (w_r_mode_read_reg_408 == 2'd1));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign chip_out = chip;

assign cpha_out = cpha;

assign cpol_out = cpol;

assign grp_nbreadreq_fu_282_p3 = is_r_TVALID_int_regslice;

assign is_r_TREADY = regslice_both_is_r_U_ack_in;

assign os_TVALID = regslice_both_os_U_vld_out;

assign p_wr_en_V_load_load_fu_342_p1 = p_wr_en_V;

assign rd_target_num_out = rd_target_num;

assign rd_width_out = rd_width;

assign soft_rst_n_out = soft_rst_n;

assign soft_rst_n_read_read_fu_164_p2 = soft_rst_n;

assign w_r_mode_out = w_r_mode;

assign w_r_mode_read_read_fu_220_p2 = w_r_mode;

assign wr_data_num_in_read_read_fu_296_p2 = wr_data_num_in;

assign wr_width_out = wr_width;

endmodule //spi_regs_spi_regs
