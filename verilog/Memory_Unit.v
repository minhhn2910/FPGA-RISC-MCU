
module Memory_Unit (data_out, data_in, address, clk, write);
  parameter word_size = 10;
  parameter memory_size = 256;
  parameter address_size = 8;
  output [word_size-1: 0] data_out;
  input [word_size-1: 0] data_in;
  input [address_size-1: 0] address;
  input clk, write;
  reg [word_size-1: 0] memory [memory_size-1: 0];
  assign data_out = memory[address];
  always @ (posedge clk)
    if (write) memory[address] = data_in;

initial begin: Code_program
  memory[0] = 10'b11_00000001;		// SAVE R0,0		;R0 = 1
  memory[1] = 10'b0000_00_00_01;		// ADD R0,R0,R1		;R1 = R0 + R0 = 2
  memory[2] = 10'b0011_00_01_10;		// OR R0,R1,R2		;R2 = R0 | R1 = 3
  memory[3] = 10'b0100_00_00_11;		// NOT R3			;R3 = ~R0 = 0xfe
  memory[4] = 10'b01011_00000;		// NOP
  memory[5] = 10'b0001_10_00_10;		// SUB R2,R0,R2		;R2 = R2 - R0   ; decrease R2 until R2=0 zero=1
  memory[6] = 10'b01010_00000;		// SIZ				;SKIP IF Zero = 1
  memory[7] = 10'b011_0000101;		// JUMP 0x05		;Goto addr=0x05
  memory[8] = 10'b100_1110000;		// STORE 0x70		; memory[112] = R0 = 1;
  memory[9] = 10'b101_1110001;		// LOAD 0x71		; R0 = memory[113] = 5;  
  memory[10]= 10'b011_0001010; 		// JUMP 0x0a		; Jump here
 
 //  Data block : 0x70 -> 0x7f
  memory[112] = 2;
  memory[113] = 5;
end

endmodule
