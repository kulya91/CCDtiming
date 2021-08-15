// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat Aug 14 22:44:13 2021
// Host        : DESKTOP-EDCLT94 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_stub.v
// Design      : MMCM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tlffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module MMCM(clk_50m, clk_200m, clk_400m, reset, locked, 
  sys_clk)
/* synthesis syn_black_box black_box_pad_pin="clk_50m,clk_200m,clk_400m,reset,locked,sys_clk" */;
  output clk_50m;
  output clk_200m;
  output clk_400m;
  input reset;
  output locked;
  input sys_clk;
endmodule
