module Register_Unit (data_out, data_in, load, clk, rst);
  parameter 		word_size = 10;
  parameter 		data_size = 8;
  
  output reg[data_size-1: 0] 	data_out;
  input  [data_size-1: 0] 	data_in;
  input 			load;
  input 			clk, rst;
  
  always @ (posedge clk or negedge rst)
    if (rst == 0) data_out <= 0; else if (load) data_out <= data_in;
endmodule
