# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7k325tlffg676-2L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/workspace/xilinx/timingtest/ccd_timing_test.cache/wt [current_project]
set_property parent.project_path F:/workspace/xilinx/timingtest/ccd_timing_test.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo f:/workspace/xilinx/timingtest/ccd_timing_test.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/new/LED_Module.v
  F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/uart/uart_rx.v
  F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/uart/uart_test.v
  F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/uart/uart_tx.v
  F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/new/TOP_Module.v
}
read_ip -quiet F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM.xci
set_property used_in_implementation false [get_files -all f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_board.xdc]
set_property used_in_implementation false [get_files -all f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM.xdc]
set_property used_in_implementation false [get_files -all f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_ooc.xdc]

read_ip -quiet f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/fifo_tx/fifo_tx.xci
set_property used_in_implementation false [get_files -all f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/fifo_tx/fifo_tx.xdc]
set_property used_in_implementation false [get_files -all f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/fifo_tx/fifo_tx_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/constrs_1/new/ccd_timing.xdc
set_property used_in_implementation false [get_files F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/constrs_1/new/ccd_timing.xdc]


synth_design -top TOP_Module -part xc7k325tlffg676-2L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef TOP_Module.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file TOP_Module_utilization_synth.rpt -pb TOP_Module_utilization_synth.pb"
