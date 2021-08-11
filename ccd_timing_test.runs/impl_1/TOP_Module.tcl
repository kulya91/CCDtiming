# 
# Report generation script generated by Vivado
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
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  create_project -in_memory -part xc7k325tlffg676-2L
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir F:/workspace/xilinx/timingtest/ccd_timing_test.cache/wt [current_project]
  set_property parent.project_path F:/workspace/xilinx/timingtest/ccd_timing_test.xpr [current_project]
  set_property ip_output_repo F:/workspace/xilinx/timingtest/ccd_timing_test.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet F:/workspace/xilinx/timingtest/ccd_timing_test.runs/synth_1/TOP_Module.dcp
  read_ip -quiet F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM.xci
  read_ip -quiet f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/fifo_tx/fifo_tx.xci
  read_xdc F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/constrs_1/new/ccd_timing.xdc
  link_design -top TOP_Module -part xc7k325tlffg676-2L
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force TOP_Module_opt.dcp
  create_report "impl_1_opt_report_drc_0" "report_drc -file TOP_Module_drc_opted.rpt -pb TOP_Module_drc_opted.pb -rpx TOP_Module_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force TOP_Module_placed.dcp
  create_report "impl_1_place_report_io_0" "report_io -file TOP_Module_io_placed.rpt"
  create_report "impl_1_place_report_utilization_0" "report_utilization -file TOP_Module_utilization_placed.rpt -pb TOP_Module_utilization_placed.pb"
  create_report "impl_1_place_report_control_sets_0" "report_control_sets -verbose -file TOP_Module_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force TOP_Module_routed.dcp
  create_report "impl_1_route_report_drc_0" "report_drc -file TOP_Module_drc_routed.rpt -pb TOP_Module_drc_routed.pb -rpx TOP_Module_drc_routed.rpx"
  create_report "impl_1_route_report_methodology_0" "report_methodology -file TOP_Module_methodology_drc_routed.rpt -pb TOP_Module_methodology_drc_routed.pb -rpx TOP_Module_methodology_drc_routed.rpx"
  create_report "impl_1_route_report_power_0" "report_power -file TOP_Module_power_routed.rpt -pb TOP_Module_power_summary_routed.pb -rpx TOP_Module_power_routed.rpx"
  create_report "impl_1_route_report_route_status_0" "report_route_status -file TOP_Module_route_status.rpt -pb TOP_Module_route_status.pb"
  create_report "impl_1_route_report_timing_summary_0" "report_timing_summary -max_paths 10 -file TOP_Module_timing_summary_routed.rpt -rpx TOP_Module_timing_summary_routed.rpx -warn_on_violation "
  create_report "impl_1_route_report_incremental_reuse_0" "report_incremental_reuse -file TOP_Module_incremental_reuse_routed.rpt"
  create_report "impl_1_route_report_clock_utilization_0" "report_clock_utilization -file TOP_Module_clock_utilization_routed.rpt"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force TOP_Module_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  catch { write_mem_info -force TOP_Module.mmi }
  write_bitstream -force TOP_Module.bit 
  catch {write_debug_probes -quiet -force TOP_Module}
  catch {file copy -force TOP_Module.ltx debug_nets.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

