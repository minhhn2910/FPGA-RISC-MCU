module test_Control_Unit();

  parameter word_size = 10, op_size = 4, state_size = 4;
  parameter address_size = 8 , data_size=8;
  parameter src0_size = 2, src1_size = 2,dest_size = 2, Sel1_size = 3, Sel2_size = 3;
  // State Codes
 // parameter S_idle = 0, S_fet1 = 1, S_fet2 = 2, S_dec = 3;
 // parameter  S_ex1 = 4, S_rd1 = 5, S_rd2 = 6;  
 // parameter S_wr1 = 7, S_wr2 = 8, S_br1 = 9, S_br2 = 10, S_halt = 11, S_nop = 12;  
  // Opcodes
 // parameter ADD = 0, SUB = 1, AND = 2, OR = 3, NOT = 4;
  
 // parameter SIZ = 5'b01010;
 // parameter NOP = 5'b01011;
//  parameter OP_5 = 4'b0101;
//  parameter JUMP = 4'b011x, STORE = 4'b100x,LOAD = 4'b101x, SAVE = 4'b11xx;
  // Source and Destination Register Codes  
  // parameter R0 = 0, R1 = 1, R2 = 2, R3 = 3; 
 // See textbook for output, input, and reg declarations  

wire Load_R0, Load_R1,  Load_R2, Load_R3,  Load_PC,Inc_PC;
wire  [Sel1_size-1:0]Sel_Bus_1a_Mux,Sel_Bus_1b_Mux;
wire  [Sel2_size-1:0]Sel_Bus_2_Mux;
wire Load_IR, Load_Add_R, Load_Reg_Z,  write;
wire [address_size-1:0] address_decoded;
wire  [data_size-1:0] constant_decoded;
reg  [word_size-1:0]instruction;
reg  zero, clk, rst;

wire[state_size-1:0]state = unit1.state[state_size-1:0];
wire[state_size-1:0] next_state = unit1.next_state[state_size-1:0];
//reg Load_R0,Load_R1,Load_R2,Load_R3,Load_PC,Inc_PC;
//reg Load_IR,Load_Add_R;


Control_Unit unit1(Load_R0, Load_R1,  Load_R2, Load_R3,  Load_PC, 
Inc_PC, Sel_Bus_1a_Mux,Sel_Bus_1b_Mux, Sel_Bus_2_Mux, Load_IR, Load_Add_R, 
 Load_Reg_Z,  write, address_decoded, constant_decoded, instruction, zero, clk, rst);
	
initial
	begin
		clk = 0;
	end
always #5 clk = ~clk;
	
  initial 
  
  begin
 	rst = 1;zero =0; instruction[word_size-1:0] = 10'b0000000110;  //r2 = r1 + r0
	zero = 0 ; instruction[word_size-1:0] = 10'b0100001100;   //ro = ~r0
	#35
	zero = 0 ; instruction[word_size-1:0] = 10'b01010_10101;  //skip if zero = 1
	#35
	zero = 1 ; instruction[word_size-1:0] = 10'b01010_10101;  //skip if zero = 1
	#35
	zero = 1 ; instruction[word_size-1:0] = 10'b01011_10101;  //nop

	#35
	zero = 0 ; instruction[word_size-1:0] = 10'b011_0001111;   //jump to addr = 15
	#35
	zero = 1 ; instruction[word_size-1:0] = 10'b100_0000011; //store to address = 3
	#35
	zero = 1 ; instruction[word_size-1:0] = 10'b101_0000000;  //load from address = 7
	#35
	zero = 1 ; instruction[word_size-1:0] = 10'b11_0010_0000 ;  //save 32 to r0

  end
endmodule
