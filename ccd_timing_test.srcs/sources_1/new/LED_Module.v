`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/28 18:52:50
// Design Name: 
// Module Name: LED_Module
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


module LED_Module(
    input sys_clk,
    input sys_rst,
    output led0,
    output led1,
    input [255:0]uart_reg,
    input uart_ready
    );
reg [31:0]time_cnt;
reg led0_r;
reg led1_r;
reg [7:0] led_reg;

// always@(posedge sys_clk,negedge sys_rst)
// begin
// if(!sys_rst)
//     begin
//     led0_r <= 0 ;
//     led1_r <= 1 ;
//     time_cnt <= 32'd0 ;
// end
// else if(time_cnt >= 32'd49_999_999)
// begin
//     led0_r <= ~led0_r  ;
//     led1_r <= ~led1_r  ;
//     time_cnt <= 32'd0;
// end
// else
// begin
//     led0_r <= led0_r  ;
//     led1_r <= led1_r  ;
//     time_cnt <= time_cnt + 32'd1;
// end
// end
// assign led0=led0_r;
// assign led1=led1_r;

always @(posedge sys_clk or negedge sys_rst) begin
    if(!sys_rst)begin
      led_reg<=1'd0;
    end
    else if(uart_ready&&(uart_reg[255:24]==232'd0)&&(uart_reg[23:8]==16'hAA_01))begin
      led_reg<=uart_reg[7:0];
    end
end

always @(posedge sys_clk or negedge sys_rst) begin
    if(!sys_rst)begin
      led0_r<=1'b0;
    end
    else if(led_reg[7:4]==4'd0)begin
      led0_r<=1'd0;
    end
    else begin
      led0_r<=1'd1;
    end
end

always @(posedge sys_clk or negedge sys_rst) begin
    if(!sys_rst)begin
      led1_r<=1'b0;
    end
    else if(led_reg[3:0]==4'd0)begin
      led1_r<=1'b0;
    end
    else begin
      led1_r<=1'b1;
    end
end

assign led0=led0_r;
assign led1=led1_r;
endmodule
