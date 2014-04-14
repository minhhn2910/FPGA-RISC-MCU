
module Instruction_Register (data_out, data_in, load, clk, rst);
  parameter word_size = 10;
  parameter address_size = 8;
  output [word_size-1: 0] 	data_out;
 // output [address_size-1:0] address;
  input 	[word_size-1: 0] 	data_in;
  input 			load;
  input 			clk, rst;
  reg 	[word_size-1: 0]	data_out;
 // assign address=data_out[address_size-1:0];
  always @ (posedge clk or negedge rst)
    if (rst == 0) data_out <= 0; else if (load) data_out <= data_in; 
endmodule