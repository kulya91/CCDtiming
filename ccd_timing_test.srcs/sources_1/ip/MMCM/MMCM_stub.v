// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Jul 28 17:15:08 2021
// Host        : DESKTOP-EDCLT94 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_stub.v
// Design      : MMCM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tlffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module MMCM(uart_clk, ddr_clk, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="uart_clk,ddr_clk,reset,locked,clk_in1" */;
  output uart_clk;
  output ddr_clk;
  input reset;
  output locked;
  input clk_in1;
endmodule
