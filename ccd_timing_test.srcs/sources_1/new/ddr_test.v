`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/14 20:37:36
// Design Name: 
// Module Name: ddr_test
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


(* KEEP_HIERARCHY  = "{TURE|FALSE}" *)module ddr_test(
    input                        clk_200m,
    input                        rst_n,
    input                       uart_clk,               //input uart_clk
    input       [255:0]         uart_reg,               //input uart_reg [255:0]
    output      [127:0]         ddr_rd_data,             //output ddr_rd_data [127:0]
    input                       uart_ready,             //input uart_ready
    output                      ddr_read_ready,          //output ddr_read_ready

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
// [Opt 31-67] Problem: A LUT2 cell in the design 
// is missing a connection on input pin I1, which is used
//  by the LUT equation. This pin has either been left unconne
//  cted in the design or the connection was removed due to the tri
//  mming of unused logic. The LUT cell name is: u_mig_7series_0/u_mig_7series_0_mig/u_memc_ui_top_std/u_ui_top/ui_cmd0/app_addr_r1[26]_i_1.

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
wire                                  app_rdy;
wire [APP_DATA_WIDTH-1:0]             app_rd_data;

wire                                  app_rd_data_valid;
wire [APP_DATA_WIDTH-1:0]             app_wdf_data;

wire                                  app_wdf_rdy;
wire                                  app_wdf_wren;

wire                                  app_rd_data_end;//
wire                                  app_wdf_end;//
wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;//
wire                                  app_sr_active;
wire                                  app_ref_ack;
wire                                  app_zq_ack;
wire init_calib_complete;
wire ui_clk;
wire ui_rst;

  mig_7series_0 u_mig_7series_0
   (

    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
      
	.ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
    // Application interface ports
    .app_addr                       (app_addr),  // input [27:0]		app_addr
    .app_cmd                        (app_cmd),  // input [2:0]		app_cmd
    .app_en                         (app_en),  // input				app_en
    .app_wdf_data                   (app_wdf_data),  // input [127:0]		app_wdf_data
    .app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren
    .app_rd_data                    (app_rd_data),  // output [127:0]		app_rd_data
    .app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
    .app_rdy                        (app_rdy),  // output			app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
    .app_sr_req                     (1'd0),  // input			app_sr_req
    .app_ref_req                    (1'd0),  // input			app_ref_req
    .app_zq_req                     (1'd0),  // input			app_zq_req
    .app_sr_active                  (app_sr_active),  // output			app_sr_active
    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
    .ui_clk                         (ui_clk),  // output			ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
    .app_wdf_mask                   (16'd0),  // input [15:0]		app_wdf_mask
    // System Clock Ports
    .sys_clk_i                       (clk_200m),
    .sys_rst                        (rst_n) // input sys_rst
    );
wire app_sr_req;
wire app_ref_req;
wire app_zq_req;
ddr_ctr 
 #( .APP_DATA_WIDTH(APP_DATA_WIDTH))
 ddr_ctrer
(
    /*************ddrÊ±ÖÓ*************/
	.ui_clk                 (ui_clk),                 //input ui_clk
	.rst_n                  (rst_n),                  //input rst_n
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
    .uart_clk               (uart_clk),               //input uart_clk
    .uart_reg               (uart_reg),               //input uart_reg [255:0]
    .ddr_rd_data             (ddr_rd_data),             //output ui_rd_data [127:0]
    .uart_ready             (uart_ready),             //input uart_ready
    .ddr_read_ready          (ddr_read_ready)           //output ui_read_ready
);
endmodule
