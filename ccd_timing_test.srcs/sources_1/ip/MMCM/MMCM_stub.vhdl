-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Sat Aug 14 22:44:13 2021
-- Host        : DESKTOP-EDCLT94 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               F:/workspace/xilinx/timingtest/ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_stub.vhdl
-- Design      : MMCM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tlffg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MMCM is
  Port ( 
    clk_50m : out STD_LOGIC;
    clk_200m : out STD_LOGIC;
    clk_400m : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    sys_clk : in STD_LOGIC
  );

end MMCM;

architecture stub of MMCM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_50m,clk_200m,clk_400m,reset,locked,sys_clk";
begin
end;
