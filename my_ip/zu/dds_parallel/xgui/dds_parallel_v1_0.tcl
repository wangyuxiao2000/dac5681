# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set dds_channel [ipgui::add_param $IPINST -name "dds_channel" -parent ${Page_0}]
  set_property tooltip {DDS parallelism.} ${dds_channel}
  set pinc_width [ipgui::add_param $IPINST -name "pinc_width" -parent ${Page_0}]
  set_property tooltip {The phase increment control word bit width set in the DDS IP core.} ${pinc_width}
  set data_width [ipgui::add_param $IPINST -name "data_width" -parent ${Page_0}]
  set_property tooltip {The signal output bit width set in the DDS IP core.} ${data_width}


}

proc update_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to update data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_width { PARAM_VALUE.data_width } {
	# Procedure called to validate data_width
	return true
}

proc update_PARAM_VALUE.dds_channel { PARAM_VALUE.dds_channel } {
	# Procedure called to update dds_channel when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.dds_channel { PARAM_VALUE.dds_channel } {
	# Procedure called to validate dds_channel
	return true
}

proc update_PARAM_VALUE.pinc_width { PARAM_VALUE.pinc_width } {
	# Procedure called to update pinc_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pinc_width { PARAM_VALUE.pinc_width } {
	# Procedure called to validate pinc_width
	return true
}


proc update_MODELPARAM_VALUE.dds_channel { MODELPARAM_VALUE.dds_channel PARAM_VALUE.dds_channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dds_channel}] ${MODELPARAM_VALUE.dds_channel}
}

proc update_MODELPARAM_VALUE.pinc_width { MODELPARAM_VALUE.pinc_width PARAM_VALUE.pinc_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pinc_width}] ${MODELPARAM_VALUE.pinc_width}
}

proc update_MODELPARAM_VALUE.data_width { MODELPARAM_VALUE.data_width PARAM_VALUE.data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_width}] ${MODELPARAM_VALUE.data_width}
}

