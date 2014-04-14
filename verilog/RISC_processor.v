//SW17 = rst, SW16= en

module RISC_processor (CLOCK_50,SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,LEDR,LEDG);
	parameter word_size = 10;
	parameter data_size = 8;

input CLOCK_50;
input [17:15]SW;
output [12:0] LEDR;

output [7:0] LEDG;
output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;

wire [word_size-1:0] PORT;
//assign PORT_out = (en_PORT==1)? mem_word:PORT_out;

wire clk, rst,clk_tmp,en_io;
assign rst = SW[17];
wire en_PORT;
//assign LEDR[12] = en_PORT;


wire [data_size-1: 0] R0_out, R1_out, R2_out, R3_out,PC_count;
wire [word_size-1: 0] instruction;
wire [word_size-1: 0] mem_word;
wire zero;
wire en;
assign en = SW[16];
wire [3:0] state,next_state;
RISC_SPM machine(.clk(clk),.rst(rst),.R0_out(R0_out),.R1_out(R1_out)
				,.R2_out(R2_out),.R3_out(R3_out),.PC_count(PC_count)
				,.instruction(instruction),.zero(zero),.state(state)
				,.next_state(next_state),.PORT(PORT));

generator gen1(CLOCK_50,clk_tmp);
assign clk = (en==1)? clk_tmp:clk;

decoderBCD R0_L(HEX2,R0_out[3:0]);
decoderBCD R0_H(HEX0,state[3:0]);//state
decoderBCD R1_L(HEX3,R1_out[3:0]);
decoderBCD R1_H(HEX1,next_state[3:0]); //next_state
decoderBCD R2_L(HEX4,R2_out[3:0]);
decoderBCD R2_H(HEX5,R2_out[7:4]);
decoderBCD R3_L(HEX6,R3_out[3:0]);
decoderBCD R3_H(HEX7,R3_out[7:4]);

assign LEDG[7:0] = PC_count;
assign LEDR[9:0] = PORT;
assign LEDR[10] = clk;
assign LEDR[11] = zero;
endmodule
