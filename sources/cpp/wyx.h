#include "xuartlite.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"

/*登陆密码*/
#define PASSWORD "xilinx"

// Device
#define UART_0_ID XPAR_UARTLITE_0_DEVICE_ID
#define SPI_CONTROL_dac1 0x80000000
#define SPI_CONTROL_dac2 0x80010000
#define GPIO_7044_rst    0x80020000
#define SPI_CONTROL_7044 0x80030000
#define GPIO_dds_freq_1  0x80040000
#define GPIO_delay_1     0x80050000
#define GPIO_data_1      0x80060000
#define GPIO_sync_1      0x80070000
#define GPIO_en_1        0x80080000
#define GPIO_data_2      0x80090000
#define GPIO_dds_freq_2  0x800A0000
#define GPIO_delay_2     0x800B0000
#define GPIO_en_2        0x800C0000
#define GPIO_sync_2      0x800D0000
#define GPIO_dac_rst     0x800E0000

/*GPIO内部寄存器*/
#define gpio_ch1 0x00
#define gpio_ch2 0x08

/*SPI内部寄存器*/
#define soft_rst_n_reg    0x10
#define chip_reg          0x18
#define cpol_reg          0x20
#define cpha_reg          0x28
#define w_r_mode_reg      0x30
#define wr_width_reg      0x38
#define wr_data_reg       0x40
#define rd_width_reg      0x48
#define rd_target_num_reg 0x50
#define wr_done_reg       0x58
#define rd_done_reg       0x68
#define rd_data_reg       0x78


/*UART接收函数*/
int uart_rx (XUartLite* UartInstance, u8* OutData)
{
	int finish = 0;
	int RecvNum = 0;
	u8 RecvData[64] = {0};  // 用于存储本次循环接收到的数据

	while(!finish)
	{
		// 从 UART接收数据
		int RecvCount = XUartLite_Recv(UartInstance, RecvData, sizeof(RecvData));

		// 将本次接收数据放入OutData内
    	if (RecvCount != 0)
    	{
    		memcpy(OutData + RecvNum, RecvData, RecvCount);
    		RecvNum = RecvNum + RecvCount;
    	}

    	// 收到回车字符时,认为完成一次完整接收,输出接收结果
    	if(RecvNum >= 1 && *(OutData + RecvNum - 1) == '\r')
    	{
    		*(OutData + RecvNum - 1) = '\0'; // 将回车符替换为字符串结束符
    		finish = 1;
    	}
	}

	return RecvNum;
}


/*用户登录函数*/
int login(XUartLite* UartInstance)
{
	int finish = 0;
	u8 password[64] = {0};

	while(!finish)
	{
		memset(password, 0, sizeof(password));
		uart_rx(UartInstance, password);

		if(strcmp((const char*)password, PASSWORD) == 0)
		{
			xil_printf("Login successful!\n");
			finish = 1;
		}
		else
		{
			xil_printf("Password error!\n");
		}
	}

	return finish;
}


/*SPI写函数*/
void spi_write(u32 SPI_CONTROL, u32 chip_num, u32 cpol, u32 cpha, u32 wr_width, u32 wr_data)
{
	Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x0);
	Xil_Out32(SPI_CONTROL + chip_reg, chip_num);
	Xil_Out32(SPI_CONTROL + cpol_reg, cpol);
	Xil_Out32(SPI_CONTROL + cpha_reg, cpha);
	Xil_Out32(SPI_CONTROL + w_r_mode_reg, 0x1);
	Xil_Out32(SPI_CONTROL + wr_width_reg, wr_width);
	Xil_Out32(SPI_CONTROL + wr_data_reg, wr_data);
	Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x1);
	u32 wr_done = Xil_In32(SPI_CONTROL + wr_done_reg);

	while(wr_done!=1)
	{
		wr_done = Xil_In32(SPI_CONTROL + wr_done_reg);
	}
}


