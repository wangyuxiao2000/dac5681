// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module spi_regs_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 7,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire [0:0]                    soft_rst_n,
    output wire [6:0]                    chip,
    output wire [0:0]                    cpol,
    output wire [0:0]                    cpha,
    output wire [1:0]                    w_r_mode,
    output wire [5:0]                    wr_width,
    output wire [31:0]                   wr_data,
    output wire [5:0]                    rd_width,
    output wire [15:0]                   rd_target_num,
    input  wire [0:0]                    wr_done,
    input  wire [0:0]                    rd_done,
    input  wire [31:0]                   rd_data
);
//------------------------Address Info-------------------
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of soft_rst_n
//        bit 0  - soft_rst_n[0] (Read/Write)
//        others - reserved
// 0x14 : reserved
// 0x18 : Data signal of chip
//        bit 6~0 - chip[6:0] (Read/Write)
//        others  - reserved
// 0x1c : reserved
// 0x20 : Data signal of cpol
//        bit 0  - cpol[0] (Read/Write)
//        others - reserved
// 0x24 : reserved
// 0x28 : Data signal of cpha
//        bit 0  - cpha[0] (Read/Write)
//        others - reserved
// 0x2c : reserved
// 0x30 : Data signal of w_r_mode
//        bit 1~0 - w_r_mode[1:0] (Read/Write)
//        others  - reserved
// 0x34 : reserved
// 0x38 : Data signal of wr_width
//        bit 5~0 - wr_width[5:0] (Read/Write)
//        others  - reserved
// 0x3c : reserved
// 0x40 : Data signal of wr_data
//        bit 31~0 - wr_data[31:0] (Read/Write)
// 0x44 : reserved
// 0x48 : Data signal of rd_width
//        bit 5~0 - rd_width[5:0] (Read/Write)
//        others  - reserved
// 0x4c : reserved
// 0x50 : Data signal of rd_target_num
//        bit 15~0 - rd_target_num[15:0] (Read/Write)
//        others   - reserved
// 0x54 : reserved
// 0x58 : Data signal of wr_done
//        bit 0  - wr_done[0] (Read)
//        others - reserved
// 0x5c : reserved
// 0x68 : Data signal of rd_done
//        bit 0  - rd_done[0] (Read)
//        others - reserved
// 0x6c : reserved
// 0x78 : Data signal of rd_data
//        bit 31~0 - rd_data[31:0] (Read)
// 0x7c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_SOFT_RST_N_DATA_0    = 7'h10,
    ADDR_SOFT_RST_N_CTRL      = 7'h14,
    ADDR_CHIP_DATA_0          = 7'h18,
    ADDR_CHIP_CTRL            = 7'h1c,
    ADDR_CPOL_DATA_0          = 7'h20,
    ADDR_CPOL_CTRL            = 7'h24,
    ADDR_CPHA_DATA_0          = 7'h28,
    ADDR_CPHA_CTRL            = 7'h2c,
    ADDR_W_R_MODE_DATA_0      = 7'h30,
    ADDR_W_R_MODE_CTRL        = 7'h34,
    ADDR_WR_WIDTH_DATA_0      = 7'h38,
    ADDR_WR_WIDTH_CTRL        = 7'h3c,
    ADDR_WR_DATA_DATA_0       = 7'h40,
    ADDR_WR_DATA_CTRL         = 7'h44,
    ADDR_RD_WIDTH_DATA_0      = 7'h48,
    ADDR_RD_WIDTH_CTRL        = 7'h4c,
    ADDR_RD_TARGET_NUM_DATA_0 = 7'h50,
    ADDR_RD_TARGET_NUM_CTRL   = 7'h54,
    ADDR_WR_DONE_DATA_0       = 7'h58,
    ADDR_WR_DONE_CTRL         = 7'h5c,
    ADDR_RD_DONE_DATA_0       = 7'h68,
    ADDR_RD_DONE_CTRL         = 7'h6c,
    ADDR_RD_DATA_DATA_0       = 7'h78,
    ADDR_RD_DATA_CTRL         = 7'h7c,
    WRIDLE                    = 2'd0,
    WRDATA                    = 2'd1,
    WRRESP                    = 2'd2,
    WRRESET                   = 2'd3,
    RDIDLE                    = 2'd0,
    RDDATA                    = 2'd1,
    RDRESET                   = 2'd2,
    ADDR_BITS                = 7;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg  [0:0]                    int_soft_rst_n = 'b0;
    reg  [6:0]                    int_chip = 'b0;
    reg  [0:0]                    int_cpol = 'b0;
    reg  [0:0]                    int_cpha = 'b0;
    reg  [1:0]                    int_w_r_mode = 'b0;
    reg  [5:0]                    int_wr_width = 'b0;
    reg  [31:0]                   int_wr_data = 'b0;
    reg  [5:0]                    int_rd_width = 'b0;
    reg  [15:0]                   int_rd_target_num = 'b0;
    reg  [0:0]                    int_wr_done = 'b0;
    reg  [0:0]                    int_rd_done = 'b0;
    reg  [31:0]                   int_rd_data = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_SOFT_RST_N_DATA_0: begin
                    rdata <= int_soft_rst_n[0:0];
                end
                ADDR_CHIP_DATA_0: begin
                    rdata <= int_chip[6:0];
                end
                ADDR_CPOL_DATA_0: begin
                    rdata <= int_cpol[0:0];
                end
                ADDR_CPHA_DATA_0: begin
                    rdata <= int_cpha[0:0];
                end
                ADDR_W_R_MODE_DATA_0: begin
                    rdata <= int_w_r_mode[1:0];
                end
                ADDR_WR_WIDTH_DATA_0: begin
                    rdata <= int_wr_width[5:0];
                end
                ADDR_WR_DATA_DATA_0: begin
                    rdata <= int_wr_data[31:0];
                end
                ADDR_RD_WIDTH_DATA_0: begin
                    rdata <= int_rd_width[5:0];
                end
                ADDR_RD_TARGET_NUM_DATA_0: begin
                    rdata <= int_rd_target_num[15:0];
                end
                ADDR_WR_DONE_DATA_0: begin
                    rdata <= int_wr_done[0:0];
                end
                ADDR_RD_DONE_DATA_0: begin
                    rdata <= int_rd_done[0:0];
                end
                ADDR_RD_DATA_DATA_0: begin
                    rdata <= int_rd_data[31:0];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign soft_rst_n    = int_soft_rst_n;
