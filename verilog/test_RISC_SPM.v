
module test_RISC_SPM ();
  reg rst;
  wire clk;
  parameter word_size = 10;
  parameter data_size = 8;
  wire [data_size-1: 0] R0_out, R1_out, R2_out, R3_out;
  wire [word_size-1: 0] mem_word;
  reg [8: 0] k;
  Clock_Unit M1 (clk);
  RISC_SPM M2 (clk, rst,R0_out, R1_out, R2_out, R3_out,mem_word);
// define probes
  
  //instruction = 0 -> 110
  wire [word_size-1: 0] word0, word1, word2, word3,word4, word5,word6, 
  word7,word8, word9,word10, word11,word12, word13, word14,word15;		// instructions
  //data = 112 -> 127  (70->7f)
  wire [word_size-1: 0] word112, word113; 		// data
  
  assign word0 = M2.M2_SRAM.memory[0];  	// words 1 to 13 
  assign word1 = M2.M2_SRAM.memory[1];
  assign word2 = M2.M2_SRAM.memory[2];
  assign word3 = M2.M2_SRAM.memory[3];
  assign word4 = M2.M2_SRAM.memory[4];
  assign word5 = M2.M2_SRAM.memory[5];
  assign word6 = M2.M2_SRAM.memory[6];
  assign word7 = M2.M2_SRAM.memory[7];
  assign word8 = M2.M2_SRAM.memory[8];
  assign word9 = M2.M2_SRAM.memory[9];
  assign word10 = M2.M2_SRAM.memory[10];
  
  assign word112 = M2.M2_SRAM.memory[112];
  assign word113 = M2.M2_SRAM.memory[113];
  
   initial #2800 $finish;		// set end point for simulation
 initial begin: Flush_Memory
  #2 rst = 0; for (k=0; k<=255; k=k+1) M2.M2_SRAM.memory[k] = 0; #10 rst = 1;  end // Flush_Memory
initial begin: Load_program #5
	// Code block : 0x00 -> 0x6f
  M2.M2_SRAM.memory[0] = 10'b11_00000001;		// 0 SAVE R0,1		;R0 = 1
  M2.M2_SRAM.memory[1] = 10'b0000_00_00_01;		// 1 ADD R0,R0,R1		;R1 = R0 + R0 = 2
  M2.M2_SRAM.memory[2] = 10'b0011_00_01_10;		// 2 OR R0,R1,R2		;R2 = R0 | R1 = 3
  M2.M2_SRAM.memory[3] = 10'b0100_00_00_11;		// 3 NOT R3			;R3 = ~R0 = 0xfe
  M2.M2_SRAM.memory[4] = 10'b01011_00000;		// 4 NOP
  M2.M2_SRAM.memory[5] = 10'b0001_10_00_10;		// 5 SUB R2,R0,R2		;R2 = R2 - R0   ; decrease R2 until R2=0 zero=1
  M2.M2_SRAM.memory[6] = 10'b01010_00000;		// 6 SIZ				;SKIP IF Zero = 1
  M2.M2_SRAM.memory[7] = 10'b011_0000101;		// 7 JUMP 0x05		;Goto addr=0x05
  M2.M2_SRAM.memory[8] = 10'b100_1110000;		// 8 STORE 0x70		; memory[112] = R0 = 1;
  M2.M2_SRAM.memory[9] = 10'b101_1110001;		// LOAD 0x71		; R0 = memory[113] = 5;  
  M2.M2_SRAM.memory[10]= 10'b011_0001010; 		// JUMP 0x0a		; Jump here
 
 //  Data block : 0x70 -> 0x7f
  M2.M2_SRAM.memory[112] = 2;
  M2.M2_SRAM.memory[113] = 5;
  
end 
endmodule