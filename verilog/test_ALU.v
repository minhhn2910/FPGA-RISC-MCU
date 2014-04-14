module test_ALU();
  parameter word_size = 10, op_size = 4;
  parameter data_size = 8;
  reg 	[data_size-1: 0] 	data_1, data_2;
  reg 	[op_size-1: 0] 	sel;
  wire 		alu_zero_flag;
  wire [data_size-1: 0] 	alu_out;
  Alu_RISC a1(alu_zero_flag, alu_out, data_1, data_2, sel);
  //  opcode ADD = 0, SUB = 1, AND = 2, OR = 3, NOT = 4
     initial #200 $finish;
  initial begin
    data_1 = 0;data_2=0; sel = 0;
    #10 data_1 = 3;data_2 = 7;sel = 0; // 3+7
    #10 data_1 = 10;data_2 = 20; //10+20
    #10 data_1 = 4;data_2 = 7;sel = 1; // 7-4
    #10 data_1 = 10;data_2 = 20; //20-10
    #10 data_1 = 8'b00101010; data_2= 8'b11010110; sel=2; //and kq = 2 
    #10 data_1 = 8'b00110000; data_2= 8'b00000011; sel=3;// or kq = 0000110011
    #10 data_1 = 8'b00110000; data_2= 8'b11111100; sel=4;// not kq = 3
  end
endmodule