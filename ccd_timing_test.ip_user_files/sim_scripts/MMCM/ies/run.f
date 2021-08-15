-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM_clk_wiz.v" \
  "../../../../ccd_timing_test.srcs/sources_1/ip/MMCM/MMCM.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

