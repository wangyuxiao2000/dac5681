// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xspi_regs_spi_regs.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XSpi_regs_spi_regs_CfgInitialize(XSpi_regs_spi_regs *InstancePtr, XSpi_regs_spi_regs_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Spi_regs_control_BaseAddress = ConfigPtr->Spi_regs_control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XSpi_regs_spi_regs_Set_soft_rst_n(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_SOFT_RST_N_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_soft_rst_n(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_SOFT_RST_N_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_chip(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CHIP_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_chip(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CHIP_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_cpol(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPOL_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_cpol(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPOL_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_cpha(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPHA_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_cpha(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_CPHA_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_w_r_mode(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_W_R_MODE_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_w_r_mode(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_W_R_MODE_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_wr_width(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_WIDTH_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_wr_width(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_WIDTH_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_wr_data(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_DATA_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_wr_data(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_DATA_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_rd_width(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_WIDTH_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_rd_width(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_WIDTH_DATA);
    return Data;
}

void XSpi_regs_spi_regs_Set_rd_target_num(XSpi_regs_spi_regs *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpi_regs_spi_regs_WriteReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_TARGET_NUM_DATA, Data);
}

u32 XSpi_regs_spi_regs_Get_rd_target_num(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_TARGET_NUM_DATA);
    return Data;
}

u32 XSpi_regs_spi_regs_Get_wr_done(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_WR_DONE_DATA);
    return Data;
}

u32 XSpi_regs_spi_regs_Get_rd_done(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_DONE_DATA);
    return Data;
}

u32 XSpi_regs_spi_regs_Get_rd_data(XSpi_regs_spi_regs *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpi_regs_spi_regs_ReadReg(InstancePtr->Spi_regs_control_BaseAddress, XSPI_REGS_SPI_REGS_SPI_REGS_CONTROL_ADDR_RD_DATA_DATA);
    return Data;
}

