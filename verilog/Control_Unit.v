module Control_Unit (Load_R0, Load_R1,  Load_R2, Load_R3,  Load_PC, 
Inc_PC, Sel_Bus_1a_Mux,Sel_Bus_1b_Mux, Sel_Bus_2_Mux, Load_IR, Load_Add_R, 
 Load_Reg_Z,  write, address_decoded, constant_decoded, instruction, zero, clk, rst,state,next_state,Sel_PORT);


  parameter word_size = 10, op_size = 4, state_size = 4;
  parameter address_size = 8 , data_size=8;
  parameter src0_size = 2, src1_size = 2,dest_size = 2, Sel1_size = 3, Sel2_size = 3;
  // State Codes
  parameter S_idle 	= 0	, S_fet1   = 1 , S_fet2  = 2 , S_fet3    = 3;
  parameter S_rd1   = 4	, S_rd2    = 5 , S_wr1 	 = 6 , S_wr2     = 7;  
  parameter S_jump1 = 8 , S_jump2  = 9 , S_wait  = 10, S_unused  = 11;
  parameter S_nop   = 12, S_dec    = 13, S_ex1   = 14, S_halt    = 15;
  // Opcodes
  parameter ADD = 0, SUB = 1, AND = 2, OR = 3, NOT = 4;
  parameter SIZ = 5'b01010;
  parameter NOP = 5'b01011;
  parameter OP_5 = 4'b0101;
  parameter JUMP = 4'b011x, STORE = 4'b100x,LOAD = 4'b101x, SAVE = 4'b11xx;
  // Source and Destination Register Codes  
   parameter R0 = 0, R1 = 1, R2 = 2, R3 = 3; 
 // See textbook for output, input, and reg declarations  
