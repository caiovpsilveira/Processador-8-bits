/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao dos multiplexadores 2:1, de N bits.
*/

module mux_2_1
#(parameter BITS = 8)
(
	input [BITS-1:0] in0,
	input [BITS-1:0] in1,
	input sel,
	output [BITS-1:0] out
);

	genvar i;
	generate
		for(i=0; i<BITS; i=i+1) begin: mux
			assign out[i] = (~sel & in0[i]) | (sel & in1[i]);
		end
	endgenerate
	
endmodule