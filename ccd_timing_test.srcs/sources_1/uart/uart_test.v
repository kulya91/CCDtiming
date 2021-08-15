module uart_test(
    input                        sys_clk,       //system clock 50Mhz on board
    input                        rst_n,        //reset ,low active
	input                        uart_rx,
	output                       uart_tx,
    output [255:0]               uart_reg,              //uart reg 
    output                       uart_ready,             //if update ready=1
    input [127:0]                ddr_rd_data,
    input                        ddr_read_ready
);

parameter                        CLK_FRE    =  50;              //Mhz
parameter                        BPS        =  115200;          //uart bps
parameter                        IDLE_CYCLE =  2;               //idle time
localparam                       TX_DATA_LENGTH=128;
/*******************************************************************/
reg                              tx_data_valid;
wire                             tx_data_ready;
wire                             tx_interrupt;
reg[7:0]                         tx_data;

wire                             rx_data_valid;
wire                             rx_data_ready;
wire                             rx_frame_idle;
wire                             rx_bit_idle;
wire[11:0]                       rx_frame_bit_num;
wire[7:0]                        rx_data;
reg[11:0]                        rx_shift_n;//接收移位计数
/*******************************************************************/
/*******************************************************************/
wire [7:0]                     din;            // input wire [7 : 0] din
wire                            wr_en;          // input wire wr_en
wire                            rd_en;          // input wire rd_en
wire [7:0]                      dout;           // output wire [47 : 0] dout
wire                            full;           // output wire full
wire                            empty;          // output wire empty
wire                            wr_ack;         // output wire wr_ack
wire                            valid;          // output wire valid

/*******************************************************************/
assign rx_data_ready = 1'b1;
assign uart_ready=rx_frame_idle;
//移位寄存器计数
always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      rx_shift_n<=11'd0;
    end
    else if(rx_data_valid==1&&rx_data_ready==1)begin
      rx_shift_n<=rx_shift_n+1'd1;
    end
    else if(rx_frame_idle)begin
      rx_shift_n<=1'd0;
    end
end
reg [255:0]uart_reg_r;
//接收数据
always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      uart_reg_r<=255'd0;
    end
    else if(rx_data_valid==1&&rx_data_ready==1)begin
      uart_reg_r<={uart_reg_r,rx_data};
    end
    else if(rx_frame_idle)begin
      uart_reg_r<=255'd0;
    end
end
assign uart_reg=(rx_frame_idle)?uart_reg_r:uart_reg;
/*******************************************************************/
//fifo write data
reg [7:0]din_r;
reg wr_en_r;
reg fifo_write_flag;
reg [11:0] fifo_write_shift;
reg[127:0] ddr_rd_data_r;
always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      fifo_write_flag<=1'd0;
    end
    else if(ddr_read_ready)begin
      fifo_write_flag<=1'd1;
    end
    else if(fifo_write_shift>=15) begin
    fifo_write_flag<=1'd0;
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      fifo_write_shift<=12'd0;
    end
    else if(fifo_write_flag)begin
      fifo_write_shift<=fifo_write_shift+12'd1;
    end
    else begin
      fifo_write_shift<=12'd0;
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      ddr_rd_data_r<=128'd0;
    end
    else if(ddr_read_ready)begin
      ddr_rd_data_r<=ddr_rd_data;
    end
    else if(fifo_write_flag) begin
    ddr_rd_data_r<=ddr_rd_data_r<<8;
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      din_r<=8'd0;
      wr_en_r<=1'd0;
    end
    else if(fifo_write_flag)begin
      din_r<=ddr_rd_data_r[127:120];
      wr_en_r<=1'd1;
    end
    else begin
      wr_en_r<=1'd0;
    end
end
assign wr_en=wr_en_r;
assign din=din_r;
/***********************发送状态机********************************************/
reg[3:0]                         tx_state;
reg[3:0]                         tx_next_state;
localparam                       TX_IDLE =  0;
localparam                       TX_READ =  1;   //send HELLO ALINX\r\n
localparam                       TX_WRITE =  2;   //wait 1 second and send uart received data
always@(posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)begin
      tx_state<=TX_IDLE;
    end
    else begin
      tx_state<=tx_next_state;
    end
end

always @(*) begin
  case(tx_state)
  TX_IDLE:begin
    if(!empty&&tx_data_ready)//如果有数据就读
        tx_next_state<=TX_READ;
    else
        tx_next_state<=TX_IDLE;
  end
  TX_READ:begin
    if(valid) begin
      tx_next_state<=TX_WRITE;
    end
    else begin
      tx_next_state<=TX_READ;
    end
  end
  TX_WRITE:begin
    if(tx_interrupt) begin
      tx_next_state<=TX_IDLE;
    end
    else
        tx_next_state<=TX_WRITE;
  end
  endcase
end

//fifo read data
reg rd_en_r;
always @(posedge sys_clk or negedge rst_n) begin
    if(!rst_n)begin
      rd_en_r<=1'b0;
    end
    else if(tx_next_state==TX_READ)begin//当fifo 中有数据，并且 uart tx在空闲状态
      rd_en_r<=1'b1;
    end
    else if(tx_next_state==TX_WRITE)begin
      rd_en_r<=1'b0;
    end
end

assign rd_en=rd_en_r;

//uart tx
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		tx_data <= 8'd0;
		tx_data_valid <= 1'b0;
	end
	else if(tx_next_state==TX_WRITE)
		begin	
				tx_data <=dout;
                tx_data_valid <= 1'b1;
		end
    else if(tx_next_state==TX_IDLE)begin
      tx_data_valid <= 1'b0;
    end
end
/*******************************************************************/
uart_rx#
(
	.CLK_FRE(CLK_FRE),
	.BAUD_RATE(BPS),
    .IDLE_CYCLE(IDLE_CYCLE)
) uart_rx_inst
(
    .clk                        (sys_clk                  ),
    .rst_n                      (rst_n                    ),
    .rx_data                    (rx_data                  ),
    .rx_data_valid              (rx_data_valid            ),
    .rx_data_ready              (rx_data_ready            ),
    .rx_frame_idle              (rx_frame_idle            ),
    .rx_frame_bit_num           (rx_frame_bit_num         ),
    .rx_bit_idle                (rx_bit_idle              ),
    .rx_pin                     (uart_rx                  )
);

uart_tx#
(
	.CLK_FRE(CLK_FRE),
	.BAUD_RATE(BPS)
) uart_tx_inst
(
    .clk                        (sys_clk                  ),
    .rst_n                      (rst_n                    ),
    .tx_data                    (tx_data                  ),
    .tx_data_valid              (tx_data_valid            ),
    .tx_data_ready              (tx_data_ready            ),
    .tx_interrupt               (tx_interrupt             ),
    .tx_pin                     (uart_tx                  )
);
wire fifo_rst;
assign fifo_rst=~rst_n;
fifo_tx fifo_tx_inst (
    .clk                        (sys_clk            ),          // input wire clk
    .srst                       (fifo_rst           ),          // input wire srst
    .din                        (din                ),          // input wire [63 : 0] din
    .wr_en                      (wr_en              ),          // input wire wr_en
    .rd_en                      (rd_en              ),          // input wire rd_en
    .dout                       (dout               ),          // output wire [7 : 0] dout
    .full                       (full               ),          // output wire full
    .wr_ack                     (wr_ack             ),          // output wire wr_ack
    .empty                      (empty              ),          // output wire empty
    .valid                      (valid              )           // output wire valid
);

endmodule
