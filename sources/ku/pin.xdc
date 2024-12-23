# Compress the bit file
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# board clk - 50MHz 
set_property -dict {PACKAGE_PIN AN13 IOSTANDARD LVCMOS18} [get_ports clk_50m]

# UART
set_property -dict {PACKAGE_PIN AR20 IOSTANDARD LVCMOS18} [get_ports {EXP_DIR2_7[0]}]
set_property -dict {PACKAGE_PIN AW20 IOSTANDARD LVCMOS18} [get_ports tx]
set_property -dict {PACKAGE_PIN AV19 IOSTANDARD LVCMOS18} [get_ports {EXP_DIR1_7[0]}]
set_property -dict {PACKAGE_PIN AV17 IOSTANDARD LVCMOS18} [get_ports rx]

# 7044 clk - 250MHz
set_property -dict {PACKAGE_PIN AM26 IOSTANDARD LVDS} [get_ports clk_250m_p]

# 7044 SPI
set_property -dict {PACKAGE_PIN AK32 IOSTANDARD LVCMOS18} [get_ports {rst_7044[0]}]
set_property -dict {PACKAGE_PIN AL32 IOSTANDARD LVCMOS18} [get_ports cs_7044]
set_property -dict {PACKAGE_PIN AR31 IOSTANDARD LVCMOS18} [get_ports sck_7044]
set_property -dict {PACKAGE_PIN AR32 IOSTANDARD LVCMOS18} [get_ports sdio_7044]

# DAC1
set_property -dict {PACKAGE_PIN AV39 IOSTANDARD LVCMOS18} [get_ports cs_5681_1]
set_property -dict {PACKAGE_PIN AR33 IOSTANDARD LVCMOS18} [get_ports sck_5681_1]
set_property -dict {PACKAGE_PIN AT33 IOSTANDARD LVCMOS18} [get_ports sdio_5681_1]
set_property -dict {PACKAGE_PIN AT22 IOSTANDARD LVDS} [get_ports dac1_sync_p]
set_property -dict {PACKAGE_PIN AP21 IOSTANDARD LVDS} [get_ports dac1_dclk_p]
set_property -dict {PACKAGE_PIN AN33 IOSTANDARD LVDS} [get_ports {dac1_data_p[0]}]
set_property -dict {PACKAGE_PIN AV29 IOSTANDARD LVDS} [get_ports {dac1_data_p[1]}]
set_property -dict {PACKAGE_PIN AV28 IOSTANDARD LVDS} [get_ports {dac1_data_p[2]}]
set_property -dict {PACKAGE_PIN AL20 IOSTANDARD LVDS} [get_ports {dac1_data_p[3]}]
set_property -dict {PACKAGE_PIN AJ30 IOSTANDARD LVDS} [get_ports {dac1_data_p[4]}]
set_property -dict {PACKAGE_PIN AM27 IOSTANDARD LVDS} [get_ports {dac1_data_p[5]}]
set_property -dict {PACKAGE_PIN AH29 IOSTANDARD LVDS} [get_ports {dac1_data_p[6]}]
set_property -dict {PACKAGE_PIN AM22 IOSTANDARD LVDS} [get_ports {dac1_data_p[7]}]
set_property -dict {PACKAGE_PIN AV21 IOSTANDARD LVDS} [get_ports {dac1_data_p[8]}]
set_property -dict {PACKAGE_PIN AM21 IOSTANDARD LVDS} [get_ports {dac1_data_p[9]}]
set_property -dict {PACKAGE_PIN AK20 IOSTANDARD LVDS} [get_ports {dac1_data_p[10]}]
set_property -dict {PACKAGE_PIN AJ20 IOSTANDARD LVDS} [get_ports {dac1_data_p[11]}]
set_property -dict {PACKAGE_PIN AF20 IOSTANDARD LVDS} [get_ports {dac1_data_p[12]}]
set_property -dict {PACKAGE_PIN AE20 IOSTANDARD LVDS} [get_ports {dac1_data_p[13]}]
set_property -dict {PACKAGE_PIN AG21 IOSTANDARD LVDS} [get_ports {dac1_data_p[14]}]
set_property -dict {PACKAGE_PIN AR28 IOSTANDARD LVDS} [get_ports {dac1_data_p[15]}]

# DAC2
set_property -dict {PACKAGE_PIN AP34 IOSTANDARD LVCMOS18} [get_ports cs_5681_2]
set_property -dict {PACKAGE_PIN AM34 IOSTANDARD LVCMOS18} [get_ports sck_5681_2]
set_property -dict {PACKAGE_PIN AM35 IOSTANDARD LVCMOS18} [get_ports sdio_5681_2]
set_property -dict {PACKAGE_PIN AF24 IOSTANDARD LVDS} [get_ports dac2_sync_p]
set_property -dict {PACKAGE_PIN AW25 IOSTANDARD LVDS} [get_ports dac2_dclk_p]
set_property -dict {PACKAGE_PIN AN28 IOSTANDARD LVDS} [get_ports {dac2_data_p[0]}]
set_property -dict {PACKAGE_PIN AU25 IOSTANDARD LVDS} [get_ports {dac2_data_p[1]}]
set_property -dict {PACKAGE_PIN AR26 IOSTANDARD LVDS} [get_ports {dac2_data_p[2]}]
set_property -dict {PACKAGE_PIN AP25 IOSTANDARD LVDS} [get_ports {dac2_data_p[3]}]
set_property -dict {PACKAGE_PIN AT27 IOSTANDARD LVDS} [get_ports {dac2_data_p[4]}]
set_property -dict {PACKAGE_PIN AL27 IOSTANDARD LVDS} [get_ports {dac2_data_p[5]}]
set_property -dict {PACKAGE_PIN AH24 IOSTANDARD LVDS} [get_ports {dac2_data_p[6]}]
set_property -dict {PACKAGE_PIN AL24 IOSTANDARD LVDS} [get_ports {dac2_data_p[7]}]
set_property -dict {PACKAGE_PIN AM24 IOSTANDARD LVDS} [get_ports {dac2_data_p[8]}]
set_property -dict {PACKAGE_PIN AJ25 IOSTANDARD LVDS} [get_ports {dac2_data_p[9]}]
set_property -dict {PACKAGE_PIN AF25 IOSTANDARD LVDS} [get_ports {dac2_data_p[10]}]
set_property -dict {PACKAGE_PIN AH26 IOSTANDARD LVDS} [get_ports {dac2_data_p[11]}]
set_property -dict {PACKAGE_PIN AG27 IOSTANDARD LVDS} [get_ports {dac2_data_p[12]}]
set_property -dict {PACKAGE_PIN AD25 IOSTANDARD LVDS} [get_ports {dac2_data_p[13]}]
set_property -dict {PACKAGE_PIN AE27 IOSTANDARD LVDS} [get_ports {dac2_data_p[14]}]
set_property -dict {PACKAGE_PIN AD26 IOSTANDARD LVDS} [get_ports {dac2_data_p[15]}]

# Ignore unallocated pins
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks RTSTAT-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]