module test_Processing_Unit();
	parameter word_size = 10;
	parameter data_size = 8;
	parameter op_size = 4;
	parameter Sel1_size = 3;
	parameter Sel2_size = 3;
	reg [6:0] address_decoded;
	reg [7:0] constant_decoded;
	reg [word_size-1: 0]  	mem_word;
	reg 		Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC;
	reg [Sel1_size-1: 0] 	Sel_Bus_1a_Mux,Sel_Bus_1b_Mux;
	reg [Sel2_size-1: 0] 	Sel_Bus_2_Mux;
	reg 			Load_IR, Load_Add_R,  Load_Reg_Z;
	reg 			clk, rst;

	wire [word_size-1: 0] 	instruction;
	wire [6:0]	address;
	wire [data_size-1: 0] 	Bus_1a,Bus_1b;
	wire 		Zflag;
	wire [data_size-1: 0] R0_out, R1_out, R2_out, R3_out,PC_count;
	initial
	begin
		clk = 0;
	end
	always #5 clk = ~clk;
	
	//begin test signal
	
	wire [7:0] r0 = process1.R0.data_out[7:0];
	wire [7:0] r1 = process1.R1.data_out[7:0];	
	wire [7:0] r2 = process1.R2.data_out[7:0];
	wire [7:0] r3 = process1.R3.data_out[7:0];
	wire [9:0] bus2 = process1.Bus_2[9:0];
	//end test signal
		
  Processing_Unit process1(instruction, Zflag, address, address_decoded, constant_decoded, Bus_1a,Bus_1b, mem_word, Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC, Sel_Bus_1a_Mux,Sel_Bus_1b_Mux, Load_IR, Load_Add_R, Load_Reg_Z,  Sel_Bus_2_Mux, clk, rst,R0_out, R1_out, R2_out, R3_out,PC_count);
	
	
  initial 
  begin
  	address_decoded[6:0]=0;
	constant_decoded[7:0] = 0;
	mem_word[word_size-1: 0] =0;
	Load_R0 = 0; Load_R1 = 0; Load_R2 = 0; Load_R3 = 0; Load_PC = 0; Inc_PC = 0;
	Sel_Bus_1a_Mux [2:0] = 0;
	Sel_Bus_1b_Mux [2:0] = 0;
	Sel_Bus_2_Mux[2: 0] = 0 ;
	Load_IR = 0; Load_Add_R = 0;  Load_Reg_Z = 0;
	//r0 = r1 + r2   =>> r2 = r1 + r2
	#10 
		begin
			mem_word[9:0] = 10'b0000100110;
			process1.R0.data_out=0;process1.R1.data_out=1;process1.R2.data_out=2;process1.R3.data_out=3;
			Sel_Bus_1a_Mux[2:0]=4; //sel_PCa = 1
			Sel_Bus_2_Mux[2:0]=1;
			Load_Add_R=1;
		end
	 // S_fet2
	#10
		begin 
			Sel_Bus_2_Mux[2:0] =2 ; //Sel_Mem = 1;
			Load_IR = 1; 
			Inc_PC = 1; 
		end 
	//S_dec
	#10
		begin
		Sel_Bus_1a_Mux[2:0]=1; //Sel_R1a = 1;
		Sel_Bus_1b_Mux[2:0]=2;		//Sel_R2b = 1;		
		end
	//ex1
	#10
		begin
			Load_Reg_Z = 1;
			Sel_Bus_2_Mux[2:0]=0;		//Sel_ALU = 1; 
			Load_R0 = 1;
		end
	//r0 = r3-r1   =>> r0 = 3-1 = 2
  end
endmodule