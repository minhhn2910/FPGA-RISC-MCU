module Alu_RISC (alu_zero_flag, alu_out, data_1, data_2, sel);
  parameter word_size = 10, op_size = 4;
  parameter data_size = 8;
  // Opcodes
  // Opcodes
  parameter ADD = 0, SUB = 1, AND = 2, OR = 3, NOT = 4;
  parameter JUMP = 4'b011x, STORE = 4'b100x,LOAD = 4'b101x, SAVE = 4'b11xx;
  
  output 		alu_zero_flag;
  output 	[data_size-1: 0] 	alu_out;
  input 	[data_size-1: 0] 	data_1, data_2;
  input 	[op_size-1: 0] 	sel;
  reg 	 	[data_size-1: 0]alu_out_temp;
  assign alu_out=alu_out_temp;
  
  assign  alu_zero_flag = ~|alu_out_temp;
  always @ (sel or data_1 or data_2)  
     casex  (sel)
      ADD:	alu_out_temp = data_1 + data_2; 
	  SUB:	alu_out_temp = data_2 - data_1;
      AND:	alu_out_temp = data_1 & data_2;
      OR :  alu_out_temp = data_1 | data_2;
	  NOT:	alu_out_temp = ~ data_2;
	  
      default: 	alu_out_temp = 0;
    endcase 
endmodule
