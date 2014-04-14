module generator(clock_in,clock_out);
	input clock_in;
	output reg clock_out=0;
	reg[25:0] count = 0;
	//clock_out = 0;
	always@(posedge clock_in)
	begin
		if(count >= 25000000)
			begin	
			count<=0;
			clock_out <= ~clock_out;
			end
		else
			count <= count+1'b1;
	end
endmodule 
//
//module lab4(CLOCK_50,LEDR);
//	output[1:0] LEDR;
//	input CLOCK_50;
//	generator g1(CLOCK_50,LEDR[0]);
//endmodule
