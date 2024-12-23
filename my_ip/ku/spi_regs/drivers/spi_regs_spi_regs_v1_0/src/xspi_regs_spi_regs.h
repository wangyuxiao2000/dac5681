// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XSPI_REGS_SPI_REGS_H
#define XSPI_REGS_SPI_REGS_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xspi_regs_spi_regs_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Spi_regs_control_BaseAddress;
} XSpi_regs_spi_regs_Config;
#endif

typedef struct {
    u64 Spi_regs_control_BaseAddress;
    u32 IsReady;
} XSpi_regs_spi_regs;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XSpi_regs_spi_regs_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XSpi_regs_spi_regs_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XSpi_regs_spi_regs_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XSpi_regs_spi_regs_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XSpi_regs_spi_regs_Initialize(XSpi_regs_spi_regs *InstancePtr, u16 DeviceId);
XSpi_regs_spi_regs_Config* XSpi_regs_spi_regs_LookupConfig(u16 DeviceId);
int XSpi_regs_spi_regs_CfgInitialize(XSpi_regs_spi_regs *InstancePtr, XSpi_regs_spi_regs_Config *ConfigPtr);
#else
int XSpi_regs_spi_regs_Initialize(XSpi_regs_spi_regs *InstancePtr, const char* InstanceName);
int XSpi_regs_spi_regs_Release(XSpi_regs_spi_regs *InstancePtr);
#endif


void XSpi_regs_spi_regs_Set_soft_rst_n(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_soft_rst_n(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_chip(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_chip(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_cpol(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_cpol(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_cpha(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_cpha(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_w_r_mode(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_w_r_mode(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_wr_width(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_wr_width(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_wr_data(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_wr_data(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_rd_width(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_rd_width(XSpi_regs_spi_regs *InstancePtr);
void XSpi_regs_spi_regs_Set_rd_target_num(XSpi_regs_spi_regs *InstancePtr, u32 Data);
u32 XSpi_regs_spi_regs_Get_rd_target_num(XSpi_regs_spi_regs *InstancePtr);
u32 XSpi_regs_spi_regs_Get_wr_done(XSpi_regs_spi_regs *InstancePtr);
u32 XSpi_regs_spi_regs_Get_rd_done(XSpi_regs_spi_regs *InstancePtr);
u32 XSpi_regs_spi_regs_Get_rd_data(XSpi_regs_spi_regs *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
