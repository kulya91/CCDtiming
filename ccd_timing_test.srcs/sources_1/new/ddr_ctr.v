`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/14 11:01:52
// Design Name: 
// Module Name: ddr_ctr
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


module ddr_ctr
#(
    parameter  APP_DATA_WIDTH        = 128
)
(
    /*************ddrʱ��*************/
	(*mark_debug = "true"*)input            	    ui_clk,                 //input ui_clk
	(*mark_debug = "true"*)input            	    rst_n,                  //input rst_n
    /*************ddr��ַ*************/
	(*mark_debug = "true"*)output      [27:0]      app_addr,               //output app_addr [27:0]
	(*mark_debug = "true"*)output      [2:0]       app_cmd,                //output app_cmd [2:0]
	(*mark_debug = "true"*)output                	app_en,                 //output app_en
    /*************ddrд*************/
	(*mark_debug = "true"*)output      [APP_DATA_WIDTH-1:0]     app_wdf_data,           //output app_wdf_data [127:0]
	(*mark_debug = "true"*)output             	    app_wdf_end,            //output app_wdf_end
	(*mark_debug = "true"*)output                 	app_wdf_wren,           //output app_wdf_wren
    /*************ddr��*************/
	(*mark_debug = "true"*)input       [APP_DATA_WIDTH-1:0]     app_rd_data,            //input app_rd_data [127:0]
	(*mark_debug = "true"*)input            	    app_rd_data_valid,      //input app_rd_data_valid
    /*************ddr״̬*************/
	(*mark_debug = "true"*)input            	    app_rdy,                //input app_rdy
	(*mark_debug = "true"*)input            	    app_wdf_rdy,            //input app_wdf_rdy
    /*************����״̬*************/
    (*mark_debug = "true"*)input                   uart_clk,               //input uart_clk
    (*mark_debug = "true"*)input       [255:0]     uart_reg,               //input uart_reg [255:0]
    (*mark_debug = "true"*)output      [127:0]     ddr_rd_data,             //output ddr_rd_data [127:0]
    (*mark_debug = "true"*)input                   uart_ready,             //input uart_ready
    (*mark_debug = "true"*)output                  ddr_read_ready           //output ddr_read_ready
    );
/**********************ͬ�����ڽ��������ź�***************************/
reg uart_ready_d0;
wire uart_ready_flag;//ddrʱ���µĴ��ڽ��������ź�
always@(posedge ui_clk or negedge rst_n)begin
  if(!rst_n) begin
    uart_ready_d0<=1'b0;
  end
  else begin
    uart_ready_d0<=uart_ready;
  end
end
assign uart_ready_flag=uart_ready&&~uart_ready_d0;
/**********************ͬ�����ڷ��������ź�***************************/
/*
ddrtclk     _______|��|__________________
flag        _______|������|_______________
uartclk     _______|��������|_____________
uart_d      _______________|��������|_____
*/
wire ddrclk_read_ready;             //ddrʱ���µĴ��ڷ��������ź�
reg read_ready_flag;                //��־λ
reg uartclk_read_ready;             //uartʱ���µĴ��ڷ��������ź�
reg uartclk_read_ready_d;           //uartʱ���µĴ��ڷ�����������ź�
reg app_rd_data_valid_d;

always @(posedge ui_clk or negedge rst_n) begin//��һ��
    if(!rst_n) begin
      app_rd_data_valid_d<=1'd0;
    end
    else begin
      app_rd_data_valid_d<=app_rd_data_valid;
    end
end

assign ddrclk_read_ready=app_rd_data_valid&&~app_rd_data_valid_d;

reg [APP_DATA_WIDTH-1:0]ddr_rd_data_r;
always @(posedge ui_clk or negedge rst_n) begin//��һ��
    if(!rst_n) begin
      ddr_rd_data_r<=127'h123456789;
    end
    else if(ddrclk_read_ready)begin
      ddr_rd_data_r<=app_rd_data;
    end
end

always @(posedge ui_clk or negedge rst_n) begin
    if(!rst_n) begin
      read_ready_flag<=1'd0;
    end
    else if(ddrclk_read_ready) begin
      read_ready_flag<=1'd1;
    end
    else if(uartclk_read_ready) begin
      read_ready_flag<=1'd0;
    end
end


always @(posedge uart_clk or negedge rst_n) begin//չ��
    if(!rst_n) begin
      uartclk_read_ready<=1'd0;
    end
    else if(read_ready_flag) begin
      uartclk_read_ready<=1'd1;
    end
    else begin
      uartclk_read_ready<=1'd0;
    end
end

always @(posedge uart_clk or negedge rst_n) begin//��һ��
    if(!rst_n) begin
      uartclk_read_ready_d<=1'd0;
    end
    else begin
      uartclk_read_ready_d<=uartclk_read_ready;
    end
end

/**********************���մ�������***************************/
reg read_flag;
reg write_flag;
reg [31:0] ddr_addr;
reg [127:0]ddr_wirte_data;
always @(posedge ui_clk or negedge rst_n) begin
    if(!rst_n)begin
      read_flag<=1'd0;
      write_flag<=1'd0;
      ddr_addr<=32'd0;
      ddr_wirte_data<=127'd0;
    end
    else if(uart_ready_flag&&uart_reg[255:56]==200'd0&&uart_reg[55:32]==24'hAA_02_01)begin
      //read
      read_flag<=1'd1;
      write_flag<=1'd0;
      ddr_addr<=uart_reg[31:0];
    end
    else if(uart_ready_flag&&uart_reg[255:184]==72'd0&&uart_reg[183:160]==24'hAA_02_00)begin
      //write
      read_flag<=1'd0;
      write_flag<=1'd1;
      ddr_addr<=uart_reg[159:128];
      ddr_wirte_data<=uart_reg[127:0];
    end
    else begin
      read_flag<=1'd0;
      write_flag<=1'd0;
    end
end
//----------------------- sdram״̬����д״̬���� -------------------------//    

parameter [2:0]M_S_IDLE         =3'd0;
parameter [2:0]M_S_RD           =3'd1;
parameter [2:0]M_S_WR           =3'd2;

(*mark_debug = "true"*)reg [2:0]                       state;
reg [2:0]                       state_next;

parameter    [2:0]CMD_WRITE   =3'b000;//write cmd
parameter    [2:0]CMD_READ    =3'b001;//read cmd
reg    app_en_r;//��������ʹ��
reg    [2:0]app_cmd_r ;//��������
reg    [27:0]app_addr_r;//��д��ַ

reg    [127:0]app_wdf_data_r;//д�������
reg    app_wdf_wren_r;//дʹ��

always @(posedge ui_clk or negedge rst_n) begin
    if(!rst_n) begin
        state           <= M_S_IDLE;            //״̬��
        app_en_r        <= 1'd0;                //��������ʹ��
        app_cmd_r       <= 3'b000;              //��������
        app_addr_r      <= 28'd0;               //��д��ַ
        app_wdf_data_r  <= 128'd0;              //д�������
        app_wdf_wren_r  <= 1'd0;                //дʹ��
    end
    else begin
      case(state)
         M_S_IDLE:begin
             if(read_flag)
                state           <= M_S_RD;                                           //״̬��
             else if(write_flag)
                state           <= M_S_WR;                                           //״̬��
            app_en_r        <= 1'd0;                                                //��������ʹ��
            app_cmd_r       <= CMD_READ;                                              //��������
            //app_addr_r      <= ddr_addr[27:0];                                    //��д��ַ
            //app_wdf_data_r  <= 127'd0;                                            //д�������
            app_wdf_wren_r  <= 1'd0;                                                //дʹ��
        end
        M_S_RD:begin
            state           <= app_rdy?M_S_IDLE:M_S_RD;                             //״̬��
            app_en_r        <= app_rdy?1'd1:1'd0;                                   //��������ʹ��
            app_cmd_r       <= CMD_READ;                                            //��������
            app_addr_r      <= ddr_addr[27:0];                                      //��д��ַ
            app_wdf_data_r  <= 128'd0;                                              //д�������
            app_wdf_wren_r  <= 1'd0;                                                //дʹ��
        end
        M_S_WR:begin
            state           <= (app_rdy && app_wdf_rdy)?M_S_IDLE:M_S_WR;            //״̬��
            app_en_r        <= (app_rdy && app_wdf_rdy)?1'd1:1'd0;                  //��������ʹ��
            app_cmd_r       <= CMD_WRITE;                                           //��������
            app_addr_r      <= ddr_addr[27:0];                                      //��д��ַ
            app_wdf_data_r  <= ddr_wirte_data;                                      //д�������
            app_wdf_wren_r  <= (app_rdy && app_wdf_rdy)?1'd1:1'd0;                  //дʹ��
            end
      endcase
    end
end
//-------------------------------DDR�ӿ�-----------------------------------//



assign    app_en        = app_en_r;//��������ʹ��
assign    app_cmd       = app_cmd_r;//��������
assign    app_addr      = app_addr_r;//��д��ַ

assign    app_wdf_data  = app_wdf_data_r;//д�������
assign    app_wdf_wren  = app_wdf_wren_r;//дʹ��
assign    app_wdf_end   = app_wdf_wren_r;//������ȼ���

assign    ddr_rd_data =ddr_rd_data_r ;//��ȡ������

assign    ddr_read_ready=uartclk_read_ready&&~uartclk_read_ready_d;

endmodule
