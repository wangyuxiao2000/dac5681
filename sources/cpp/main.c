#include "wyx.h"

// Function
#define DAC1_SYNC   "INNER" // "INNER" or "EXTER"
#define DAC1_SOURCE "DDS"   // "DDS" or "DC"
#define DDS1_FREQ   1311    // 1311 - 20M; 11144 - 170M; 17699 - 270M
#define DAC2_SYNC   "INNER" // "INNER" or "EXTER"
#define DAC2_SOURCE "DDS"   // "DDS" or "DC"
#define DDS2_FREQ   1311    // 1311 - 20M; 11144 - 170M; 17699 - 270M


int main()
{
    while(1)
    {
        // 初始化UART实例并发送启动信息
        XUartLite UART_0;
        XUartLite_Initialize(&UART_0, UART_0_ID);
        xil_printf("Hello, WYX!\n");
        xil_printf("Password:\n");

        // 等待用户登录
        int login_status = login(&UART_0);
        while(!login_status)
        {
        	login_status = login(&UART_0);
        }

    	/*################################################ dac5681 - 7044 #################################################*/
        // Hard Reset
        Xil_Out32(GPIO_7044_rst + gpio_ch1, 0x1);
        usleep(100000);
        Xil_Out32(GPIO_7044_rst + gpio_ch1, 0x0);

        // Soft Reset
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000001);
        usleep(100000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000000);

        // Config RESERVED Reg
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009A00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009BAA);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009CAA);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009DAA);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009EAA);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x009F55); // Update
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A056); // Update
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A197);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A203);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A400);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A500); // Update
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A61C);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A822); // Update
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00A900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00AB00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00AC20);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00AD00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00AE08);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00AF50);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B009); // Update
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B10D);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B500);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00B800);

        // Config PLL2
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000100);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000204);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00032E);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000448);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000540);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000901);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003101);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003201); // x2_bypass
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003301); // R2_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003400); // R2_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00352C); // N2_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003601); // N2_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00370F); // cp_gain
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003818);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003A00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x003B00);

        // Config PLL1
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000A17); // Config Input Buffer
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000B17);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000C17);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000D17);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000E07);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0014E4); // Config PLL1
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001503);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00160C);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001A08);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001B00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001C04);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001D01);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001E04);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x001F01);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002004);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002104);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002610);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00280C);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002904);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x002A00);

        // Config SYSREF
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005A00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005B06);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005C00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005D01);

        // Config GPIO
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x004600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x004700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x004800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x004900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005036);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005132);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x005403);

        // Config Clock Distribution Network
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x006400);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x006500);

        // Config Masks
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x007000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x007110);

        // Config Output Channel
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00C8F2); // channal 0
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00C904); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CA00); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CB00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CC00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CD00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CE00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00CF00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D001);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D2FC); // channal 1
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D300); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D401); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D500);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00D900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00DA30);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00DCF2); // channal 2
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00DD18); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00DE00); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00DF00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E100);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E411);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E6F0); // channal 3
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E718); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E800); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00E900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00EA00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00EB00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00EC00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00ED00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00EE30);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F0F2); // channel 4
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F103); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F200); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F400);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F500);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00F811);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FAF0); // channel 5
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FB00); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FC06); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FD00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FE00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x00FF00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010100);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010230);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0104F3); // channal 6 - 1GHz
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010503); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010600); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010A00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010B00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010C11);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010EF1); // channal 7 - 1GHz
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x010F03); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011000); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011100);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011400);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011502);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011630);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0118F2); // channal 8
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011918); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011A00); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011B00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011C00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011D00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011E00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x011F00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012011);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0122FC); // channal 9
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012300); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012406); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012500);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012800);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012A30);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012CF2); // channal 10
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012D02); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012E00); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x012F00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x01310F);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013200);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013401);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0136FC); // channal 11
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013700); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013801); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013900);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013A00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013B00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013C00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013D00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x013E30);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x0140F3); // channel 12 - 250MHz
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x01410C); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014200); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014300);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014400);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014500);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014600);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014700);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014811);

        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014AFC); // channel 13
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014B00); // div_lsb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014C01); // div_msb
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014D00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014E00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x014F00);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x015000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x015100);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x015230);
        usleep(100000);

        // Restart dividers/FSMs
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000102);
        usleep(100000);
        spi_write(SPI_CONTROL_7044, 0, 0, 0, 24, 0x000100);
        usleep(100000);

        xil_printf("HMC7044 successfully config.\n");
    	/*#################################################################################################################*/


    	/*##################################################### DAC-1 #####################################################*/
        // DAC-1 Source
        if(strcmp(DAC1_SOURCE, "DDS") == 0)
        {
            Xil_Out32(GPIO_data_1 + gpio_ch2, 0x0);
            u32 ready = Xil_In32(GPIO_dds_freq_1 + gpio_ch2);
        	while(ready!=1)
        	{
        		ready = Xil_In32(GPIO_dds_freq_1 + gpio_ch2);
        	}
        	Xil_Out32(GPIO_dds_freq_1 + gpio_ch1, DDS1_FREQ);
        }
        else // 输出直流量
        {
        	Xil_Out32(GPIO_data_1 + gpio_ch2, 0x1);
        	Xil_Out32(GPIO_data_1 + gpio_ch1, 0x7FFF);
        }

        // DAC-1 Config
    	if(strcmp(DAC1_SYNC, "INNER") == 0)
    	{
    		// 关闭外置SYNC
    		Xil_Out32(GPIO_sync_1 + gpio_ch1, 0x0);

    		// Hard Reset
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x0);
    		sleep(1);
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x1);

    		// 配置DAC
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0110); // {2'b DAC_delay, 2'b01;                                            SLFTST_ena, 3'b FIFO_offset}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x02C0); // {1'b Twos_comp, 3'b100;                                           4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0301); // {DAC_offset_en, SLFTST_err_mask, FIFO_err_mask, Pattern_err_mask; 2'b00, SW_sync, SW_sync_sel}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0400); // {1'b0, SLFTST_err, FIFO_err, Pattern_err;                         4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0500); // {SIF4, rev_bus, clkdiv_sync_dis, 1'b0;                            1'b0, DLL_bypass, 2'b0}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x060C); // {3'b0, Sleep_A;                                                   BiasLPF_A, 2'b10, DLL_sleep}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x07FF); // {4'b DACA_gain;                                                   4'b1111}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0804); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0900); // Reserved
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0AC0); // {4'b DLL_delay;                                                   DLL_invclk, 3'b DLL_ifixed}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0B00); // Reserved
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0C00); // {2'b0, Offset_sync, 5'b OffsetA(12:8)}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0D00); // {8'b OffsetA(7:0)}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0E00); // {3'b SDO_func_sel, 1'b0;                                          4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0F00); // Reserved

    		// 开启DCLK
    		Xil_Out32(GPIO_en_1 + gpio_ch1, 0x0);
    		usleep(1000);

    		// 等待DAC-DLL锁定
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0800); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    	    u32 status0 = spi_read(SPI_CONTROL_dac1, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    		u32 dll_lock = (status0 & 0x00000040) >> 6;
    		while(dll_lock!=1)
    		{
    			status0 = spi_read(SPI_CONTROL_dac1, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    			dll_lock = (status0 & 0x00000040) >> 6;
    		}

    		// 启动内置SYNC
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0303);

    		// 启动LVDS数据
    		Xil_Out32(GPIO_en_1 + gpio_ch2, 0x0);
    	}
    	else
    	{
    		//关闭外置SYNC
    		Xil_Out32(GPIO_sync_1 + gpio_ch1, 0x0);

    		// Hard Reset
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x0);
    		sleep(1);
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x1);

    		// 配置DAC
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0110); // {2'b DAC_delay, 2'b01;                                            SLFTST_ena, 3'b FIFO_offset}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x02C0); // {1'b Twos_comp, 3'b100;                                           4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0300); // {DAC_offset_en, SLFTST_err_mask, FIFO_err_mask, Pattern_err_mask; 2'b00, SW_sync, SW_sync_sel}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0400); // {1'b0, SLFTST_err, FIFO_err, Pattern_err;                         4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0500); // {SIF4, rev_bus, clkdiv_sync_dis, 1'b0;                            1'b0, DLL_bypass, 2'b0}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x060C); // {3'b0, Sleep_A;                                                   BiasLPF_A, 2'b10, DLL_sleep}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x07FF); // {4'b DACA_gain;                                                   4'b1111}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0804); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0900); // Reserved
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0AC0); // {4'b DLL_delay;                                                   DLL_invclk, 3'b DLL_ifixed}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0B00); // Reserved
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0C00); // {2'b0, Offset_sync, 5'b OffsetA(12:8)}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0D00); // {8'b OffsetA(7:0)}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0E00); // {3'b SDO_func_sel, 1'b0;                                          4'b0000}
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0F00); // Reserved

    		// 开启DCLK
    		Xil_Out32(GPIO_en_1 + gpio_ch1, 0x0);
    		usleep(1000);

    		// 等待DAC-DLL锁定
    		spi_write(SPI_CONTROL_dac1, 0, 0, 0, 16, 0x0800); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    	    u32 status0 = spi_read(SPI_CONTROL_dac1, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    		u32 dll_lock = (status0 & 0x00000040) >> 6;
    		while(dll_lock!=1)
    		{
    			status0 = spi_read(SPI_CONTROL_dac1, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    			dll_lock = (status0 & 0x00000040) >> 6;
    		}

    		// 启动外置SYNC
    		Xil_Out32(GPIO_sync_1 + gpio_ch1, 0x2);

    		// 启动LVDS数据
    		Xil_Out32(GPIO_en_1 + gpio_ch2, 0x0);
    	}

    	xil_printf("DAC-1 successfully config.\n");
    	/*#################################################################################################################*/


    	/*##################################################### DAC-2 #####################################################*/
    	// DAC-2 Source
    	if(strcmp(DAC2_SOURCE, "DDS") == 0)
        {
            Xil_Out32(GPIO_data_2 + gpio_ch2, 0x0);
            u32 ready = Xil_In32(GPIO_dds_freq_2 + gpio_ch2);
        	while(ready!=1)
        	{
        		ready = Xil_In32(GPIO_dds_freq_2 + gpio_ch2);
        	}

        	Xil_Out32(GPIO_dds_freq_2 + gpio_ch1, DDS2_FREQ);
        }
        else
        {
        	Xil_Out32(GPIO_data_2 + gpio_ch2, 0x1);
        	Xil_Out32(GPIO_data_2 + gpio_ch1, 0x7FFF);
        }

    	// DAC-2 Config
    	if(strcmp(DAC2_SYNC, "INNER") == 0)
    	{
    		// 关闭外置SYNC
    		Xil_Out32(GPIO_sync_2 + gpio_ch1, 0x0);

    		// Hard Reset
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x0);
    		sleep(1);
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x1);

    		// 配置DAC
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0110); // {2'b DAC_delay, 2'b01;                                            SLFTST_ena, 3'b FIFO_offset}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x02C0); // {1'b Twos_comp, 3'b100;                                           4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0301); // {DAC_offset_en, SLFTST_err_mask, FIFO_err_mask, Pattern_err_mask; 2'b00, SW_sync, SW_sync_sel}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0400); // {1'b0, SLFTST_err, FIFO_err, Pattern_err;                         4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0500); // {SIF4, rev_bus, clkdiv_sync_dis, 1'b0;                            1'b0, DLL_bypass, 2'b0}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x060C); // {3'b0, Sleep_A;                                                   BiasLPF_A, 2'b10, DLL_sleep}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x07FF); // {4'b DACA_gain;                                                   4'b1111}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0804); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0900); // Reserved
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0AC0); // {4'b DLL_delay;                                                   DLL_invclk, 3'b DLL_ifixed}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0B00); // Reserved
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0C00); // {2'b0, Offset_sync, 5'b OffsetA(12:8)}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0D00); // {8'b OffsetA(7:0)}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0E00); // {3'b SDO_func_sel, 1'b0;                                          4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0F00); // Reserved

    		// 开启DCLK
    		Xil_Out32(GPIO_en_2 + gpio_ch1, 0x0);
    		usleep(1000);

    		// 等待DAC-DLL锁定
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0800); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    	    u32 status0 = spi_read(SPI_CONTROL_dac2, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    		u32 dll_lock = (status0 & 0x00000040) >> 6;
    		while(dll_lock!=1)
    		{
    			status0 = spi_read(SPI_CONTROL_dac2, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    			dll_lock = (status0 & 0x00000040) >> 6;
    		}

    		// 启动内置SYNC
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0303);

    		// 启动LVDS数据
    		Xil_Out32(GPIO_en_2 + gpio_ch2, 0x0);
    	}
    	else
    	{
    		//关闭外置SYNC
    		Xil_Out32(GPIO_sync_2 + gpio_ch1, 0x0);

    		// Hard Reset
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x0);
    		sleep(1);
    		Xil_Out32(GPIO_dac_rst + gpio_ch1, 0x1);

    		// 配置DAC
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0110); // {2'b DAC_delay, 2'b01;                                            SLFTST_ena, 3'b FIFO_offset}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x02C0); // {1'b Twos_comp, 3'b100;                                           4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0300); // {DAC_offset_en, SLFTST_err_mask, FIFO_err_mask, Pattern_err_mask; 2'b00, SW_sync, SW_sync_sel}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0400); // {1'b0, SLFTST_err, FIFO_err, Pattern_err;                         4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0500); // {SIF4, rev_bus, clkdiv_sync_dis, 1'b0;                            1'b0, DLL_bypass, 2'b0}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x060C); // {3'b0, Sleep_A;                                                   BiasLPF_A, 2'b10, DLL_sleep}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x07FF); // {4'b DACA_gain;                                                   4'b1111}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0804); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0900); // Reserved
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0AC0); // {4'b DLL_delay;                                                   DLL_invclk, 3'b DLL_ifixed}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0B00); // Reserved
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0C00); // {2'b0, Offset_sync, 5'b OffsetA(12:8)}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0D00); // {8'b OffsetA(7:0)}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0E00); // {3'b SDO_func_sel, 1'b0;                                          4'b0000}
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0F00); // Reserved

    		// 开启DCLK
    		Xil_Out32(GPIO_en_2 + gpio_ch1, 0x0);
    		usleep(1000);

    		// 等待DAC-DLL锁定
    		spi_write(SPI_CONTROL_dac2, 0, 0, 0, 16, 0x0800); // {4'b0000;                                                         1'b0, DLL_restart, 2'b0}
    	    u32 status0 = spi_read(SPI_CONTROL_dac2, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    		u32 dll_lock = (status0 & 0x00000040) >> 6;
    		while(dll_lock!=1)
    		{
    			status0 = spi_read(SPI_CONTROL_dac2, 0, 0, 0, 1, 8, 8, (1<<7)|(0x00&0x1F));
    			dll_lock = (status0 & 0x00000040) >> 6;
    		}

    		// 启动外置SYNC
    		Xil_Out32(GPIO_sync_2 + gpio_ch1, 0x2);

    		// 启动LVDS数据
    		Xil_Out32(GPIO_en_2 + gpio_ch2, 0x0);
    	}

    	xil_printf("DAC-2 successfully config.\n");
    	/*#################################################################################################################*/


    	/*##################################################### ODELAY ####################################################*/
    	xil_printf("\n");
    	xil_printf("Please adjust the ODELAY value of DCLK by 'DAC-1:<delay value>' or 'DAC-2:<delay value>'.\n");
    	xil_printf("<delay value> ranging from 000 to 031 for v7, ranging from 000 to 511 for ku or zu.\n");

    	int iodelay_done = 0;
    	while(!iodelay_done)
    	{
    		iodelay_done = iodelay(&UART_0);
    	}
    	/*#################################################################################################################*/
    

        /*#################################################### 等待重启 ####################################################*/
        reboot(&UART_0);
    	/*#################################################################################################################*/
    }
    
    return 0;
}
