`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/28 11:51:37
// Design Name: 
// Module Name: TOP_Module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_Module
(
input sys_clk,
input sys_rst,
input uart_rx,
output uart_tx,
output led0,
output led1,

   inout  [15:0]                ddr3_dq,
   inout  [1 :0]                ddr3_dqs_n,
   inout  [1 :0]                ddr3_dqs_p,
   output [13:0]                ddr3_addr,
   output [2 :0]                ddr3_ba,
   output                       ddr3_ras_n,
   output                       ddr3_cas_n,
   output                       ddr3_we_n,
   output                       ddr3_reset_n,
   output [0 :0]                ddr3_ck_p,
   output [0 :0]                ddr3_ck_n,
   output [0 :0]                ddr3_cke,
   output [0 :0]                ddr3_cs_n,
   output [1 :0]                ddr3_dm,
   output [0 :0]                ddr3_odt
    );



wire clk_50m;
wire clk_200m;
wire clk_400m;
wire reset;
wire locked;
wire RST_N;
assign RST_N= sys_rst && locked;

//Ê±ÖÓ
  MMCM instance_name
   (
    // Clock out ports
    .clk_50m(clk_50m),     // output clk_50m
    .clk_200m(clk_200m),     // output clk_200m
    .clk_400m(clk_400m),     // output clk_400m
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .sys_clk(sys_clk));      // input sys_clk


wire [255:0]                 uart_reg;
wire                        uart_ready;
wire [127:0]ddr_rd_data;
wire ddr_read_ready;

//´®¿Ú
uart_test uart(
    .sys_clk(clk_50m),
    .rst_n(RST_N),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .uart_reg(uart_reg),
    .uart_ready(uart_ready),
     .ddr_rd_data(ddr_rd_data),
    .ddr_read_ready(ddr_read_ready)
);

//led
LED_Module led(
    .sys_clk(clk_50m),
    .sys_rst(RST_N),
    .led0(led0),
    .led1(led1),
    .uart_reg(uart_reg),
    .uart_ready(uart_ready)
);

ddr_test ddr(
    .clk_200m       (clk_200m      ),
    .rst_n          (RST_N         ),
    .uart_clk       (clk_50m       ),               //input uart_clk
    .uart_reg       (uart_reg      ),               //input uart_reg [255:0]
    .ddr_rd_data    (ddr_rd_data   ),             //output ddr_rd_data [127:0]
    .uart_ready     (uart_ready    ),             //input uart_ready
    .ddr_read_ready (ddr_read_ready),          //output ddr_read_ready
                                   
    . ddr3_dq       ( ddr3_dq      ),
    . ddr3_dqs_n    ( ddr3_dqs_n   ),
    . ddr3_dqs_p    ( ddr3_dqs_p   ),
    . ddr3_addr     ( ddr3_addr    ),
    . ddr3_ba       ( ddr3_ba      ),
    . ddr3_ras_n    ( ddr3_ras_n   ),
    . ddr3_cas_n    ( ddr3_cas_n   ),
    . ddr3_we_n     ( ddr3_we_n    ),
    . ddr3_reset_n  ( ddr3_reset_n ),
    . ddr3_ck_p     ( ddr3_ck_p    ),
    . ddr3_ck_n     ( ddr3_ck_n    ),
    . ddr3_cke      ( ddr3_cke     ),
    . ddr3_cs_n     ( ddr3_cs_n    ),
    . ddr3_dm       ( ddr3_dm      ),
    . ddr3_odt      ( ddr3_odt     )
    );

endmodule
