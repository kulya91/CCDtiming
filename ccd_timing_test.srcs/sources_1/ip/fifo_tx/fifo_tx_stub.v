// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Aug 10 21:14:13 2021
// Host        : DESKTOP-EDCLT94 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/fifo_tx/fifo_tx_stub.v
// Design      : fifo_tx
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tlffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_1,Vivado 2017.4" *)
module fifo_tx(clk, srst, din, wr_en, rd_en, dout, full, wr_ack, empty, 
  valid)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[63:0],wr_en,rd_en,dout[7:0],full,wr_ack,empty,valid" */;
  input clk;
  input srst;
  input [63:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output wr_ack;
  output empty;
  output valid;
endmodule
