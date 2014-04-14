 module Processing_Unit (instruction, Zflag, address, address_decoded, constant_decoded, Bus_1a,Bus_1b, mem_word, Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC, Sel_Bus_1a_Mux,Sel_Bus_1b_Mux, Load_IR, Load_Add_R, Load_Reg_Z,  Sel_Bus_2_Mux, clk, rst,R0_out, R1_out, R2_out, R3_out,PC_count);
  parameter word_size = 10;
  parameter data_size = 8;
  parameter address_size = 8; 
  parameter op_size = 4;
  parameter Sel1_size = 3;
  parameter Sel2_size = 3;
  output [word_size-1: 0] 	instruction;
  output [address_size-1:0]	address;
  output [data_size-1: 0] 	Bus_1a,Bus_1b;
  output 		Zflag;
  input [address_size-1:0] address_decoded;
  input [data_size-1 :0] constant_decoded;
  input [word_size-1: 0]  	mem_word;
  input 		Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC;
  input [Sel1_size-1: 0] 	Sel_Bus_1a_Mux,Sel_Bus_1b_Mux;
  input [Sel2_size-1: 0] 	Sel_Bus_2_Mux;
  input 			Load_IR, Load_Add_R,  Load_Reg_Z;
  input 			clk, rst;
  
  output [data_size-1: 0] 	R0_out, R1_out, R2_out, R3_out; //change from wire to output for DE2
  output [data_size-1: 0]	PC_count;
  wire			Load_R0, Load_R1, Load_R2, Load_R3;
  wire [word_size-1: 0] 	Bus_2;
  
  wire [data_size-1: 0] 	 alu_out;
  wire [data_size-1: 0]  mem_address;
  wire 			alu_zero_flag;
  wire [op_size-1 : 0] 	
  opcode = instruction [word_size-1: word_size-op_size];
  Register_Unit 	R0 	(R0_out, Bus_2, Load_R0, clk, rst);
  Register_Unit 	R1 	(R1_out, Bus_2, Load_R1, clk, rst);
  Register_Unit 	R2 	(R2_out, Bus_2, Load_R2, clk, rst);
  Register_Unit 	R3 	(R3_out, Bus_2, Load_R3, clk, rst);
  
  D_flop 		       Reg_Z (Zflag, alu_zero_flag, Load_Reg_Z, clk, rst);
  Address_Register      Add_R (address, Bus_2, Load_Add_R, clk, rst);
  Instruction_Register  IR	(instruction, Bus_2, Load_IR, clk, rst);
  Program_Counter      PC	(PC_count, Bus_2, Load_PC, Inc_PC, clk, rst);
  Multiplexer_5ch_8bit        Mux_1a (Bus_1a, R0_out, R1_out, R2_out, R3_out,             
                                 PC_count, Sel_Bus_1a_Mux);
 Multiplexer_5ch_8bit        Mux_1b (Bus_1b, R0_out, R1_out, R2_out, R3_out,             
                                 PC_count, Sel_Bus_1b_Mux);
 
 Multiplexer_5ch_10bit 	        Mux_2 (Bus_2, {2'b0,alu_out}, {2'b0,Bus_1a}, mem_word, {2'b0,address_decoded}, {2'b0,constant_decoded},
			        Sel_Bus_2_Mux);
  Alu_RISC 	        ALU (alu_zero_flag, alu_out, Bus_1b, Bus_1a, opcode);
endmodule 