/*SPI读函数*/
u32 spi_read(u32 SPI_CONTROL, u32 chip_num, u32 cpol, u32 cpha, u32 rd_mode, u32 rd_comd_width, u32 rd_data_width, u32 rd_command)
{
	if(rd_mode==0)
	{
		Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x0);
		Xil_Out32(SPI_CONTROL + chip_reg, chip_num);
		Xil_Out32(SPI_CONTROL + cpol_reg, cpol);
		Xil_Out32(SPI_CONTROL + cpha_reg, cpha);
		Xil_Out32(SPI_CONTROL + w_r_mode_reg, 0x0);
		Xil_Out32(SPI_CONTROL + rd_width_reg, rd_data_width);
		Xil_Out32(SPI_CONTROL + rd_target_num_reg, 0x1);
		Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x1);
	}
	else
	{
		Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x0);
		Xil_Out32(SPI_CONTROL + chip_reg, chip_num);
		Xil_Out32(SPI_CONTROL + cpol_reg, cpol);
		Xil_Out32(SPI_CONTROL + cpha_reg, cpha);
		Xil_Out32(SPI_CONTROL + w_r_mode_reg, 0x2);
		Xil_Out32(SPI_CONTROL + wr_width_reg, rd_comd_width);
		Xil_Out32(SPI_CONTROL + wr_data_reg, rd_command);
		Xil_Out32(SPI_CONTROL + rd_width_reg, rd_data_width);
		Xil_Out32(SPI_CONTROL + rd_target_num_reg, 0x1);
		Xil_Out32(SPI_CONTROL + soft_rst_n_reg, 0x1);
	}

	u32 rd_done = Xil_In32(SPI_CONTROL + rd_done_reg);
	while(rd_done!=1)
	{
		rd_done = Xil_In32(SPI_CONTROL + rd_done_reg);
	}

	u32 mask = (1 << rd_data_width) - 1;
	u32 rx_data = Xil_In32(SPI_CONTROL + rd_data_reg) & mask;

	return rx_data;
}


/*IODELAY调节函数*/
int iodelay(XUartLite* UartInstance)
{
	u8 delay_str[64] = {0};
	memset(delay_str, 0, sizeof(delay_str));
	uart_rx(UartInstance, delay_str);

	if(strcmp((const char*)delay_str, "exit") == 0)
	{
		xil_printf("Exit IODELAY adjustment mode.\n");
		return 1;
	}
	else
	{
		u8 delay_cmd[8] = {0};
		u8 delay_value[8] = {0};
		memset(delay_cmd, 0, sizeof(delay_cmd));
		memset(delay_value, 0, sizeof(delay_value));
		memcpy(delay_cmd, delay_str, 6);
		memcpy(delay_value, (delay_str+6), 3);

		int delay = (delay_value[0] - '0') * 100 + (delay_value[1] - '0') * 10 + delay_value[2] - '0';

		if(strcmp((const char*)delay_cmd, "DAC-1:") == 0)
		{
			Xil_Out32(GPIO_delay_1 + gpio_ch1, delay);
			usleep(1000);
			u32 dac1_delay_result = Xil_In32(GPIO_delay_1 + gpio_ch2) >> 1;
			xil_printf("DAC-1's delay value is %d.\n",dac1_delay_result);
		}
		else if(strcmp((const char*)delay_cmd, "DAC-2:") == 0)
		{
			Xil_Out32(GPIO_delay_2 + gpio_ch1, delay);
			usleep(1000);
			u32 dac2_delay_result = Xil_In32(GPIO_delay_2 + gpio_ch2) >> 1;
			xil_printf("DAC-2's delay value is %d.\n",dac2_delay_result);
		}
		else
		{
			xil_printf("Command invalid.\n");
		}

		return 0;
	}
}


/*reboot函数*/
int reboot(XUartLite* UartInstance)
{
	int finish = 0;
	u8 commond[64] = {0};

	while(!finish)
	{
		memset(commond, 0, sizeof(commond));
		uart_rx(UartInstance, commond);

		if(strcmp((const char*)commond, "reboot") == 0)
		{
			Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x0);
			Xil_Out32(GPIO_dac_rst + gpio_ch2, 0x0);
			Xil_Out32(GPIO_en_1 + gpio_ch1, 0x1);
			Xil_Out32(GPIO_en_1 + gpio_ch2, 0x1);
			Xil_Out32(GPIO_data_1 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_data_1 + gpio_ch2, 0x0);
			Xil_Out32(GPIO_dds_freq_1 + gpio_ch1, 1311);
			Xil_Out32(GPIO_delay_1 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_sync_1 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_en_2 + gpio_ch1, 0x1);
			Xil_Out32(GPIO_en_2 + gpio_ch2, 0x1);
			Xil_Out32(GPIO_data_2 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_data_2 + gpio_ch2, 0x0);
			Xil_Out32(GPIO_dds_freq_2 + gpio_ch1, 1311);
			Xil_Out32(GPIO_delay_2 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_sync_2 + gpio_ch1, 0x0);
			Xil_Out32(GPIO_7044_rst + gpio_ch1, 0x1);
			xil_printf("Rebooting!\n");
			finish = 1;
		}
		else
		{
			xil_printf("Command invalid!\n");
		}
	}

	return finish;
}
