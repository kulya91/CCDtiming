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


module TOP_Module(
input sys_clk,
input sys_rst,
input uart_rx,
output uart_tx,
output led0,
output led1
    );
wire uart_clk;
wire ddr_clk;
wire reset;
wire locked;
wire RST_N;

wire [47:0]                 uart_reg;
wire                        uart_ready;

assign RST_N= sys_rst && locked;
MMCM instance_name
(
      // Clock out ports
      .uart_clk(uart_clk),     // output uart_clk
      .ddr_clk(ddr_clk),     // output ddr_clk
      // Status and control signals
      .reset(reset), // input reset
      .locked(locked),       // output locked
     // Clock in ports
      .clk_in1(sys_clk));      // input clk_in1
      
uart_test uart(
    .sys_clk(sys_clk),
    .rst_n(RST_N),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .uart_reg(uart_reg),
    .uart_ready(uart_ready)
);
LED_Module led(
    .sys_clk(sys_clk),
    .sys_rst(RST_N),
    .led0(led0),
    .led1(led1),
    .uart_reg(uart_reg),
    .uart_ready(uart_ready)
);
endmodule
