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
    input [47:0]uart_reg,
    input uart_ready
    );
reg [31:0]time_cnt;
reg led0_r;
reg led1_r;
reg [31:0] led_reg;

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
    else if((uart_reg[47:32]==16'h0101)&&uart_ready)begin
      led_reg<=uart_reg[31:0];
    end
end

always @(posedge sys_clk or negedge sys_rst) begin
    if(!sys_rst)begin
      led0_r<=1'b0;
      led1_r<=1'b0;
    end
    else if(led_reg==31'd0)begin
      led0_r<=1'd0;
      led1_r<=1'b1;
    end
    else begin
      led0_r<=1'd1;
      led1_r<=1'b0;
    end
end
assign led0=led0_r;
assign led1=led1_r;
endmodule
