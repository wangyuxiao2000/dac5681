// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xspi_regs_spi_regs.h"

extern XSpi_regs_spi_regs_Config XSpi_regs_spi_regs_ConfigTable[];

XSpi_regs_spi_regs_Config *XSpi_regs_spi_regs_LookupConfig(u16 DeviceId) {
	XSpi_regs_spi_regs_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XSPI_REGS_SPI_REGS_NUM_INSTANCES; Index++) {
		if (XSpi_regs_spi_regs_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XSpi_regs_spi_regs_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpi_regs_spi_regs_Initialize(XSpi_regs_spi_regs *InstancePtr, u16 DeviceId) {
	XSpi_regs_spi_regs_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpi_regs_spi_regs_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpi_regs_spi_regs_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

