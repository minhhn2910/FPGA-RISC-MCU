module test_Memory_BlockRAM (SW,LEDR);
  parameter word_size = 10;
  parameter data_size = 8;
  parameter address_size = 8;
  input [17:0]SW;
  output [9:0]LEDR;
  
  wire clk, rst;
  wire [data_size-1: 0] Bus_1a; 
  wire [word_size-1: 0] mem_word;
  wire write;
  wire [address_size-1:0] address;
  
  assign address = SW[7:0];
  assign Bus_1a = SW[16:9];
  assign write = SW[8];
  assign clk = SW[17];
  assign LEDR[9:0] = mem_word;
Clock_Unit M1 (clk);
  
//Memory_BlockRam Me(.address(address),.clock(clk),.data({2'b0,Bus_1a}),.wren(write),.q(mem_word));
Memory_Unit M2_SRAM (.data_out(mem_word), .data_in({2'b0,Bus_1a}), .address(address), .clk(clk), .write(write) );
//programCode Me(.address(address),.clock(clk),.data({2'b0,Bus_1a}),.wren(write),.q(mem_word));

endmodule
