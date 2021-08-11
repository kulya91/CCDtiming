//*******************************************************************************/
module uart_rx
#(
	parameter CLK_FRE       =   50,                                         //clock frequency(Mhz)
	parameter BAUD_RATE     =   115200,                                     //serial baud rate
    parameter IDLE_CYCLE    =    2                                          //空闲周期
)
(
    input                        clk,                                       //时钟
    input                        rst_n,                                     //复位
    output reg[7:0]              rx_data,                                   //数据
    output reg                   rx_data_valid,                             //有效
    input                        rx_data_ready,                             //完成
    output                       rx_frame_idle,                             //空闲中断
    output reg[11:0]             rx_frame_bit_num,                          //数据计数
    output                       rx_bit_idle,                               //接收中断
    input                        rx_pin                                     //
);
//calculates the clock cycle for baud rate 
localparam                       CYCLE = CLK_FRE * 1000000 / BAUD_RATE;     //bit周期
localparam                       IDLE_TIME= CYCLE * 10 * IDLE_CYCLE;        //空闲判定时间
//state machine code
localparam                       S_IDLE      = 1;                           //空闲
localparam                       S_START     = 2;                           //start bit
localparam                       S_REC_BYTE  = 3;                           //data bits
localparam                       S_STOP      = 4;                           //stop bit
localparam                       S_DATA      = 5;

reg[2:0]                         state;
reg[2:0]                         next_state;
reg                              rx_d0;                                     //delay 1 clock for rx_pin
reg                              rx_d1;                                     //delay 1 clock for rx_d0
wire                             rx_negedge;                                //数据下降沿 
reg[7:0]                         rx_bits;                                   //接受数据的临时存储
reg[15:0]                        cycle_cnt;                                 //baud counter
reg[2:0]                         bit_cnt;                                    //bit counter
reg[31:0]                        idle_cnt;


always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	begin
		rx_d0 <= 1'b0;
		rx_d1 <= 1'b0;	
	end
	else
	begin
		rx_d0 <= rx_pin;
		rx_d1 <= rx_d0;
	end
end

assign rx_negedge = rx_d1 && ~rx_d0;  //下降沿

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		state <= S_IDLE;
	else
		state <= next_state;
end

always@(*)
begin
	case(state)
		S_IDLE:
			if(rx_negedge)
				next_state <= S_START;
			else
				next_state <= S_IDLE;
		S_START:
			if(cycle_cnt == CYCLE - 1)//一个周期脉冲后，转到接收状态
				next_state <= S_REC_BYTE;
			else
				next_state <= S_START;
		S_REC_BYTE:
			if(cycle_cnt == CYCLE - 1  && bit_cnt == 3'd7)  //接受完成8bit，转移到停止位
				next_state <= S_STOP;
			else
				next_state <= S_REC_BYTE;
		S_STOP:
			if(cycle_cnt == CYCLE/2 - 1)//半位周期，避免错过下一个字节接收器
				next_state <= S_DATA;
			else
				next_state <= S_STOP;
		S_DATA:
			if(rx_data_ready)    //数据接受完成
				next_state <= S_IDLE;
			else
				next_state <= S_DATA;
		default:
			next_state <= S_IDLE;
	endcase
end


//锁存接收到的数据
always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
		rx_data <= 8'd0;
	else if(state == S_STOP && next_state != state)
		rx_data <= rx_bits;//latch received data
end

//bit时钟计数
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		cycle_cnt <= 16'd0;
	else if((state == S_REC_BYTE && cycle_cnt == CYCLE - 1) || next_state != state)//状态跳变时清空，接受状态每一个字节清空一次
		cycle_cnt <= 16'd0;
	else
		cycle_cnt <= cycle_cnt + 16'd1;	
end
//receive serial data bit data
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		rx_bits <= 8'd0;
	else if(state == S_REC_BYTE && cycle_cnt == CYCLE/2 - 1)
		rx_bits[bit_cnt] <= rx_d1;
	else
		rx_bits <= rx_bits; 
end

//bit计数
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		begin
			bit_cnt <= 3'd0;
		end
	else if(state == S_REC_BYTE)
		if(cycle_cnt == CYCLE - 1)//当接受状态的最后bit数+1
			bit_cnt <= bit_cnt + 3'd1;
		else
			bit_cnt <= bit_cnt;
	else
		bit_cnt <= 3'd0;
end

//更新数据准备状态
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		rx_data_valid <= 1'b0;
	else if(state == S_STOP && next_state != state)//停止位的开始
	    rx_data_valid <= 1'b1;
	else if(state == S_DATA && rx_data_ready)
		rx_data_valid <= 1'b0;
end

/*
以下为自行添加的内容
add：
    串口接收中断                    rx_bit_idle
    串口空闲中断                    rx_frame_idle
    串口空闲接收的数据位数           rx_frame_bit_num
*/
//bit空闲标志
reg bit_idle_flag;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
      bit_idle_flag<=1'd0;
    end
    else if(state == S_STOP && next_state != state)
    bit_idle_flag<=1'd1;
    else if(state==S_START)
    bit_idle_flag<=1'd0;
end

//bit空闲标志打拍
reg bit_idle_flag_n;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        bit_idle_flag_n<=1'b0;
        end
    else begin
      bit_idle_flag_n<=bit_idle_flag;
    end
end
//bit中断
assign rx_bit_idle=bit_idle_flag&&~bit_idle_flag_n;

//空闲时间计数
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        idle_cnt<=1'd0;
    end
    else if(bit_idle_flag==1&&idle_cnt<=2*IDLE_TIME)
        idle_cnt <= idle_cnt + 1'd1;
    else if(!bit_idle_flag)begin
        idle_cnt<=0;
    end
end

//帧空闲标志
reg frame_idle_flag;
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        frame_idle_flag<=1'd0;
    end
    else if(idle_cnt>=IDLE_TIME)begin
        frame_idle_flag<=1'b1;
    end
    else begin
        frame_idle_flag<=1'b0;
    end
end

//帧空闲标志打拍
reg frame_idle_flag_n;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        frame_idle_flag_n<=1'b0;
    end
    else begin
        frame_idle_flag_n<=frame_idle_flag;
    end
end
assign rx_frame_idle=frame_idle_flag&&~frame_idle_flag_n;

//空闲数据计数
//ps：rx_bit_num要和rx_idle同时产生
reg [11:0]rx_bit_num_r;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
      rx_bit_num_r<=11'd0;
    end
    else if(rx_bit_idle==1)begin
      rx_bit_num_r<=rx_bit_num_r+11'd1;
    end
    else if(~frame_idle_flag&&frame_idle_flag_n)begin//下降沿
      rx_bit_num_r<=11'd0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        rx_frame_bit_num<=1'd0;
    end
    else if(frame_idle_flag)begin
        rx_frame_bit_num<=rx_bit_num_r;
    end
    else begin
        rx_frame_bit_num<=1'b0;
    end
end
endmodule