
 module Address_Register (data_out, data_in, load, clk, rst);
  parameter word_size = 10;
  parameter address_size = 8;
  output reg [address_size-1: 0] 	data_out;
  input 	[address_size-1: 0] 	data_in;
  input 			load, clk, rst;
  always @ (posedge clk or negedge rst)
    if (rst == 0) data_out <= 0; else if (load) data_out <= data_in;
endmodule