output reg Sel_PORT ;
output reg Load_R0, Load_R1,  Load_R2, Load_R3,  Load_PC,Inc_PC; // dieu khien cac thanh ghi R0,R1,R2,R3,PC
output  [Sel1_size-1:0]Sel_Bus_1a_Mux,Sel_Bus_1b_Mux;//dieu khien multiplexer 5 kenh 1a va 1b, de chon ra input cho bus 1a va bus 1b
output  [Sel2_size-1:0]Sel_Bus_2_Mux;// dieu khien multiplexer 2 de chon ra du lieu cho bus 2
output reg Load_IR, Load_Add_R, Load_Reg_Z,  write; // load gia tri bus 2 vao instruction register, Address Register, Load zero vao Reg_Z, write 
output  [address_size-1:0] address_decoded;
output  [data_size-1:0] constant_decoded;
input  [word_size-1:0]instruction;
input  zero, clk, rst;
output reg[state_size-1:0]state,next_state;
//reg Load_R0,Load_R1,Load_R2,Load_R3,Load_PC,Inc_PC;
//reg Load_IR,Load_Add_R;
reg Sel_ALU,Sel_Bus_1a,Sel_Mem,Sel_Address,Sel_Constant;
reg Sel_R0a,Sel_R1a,Sel_R2a,Sel_R3a,Sel_PCa,Sel_Ira;
reg Sel_R0b,Sel_R1b,Sel_R2b,Sel_R3b,Sel_PCb,Sel_Irb;
//reg Load_Reg_Z,write;
reg err_flag;

 // Extract instruction fields 
  wire [op_size-1: 0] opcode = instruction [word_size-1: word_size - op_size];
  wire [src1_size-1: 0] src1 = instruction [src1_size + dest_size -1: dest_size];
  wire [src0_size-1: 0] src0 = instruction [src0_size+ src1_size + dest_size -1: dest_size + src1_size];
  wire [dest_size-1: 0] dest = instruction [dest_size -1: 0];
  
  assign	 address_decoded = {1'b0,instruction [data_size-2:0]};   // WARNING
  assign	 constant_decoded = instruction [data_size-1:0];
 // Mux selectors
	assign  Sel_Bus_1a_Mux[Sel1_size-1: 0] = 	Sel_R0a ? 0:
				 		Sel_R1a ? 1:
				 		Sel_R2a ? 2:
				 		Sel_R3a ? 3:
				 		Sel_PCa ? 4: 5'bx; 
						
	assign  Sel_Bus_1b_Mux[Sel1_size-1: 0] = 	Sel_R0b ? 0:
				 		Sel_R1b ? 1:
				 		Sel_R2b ? 2:
				 		Sel_R3b ? 3:
				 		Sel_PCb ? 4: 5'bx; 
						
	assign  Sel_Bus_2_Mux[Sel2_size-1: 0] = 	Sel_ALU ? 0:
				 	   	Sel_Bus_1a ? 1:
				 		Sel_Mem ? 2:
						Sel_Address ? 3:
						Sel_Constant ? 4:5'bx;
		 		
 
  always @ (posedge clk or negedge rst) begin: State_transitions
    if (rst == 0) state <= S_idle; else state <= next_state; end
 always @ (state or opcode or src0 or src1 or dest or zero)
   begin: Output_and_next_state 
    // set default values for control signals
    Sel_R0a = 0; Sel_R1a = 0; Sel_R2a = 0; Sel_R3a = 0; Sel_PCa = 0;
	Sel_R0b = 0; Sel_R1b = 0; Sel_R2b = 0; Sel_R3b = 0; Sel_PCb = 0;
	Sel_ALU = 0; Sel_Bus_1a = 0; Sel_Mem = 0; Sel_Address=0; Sel_Constant=0; 

    Load_R0 = 0; Load_R1 = 0; Load_R2 = 0; Load_R3 = 0; Load_PC = 0;
    Load_IR = 0;	Load_Add_R = 0;	Load_Reg_Z = 0;
    Inc_PC = 0; 
	write = 0; 
    err_flag = 0;	// Used for de-bug in simulation		

	Sel_PORT = 0;
    next_state = state;
	
	//if(zero)
//		Load_Reg_Z = 1;
	
   casex  (state)	
	S_idle: next_state = S_fet1;      
	S_fet1: begin next_state = S_fet2; Sel_PCa = 1; Sel_Bus_1a = 1;  Load_Add_R = 1; 
			end // S_fet1
    S_fet2: begin next_state = S_fet3; Sel_Mem = 1; Load_IR = 1; 
			end // S_fet2
	S_fet3: begin next_state = S_dec; Sel_Mem =1 ; Load_IR = 1; Inc_PC = 1;  end
    S_dec:  casex  (opcode) 
   //   	NOP: next_state = S_fet1;
		ADD, SUB, AND,OR: begin next_state = S_ex1; Sel_Bus_1a = 1;  
		                        
								case (src0) R0: Sel_R0a = 1; R1: 	Sel_R1a = 1; R2: Sel_R2a = 1; 
												R3: Sel_R3a = 1; default : err_flag = 1; endcase   
								case (src1) R0: Sel_R0b = 1; R1: 	Sel_R1b = 1; R2: Sel_R2b = 1; 
												R3: Sel_R3b = 1; default : err_flag = 1; endcase   
							  end // ADD, SUB, AND
		NOT: begin next_state = S_fet1; Load_Reg_Z = 1; Sel_Bus_1a = 1; Sel_ALU = 1; 
				case (src0) R0: Sel_R0a = 1; R1: Sel_R1a = 1; R2: Sel_R2a = 1;
									R3: Sel_R3a = 1; default : err_flag = 1; endcase   
				case (dest) R0: Load_R0 = 1; R1: Load_R1 = 1; R2: Load_R2 = 1;
									R3: Load_R3 = 1; default: err_flag = 1; endcase   
				end // NOT
  		LOAD: begin 
				next_state = S_rd1;
				Sel_Address = 1;
				Load_Add_R = 1; 
				//en_PORT = 1;
			end // LOAD
		STORE: begin 
				if (address_decoded!=80)
				begin
				next_state = S_wr1; 
				Sel_Address = 1;
			    Load_Add_R = 1;
				end
				else
					begin
						next_state = S_fet1;
						Sel_PORT = 1;
					end
			end  // STORE
		JUMP: begin 
				next_state = S_jump1;
				Sel_Address = 1;  
				Load_PC = 1;
			end  // JUMP
		OP_5: //opcode = 5 bit: SIZ and NOP 
			if (instruction[5]==0) //SIZ
				begin
					if (zero == 1)  begin Inc_PC=1; next_state = S_jump1;  end 
					else begin next_state = S_fet1; end 
				end
			else //NOP & HALT
				if (instruction[4]==0)	//NOP
					begin next_state = S_fet1; end
				else	//HALT
					begin next_state = S_halt; end
		SAVE:
			begin
				next_state = S_fet1; 
				Sel_Constant = 1;
				Load_R0 = 1;				
			end
		default : next_state = S_halt;
	    endcase  // (opcode)
 	S_ex1: begin next_state = S_fet1; Load_Reg_Z = 1; Sel_ALU = 1; 
		   case  (dest)
  	    	R0: begin Load_R0 = 1; end
			R1: begin Load_R1 = 1; end
			R2: begin Load_R2 = 1; end
			R3: begin Load_R3 = 1; end
		    default : err_flag = 1; 
		   endcase  
		    case (src0) R0: Sel_R0a = 1; R1: 	Sel_R1a = 1; R2: Sel_R2a = 1; 
						R3: Sel_R3a = 1; default : err_flag = 1; endcase   
			case (src1) R0: Sel_R0b = 1; R1: 	Sel_R1b = 1; R2: Sel_R2b = 1; 
						R3: Sel_R3b = 1; default : err_flag = 1; endcase   
												
	 end // S_ex1 
	S_rd1: begin 
				next_state = S_rd2;
				Sel_Mem = 1;
                Load_Add_R = 1;
			//	en_PORT = 1;				
			end // S_rd1
	S_rd2:
		begin
			 next_state = S_wait;
			 Sel_Mem = 1;
			 Load_R0 = 1;
			// en_PORT = 1;
		end
		
	S_wr1: 
			begin 
			next_state = S_fet1;
			write = 1;
		    Sel_R0a = 1;
			end //
	S_wr2: 
		begin
			next_state = S_fet1;
			//Sel_R0a = 1;
			
		end			
   	S_wait: 
		 begin 
			next_state = S_fet1;
			//en_PORT = 1;
		 end
	S_jump1:
		begin
			next_state = S_jump2;
			Sel_PCa = 1;
			Sel_Bus_1a = 1;
			Load_Add_R = 1;
		end
   	 S_jump2:
		 begin
			 next_state = S_fet1;
			 Sel_Mem = 1;
			 Load_IR = 1;
		 end
   	S_halt: next_state = S_halt;
	S_nop: next_state = S_fet1;
	default: next_state = S_idle; endcase  end //state case and always block
endmodule
