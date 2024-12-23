# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set system_clk [ipgui::add_param $IPINST -name "system_clk" -parent ${Page_0}]
  set_property tooltip {unit:Hz} ${system_clk}
  set spi_rate [ipgui::add_param $IPINST -name "spi_rate" -parent ${Page_0}]
  set_property tooltip {unit:Hz} ${spi_rate}
  set cs_buff_time [ipgui::add_param $IPINST -name "cs_buff_time" -parent ${Page_0}]
  set_property tooltip {Buffer time for cs to maintain a stable high level before the falling edge (unit: one data length).} ${cs_buff_time}
  set sck_buff_time [ipgui::add_param $IPINST -name "sck_buff_time" -parent ${Page_0}]
  set_property tooltip {Buffer time between cs and sck (unit: one data length).} ${sck_buff_time}
  set mode [ipgui::add_param $IPINST -name "mode" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Set SPI to work in 3-wire or 4-wire mode.} ${mode}


}

proc update_PARAM_VALUE.cs_buff_time { PARAM_VALUE.cs_buff_time } {
	# Procedure called to update cs_buff_time when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.cs_buff_time { PARAM_VALUE.cs_buff_time } {
	# Procedure called to validate cs_buff_time
	return true
}

proc update_PARAM_VALUE.mode { PARAM_VALUE.mode } {
	# Procedure called to update mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.mode { PARAM_VALUE.mode } {
	# Procedure called to validate mode
	return true
}

proc update_PARAM_VALUE.sck_buff_time { PARAM_VALUE.sck_buff_time } {
	# Procedure called to update sck_buff_time when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sck_buff_time { PARAM_VALUE.sck_buff_time } {
	# Procedure called to validate sck_buff_time
	return true
}

proc update_PARAM_VALUE.spi_rate { PARAM_VALUE.spi_rate } {
	# Procedure called to update spi_rate when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.spi_rate { PARAM_VALUE.spi_rate } {
	# Procedure called to validate spi_rate
	return true
}

proc update_PARAM_VALUE.system_clk { PARAM_VALUE.system_clk } {
	# Procedure called to update system_clk when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.system_clk { PARAM_VALUE.system_clk } {
	# Procedure called to validate system_clk
	return true
}


proc update_MODELPARAM_VALUE.system_clk { MODELPARAM_VALUE.system_clk PARAM_VALUE.system_clk } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.system_clk}] ${MODELPARAM_VALUE.system_clk}
}

proc update_MODELPARAM_VALUE.spi_rate { MODELPARAM_VALUE.spi_rate PARAM_VALUE.spi_rate } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.spi_rate}] ${MODELPARAM_VALUE.spi_rate}
}

proc update_MODELPARAM_VALUE.cs_buff_time { MODELPARAM_VALUE.cs_buff_time PARAM_VALUE.cs_buff_time } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.cs_buff_time}] ${MODELPARAM_VALUE.cs_buff_time}
}

proc update_MODELPARAM_VALUE.sck_buff_time { MODELPARAM_VALUE.sck_buff_time PARAM_VALUE.sck_buff_time } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sck_buff_time}] ${MODELPARAM_VALUE.sck_buff_time}
}

proc update_MODELPARAM_VALUE.mode { MODELPARAM_VALUE.mode PARAM_VALUE.mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.mode}] ${MODELPARAM_VALUE.mode}
}

