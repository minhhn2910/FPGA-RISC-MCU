module Program_Counter (count, data_in, Load_PC, Inc_PC, clk, rst);
  parameter data_size = 8;
  output [data_size-1: 0] 	count;
  input 	[data_size-1: 0] 	data_in;
  input 			Load_PC, Inc_PC;
  input 			clk, rst;
  reg 			[data_size-1: 0]count_temp; 
  assign count=count_temp;
  always @ (posedge clk or negedge rst)
  	if (rst == 0) count_temp <= 0; 
    	else if (Load_PC) count_temp <= data_in; 
    	else if  (Inc_PC) count_temp <= count_temp +1;
endmodule    
