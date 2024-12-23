# Compress the bit file
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# board clk - 25MHz 
set_property -dict {PACKAGE_PIN AJ32 IOSTANDARD LVCMOS18} [get_ports clk_25m]

# coard resetn - SW2 
set_property -dict {PACKAGE_PIN AK29 IOSTANDARD LVCMOS18} [get_ports resetn]

# UART
set_property -dict {PACKAGE_PIN AG31 IOSTANDARD LVCMOS18} [get_ports tx]
set_property -dict {PACKAGE_PIN AF30 IOSTANDARD LVCMOS18} [get_ports rx]

# 7044 clk - 250MHz
set_property -dict {PACKAGE_PIN AT22 IOSTANDARD LVDS} [get_ports clk_250m_p]

# 7044 SPI
set_property -dict {PACKAGE_PIN AJ18 IOSTANDARD LVCMOS18} [get_ports {rst_7044[0]}]
set_property -dict {PACKAGE_PIN AJ17 IOSTANDARD LVCMOS18} [get_ports cs_7044]
set_property -dict {PACKAGE_PIN AM16 IOSTANDARD LVCMOS18} [get_ports sck_7044]
set_property -dict {PACKAGE_PIN AN16 IOSTANDARD LVCMOS18} [get_ports sdio_7044]

# DAC1
set_property -dict {PACKAGE_PIN AY28 IOSTANDARD LVCMOS18} [get_ports cs_5681_1]
set_property -dict {PACKAGE_PIN AU28 IOSTANDARD LVCMOS18} [get_ports sck_5681_1]
set_property -dict {PACKAGE_PIN AV28 IOSTANDARD LVCMOS18} [get_ports sdio_5681_1]
set_property -dict {PACKAGE_PIN AN11 IOSTANDARD LVDS} [get_ports dac1_sync_p]
set_property -dict {PACKAGE_PIN AM12 IOSTANDARD LVDS} [get_ports dac1_dclk_p]
set_property -dict {PACKAGE_PIN AU19 IOSTANDARD LVDS} [get_ports {dac1_data_p[0]}]
set_property -dict {PACKAGE_PIN AN19 IOSTANDARD LVDS} [get_ports {dac1_data_p[1]}]
set_property -dict {PACKAGE_PIN AY25 IOSTANDARD LVDS} [get_ports {dac1_data_p[2]}]
set_property -dict {PACKAGE_PIN AJ13 IOSTANDARD LVDS} [get_ports {dac1_data_p[3]}]
set_property -dict {PACKAGE_PIN AT20 IOSTANDARD LVDS} [get_ports {dac1_data_p[4]}]
set_property -dict {PACKAGE_PIN BB24 IOSTANDARD LVDS} [get_ports {dac1_data_p[5]}]
set_property -dict {PACKAGE_PIN AV16 IOSTANDARD LVDS} [get_ports {dac1_data_p[6]}]
set_property -dict {PACKAGE_PIN AK12 IOSTANDARD LVDS} [get_ports {dac1_data_p[7]}]
set_property -dict {PACKAGE_PIN AR14 IOSTANDARD LVDS} [get_ports {dac1_data_p[8]}]
set_property -dict {PACKAGE_PIN AP12 IOSTANDARD LVDS} [get_ports {dac1_data_p[9]}]
set_property -dict {PACKAGE_PIN AM13 IOSTANDARD LVDS} [get_ports {dac1_data_p[10]}]
set_property -dict {PACKAGE_PIN AN15 IOSTANDARD LVDS} [get_ports {dac1_data_p[11]}]
set_property -dict {PACKAGE_PIN AJ16 IOSTANDARD LVDS} [get_ports {dac1_data_p[12]}]
set_property -dict {PACKAGE_PIN AK15 IOSTANDARD LVDS} [get_ports {dac1_data_p[13]}]
set_property -dict {PACKAGE_PIN AK14 IOSTANDARD LVDS} [get_ports {dac1_data_p[14]}]
set_property -dict {PACKAGE_PIN AM24 IOSTANDARD LVDS} [get_ports {dac1_data_p[15]}]

# DAC2
set_property -dict {PACKAGE_PIN AP28 IOSTANDARD LVCMOS18} [get_ports cs_5681_2]
set_property -dict {PACKAGE_PIN AR29 IOSTANDARD LVCMOS18} [get_ports sck_5681_2]
set_property -dict {PACKAGE_PIN AT29 IOSTANDARD LVCMOS18} [get_ports sdio_5681_2]
set_property -dict {PACKAGE_PIN AK20 IOSTANDARD LVDS} [get_ports dac2_sync_p]
set_property -dict {PACKAGE_PIN AY24 IOSTANDARD LVDS} [get_ports dac2_dclk_p]
set_property -dict {PACKAGE_PIN AM23 IOSTANDARD LVDS} [get_ports {dac2_data_p[0]}]
set_property -dict {PACKAGE_PIN AU24 IOSTANDARD LVDS} [get_ports {dac2_data_p[1]}]
set_property -dict {PACKAGE_PIN AW23 IOSTANDARD LVDS} [get_ports {dac2_data_p[2]}]
set_property -dict {PACKAGE_PIN AY23 IOSTANDARD LVDS} [get_ports {dac2_data_p[3]}]
set_property -dict {PACKAGE_PIN BA22 IOSTANDARD LVDS} [get_ports {dac2_data_p[4]}]
set_property -dict {PACKAGE_PIN BA21 IOSTANDARD LVDS} [get_ports {dac2_data_p[5]}]
set_property -dict {PACKAGE_PIN AT21 IOSTANDARD LVDS} [get_ports {dac2_data_p[6]}]
set_property -dict {PACKAGE_PIN AV21 IOSTANDARD LVDS} [get_ports {dac2_data_p[7]}]
set_property -dict {PACKAGE_PIN AR23 IOSTANDARD LVDS} [get_ports {dac2_data_p[8]}]
set_property -dict {PACKAGE_PIN AP23 IOSTANDARD LVDS} [get_ports {dac2_data_p[9]}]
set_property -dict {PACKAGE_PIN AJ23 IOSTANDARD LVDS} [get_ports {dac2_data_p[10]}]
set_property -dict {PACKAGE_PIN AL21 IOSTANDARD LVDS} [get_ports {dac2_data_p[11]}]
set_property -dict {PACKAGE_PIN AN21 IOSTANDARD LVDS} [get_ports {dac2_data_p[12]}]
set_property -dict {PACKAGE_PIN AL22 IOSTANDARD LVDS} [get_ports {dac2_data_p[13]}]
set_property -dict {PACKAGE_PIN AJ22 IOSTANDARD LVDS} [get_ports {dac2_data_p[14]}]
set_property -dict {PACKAGE_PIN AJ21 IOSTANDARD LVDS} [get_ports {dac2_data_p[15]}]

# Ignore unallocated pins
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks RTSTAT-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]