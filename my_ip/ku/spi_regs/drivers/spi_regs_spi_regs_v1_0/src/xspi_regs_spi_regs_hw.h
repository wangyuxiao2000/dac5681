// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// spi_regs_control
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

#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_SOFT_RST_N_DATA    0x10
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_SOFT_RST_N_DATA    1
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CHIP_DATA          0x18
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_CHIP_DATA          7
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPOL_DATA          0x20
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_CPOL_DATA          1
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPHA_DATA          0x28
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_CPHA_DATA          1
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_W_R_MODE_DATA      0x30
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_W_R_MODE_DATA      2
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_WIDTH_DATA      0x38
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_WR_WIDTH_DATA      6
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_DATA_DATA       0x40
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_WR_DATA_DATA       32
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_WIDTH_DATA      0x48
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_RD_WIDTH_DATA      6
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_TARGET_NUM_DATA 0x50
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_RD_TARGET_NUM_DATA 16
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_DONE_DATA       0x58
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_WR_DONE_DATA       1
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_DONE_DATA       0x68
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_RD_DONE_DATA       1
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_DATA_DATA       0x78
#define XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_BITS_RD_DATA_DATA       32