assign chip          = int_chip;
assign cpol          = int_cpol;
assign cpha          = int_cpha;
assign w_r_mode      = int_w_r_mode;
assign wr_width      = int_wr_width;
assign wr_data       = int_wr_data;
assign rd_width      = int_rd_width;
assign rd_target_num = int_rd_target_num;
// int_soft_rst_n[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_soft_rst_n[0:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_SOFT_RST_N_DATA_0)
            int_soft_rst_n[0:0] <= (WDATA[31:0] & wmask) | (int_soft_rst_n[0:0] & ~wmask);
    end
end

// int_chip[6:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_chip[6:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CHIP_DATA_0)
            int_chip[6:0] <= (WDATA[31:0] & wmask) | (int_chip[6:0] & ~wmask);
    end
end

// int_cpol[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cpol[0:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CPOL_DATA_0)
            int_cpol[0:0] <= (WDATA[31:0] & wmask) | (int_cpol[0:0] & ~wmask);
    end
end

// int_cpha[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cpha[0:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CPHA_DATA_0)
            int_cpha[0:0] <= (WDATA[31:0] & wmask) | (int_cpha[0:0] & ~wmask);
    end
end

// int_w_r_mode[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_w_r_mode[1:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_W_R_MODE_DATA_0)
            int_w_r_mode[1:0] <= (WDATA[31:0] & wmask) | (int_w_r_mode[1:0] & ~wmask);
    end
end

// int_wr_width[5:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wr_width[5:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_WR_WIDTH_DATA_0)
            int_wr_width[5:0] <= (WDATA[31:0] & wmask) | (int_wr_width[5:0] & ~wmask);
    end
end

// int_wr_data[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wr_data[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_WR_DATA_DATA_0)
            int_wr_data[31:0] <= (WDATA[31:0] & wmask) | (int_wr_data[31:0] & ~wmask);
    end
end

// int_rd_width[5:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rd_width[5:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_RD_WIDTH_DATA_0)
            int_rd_width[5:0] <= (WDATA[31:0] & wmask) | (int_rd_width[5:0] & ~wmask);
    end
end

// int_rd_target_num[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rd_target_num[15:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_RD_TARGET_NUM_DATA_0)
            int_rd_target_num[15:0] <= (WDATA[31:0] & wmask) | (int_rd_target_num[15:0] & ~wmask);
    end
end

// int_wr_done
always @(posedge ACLK) begin
    if (ARESET)
        int_wr_done <= 0;
    else if (ACLK_EN) begin
            int_wr_done <= wr_done;
    end
end

// int_rd_done
always @(posedge ACLK) begin
    if (ARESET)
        int_rd_done <= 0;
    else if (ACLK_EN) begin
            int_rd_done <= rd_done;
    end
end

// int_rd_data
always @(posedge ACLK) begin
    if (ARESET)
        int_rd_data <= 0;
    else if (ACLK_EN) begin
            int_rd_data <= rd_data;
    end
end


//------------------------Memory logic-------------------

endmodule
