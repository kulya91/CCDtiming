`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/15 01:56:45
// Design Name: 
// Module Name: ddr_write_tb
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


module ddr_write_tb;
localparam ADDR_WIDTH            = 28; 
localparam DATA_WIDTH            = 16;
localparam PAYLOAD_WIDTH         = DATA_WIDTH;
localparam BURST_LENGTH          = 8;
localparam APP_DATA_WIDTH        = 128;
localparam APP_MASK_WIDTH        = APP_DATA_WIDTH / 8;
      
  // Wire declarations
wire [ADDR_WIDTH-1:0]                 app_addr;
wire [2:0]                            app_cmd;
wire                                  app_en;
wire                                  app_rd_data_end;

wire [APP_DATA_WIDTH-1:0]             app_wdf_data;
wire                                  app_wdf_end;
wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;
wire                                  app_sr_active;
wire                                  app_ref_ack;
wire                                  app_zq_ack;
wire                                  app_wdf_wren;
reg ui_clk;
reg ui_rst;
reg clk_50m;
reg [127:0]app_rd_data;
reg [255:0] uart_reg;
reg uart_ready;
reg                                  app_rdy;
reg                                  app_wdf_rdy;
reg                                  app_rd_data_valid;
initial begin
    ui_clk<=1'd0;
    ui_rst<=1'd0;
    clk_50m<=1'd0;
    app_rd_data<=128'd1;
    uart_reg<={72'd0,24'hAA_02_00,32'h12_34_56_78,128'h12_34_56_78_90_12_34_56_78_90_12_34_56_78_90_aa};
    uart_ready<=1'd0;
    app_rdy<=1'd1;
    app_wdf_rdy<=1'd1;
    #100;
    ui_rst<=1'd1;
    #100;
    uart_ready<=1'd1;
    #16;
    uart_ready<=1'd0;
end
always #2 ui_clk=~ui_clk;
always #8 clk_50m=~clk_50m;
    ddr_ctr ddr_ctrtest(
    /*************ddrÊ±ÖÓ*************/
	.ui_clk                 (ui_clk),                 //input ui_clk
	.rst_n                  (ui_rst),                  //input rst_n
    /*************ddrµØÖ·*************/
	.app_addr               (app_addr),               //output app_addr [27:0]
	.app_cmd                (app_cmd),                //output app_cmd [2:0]
	.app_en                 (app_en),                 //output app_en
    /*************ddrÐ´*************/
	.app_wdf_data           (app_wdf_data),           //output app_wdf_data [127:0]
	.app_wdf_end            (app_wdf_end),            //output app_wdf_end
	.app_wdf_wren           (app_wdf_wren),           //output app_wdf_wren
    /*************ddr¶Á*************/
	.app_rd_data            (app_rd_data),            //input app_rd_data [127:0]
	.app_rd_data_valid      (app_rd_data_valid),      //input app_rd_data_valid
    /*************ddr×´Ì¬*************/
	.app_rdy                (app_rdy),                //input app_rdy
	.app_wdf_rdy            (app_wdf_rdy),            //input app_wdf_rdy
    /*************´®¿Ú×´Ì¬*************/
    .uart_clk               (clk_50m),               //input uart_clk
    .uart_reg               (uart_reg),               //input uart_reg [255:0]
    .ddr_rd_data             (ddr_rd_data),             //output ui_rd_data [127:0]
    .uart_ready             (uart_ready),             //input uart_ready
    .ddr_read_ready          (ddr_read_ready)           //output ui_read_ready
);
endmodule
