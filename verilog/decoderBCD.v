
//decoder BCD
module decoderBCD (led,s);
	input [3:0]s;
	output reg[6:0]led;
//	reg [6:0]led;
	
	always @(s)
	case (s)
		4'b0000: led = 7'b1000000; //0
		4'b0001: led = 7'b1111001; //1
		4'b0010: led = 7'b0100100; //2
		4'b0011: led = 7'b0110000; //3
		4'b0100: led = 7'b0011001; //4
		4'b0101: led = 7'b0010010; //5
		4'b0110: led = 7'b0000010; //6
		4'b0111: led = 7'b1111000; //7
		4'b1000: led = 7'b0000000; //8
		4'b1001: led = 7'b0010000; //9
		4'b1010: led = 7'b0001000;//a
		4'b1011: led = 7'b0000011;//b
		4'b1100: led = 7'b1000110;//c
		4'b1101: led = 7'b0100001;//d
		4'b1110: led = 7'b0000110;//e
		4'b1111: led = 7'b0001110;//f
		
		default : led = 7'b0111111; //0
	endcase
//s	assign ledout = led;
endmodule
