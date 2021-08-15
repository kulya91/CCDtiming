`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/28 19:36:50
// Design Name: 
// Module Name: uart_tb
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


module uart_tb;
reg clk;
reg rst_n;
wire tx;
reg rx;
wire led0;
wire led1;

	parameter CLK_FRE = 50;     //clock frequency(Mhz)
	parameter BAUD_RATE = 115200; //serial baud rate
	localparam                       CYCLE = CLK_FRE * 1000000 / BAUD_RATE*20;
    localparam                       IDLE_TIME= CYCLE * 10 * 5;//idle time 5 cycle
reg [9:0] data1;
reg [9:0] data2;
reg [9:0] data3;
reg [9:0] data4;
reg [9:0] count;
/*initial begin
    data1={1'b1,8'h1,1'b0};
    data2={1'b1,8'h2,1'b0};
    data3={1'b1,8'h3,1'b0};
    data4={1'b1,8'h4,1'b0};
    clk=0;
    rst_n=0;
    rx=1;
    #1000;
    rst_n=1;
    #1000;
    for ( count=0 ;count<10; count=count+1) begin
         rx=data1[count];
         #CYCLE;
    end 
    #CYCLE;
    for ( count=0 ;count<10; count=count+1) begin
         rx=data2[count];
         #CYCLE;
    end
    #CYCLE;
    for ( count=0 ;count<10; count=count+1) begin
         rx=data3[count];
         #CYCLE ;
    end
    #CYCLE;
        for ( count=0 ;count<10; count=count+1) begin
         rx=data4[count];
         #CYCLE ;
    end
    #IDLE_TIME;
        for ( count=0 ;count<10; count=count+1) begin
         rx=data1[count];
         #CYCLE;
    end 
    #CYCLE;
    for ( count=0 ;count<10; count=count+1) begin
         rx=data2[count];
         #CYCLE;
    end
    #CYCLE;
    for ( count=0 ;count<10; count=count+1) begin
         rx=data3[count];
         #CYCLE ;
    end
    #CYCLE;
        for ( count=0 ;count<10; count=count+1) begin
         rx=data4[count];
         #CYCLE ;
    end
end*/
wire [255:0]                 uart_reg;
wire                        uart_ready;
reg [127:0]ddr_rd_data;
reg ddr_read_ready;

 initial begin
    data1={1'b1,8'h1,1'b0};
    data2={1'b1,8'h2,1'b0};
    data3={1'b1,8'h3,1'b0};
    data4={1'b1,8'h4,1'b0};
    ddr_rd_data<=128'h12_34_56_78_90_12_34_56_78_90_12_34_56_78_90_aa;
    ddr_read_ready<=1'd0;
    clk=0;
    rst_n=0;
    rx=1;
    #1000;
    rst_n=1;
    #1000;
    ddr_read_ready<=1'd1;
    #20;
    ddr_read_ready<=1'd0;

end
always #10 clk=~clk;
uart_test uart(
    .sys_clk(clk),
    .rst_n(rst_n),
    .uart_rx(rx),
    .uart_tx(tx),
    .uart_reg(uart_reg),
    .uart_ready(uart_ready),
    .ddr_rd_data(ddr_rd_data),
    .ddr_read_ready(ddr_read_ready)
);
LED_Module led(
    .sys_clk(clk),
    .sys_rst(rst_n),
    .led0(led0),
    .led1(led1)
);
endmodule
