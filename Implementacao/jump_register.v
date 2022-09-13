/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao do registrador do endereco de branch.
	Escrita ocorre na borda de descida do clk
*/

module jump_register
(
	input clk,
	input write_enable,
	input [7:0] in,
	output reg [7:0] out
);

	//escrita sincrona na borda de descida
	always @ (negedge clk) begin
		if(write_enable)
			out = in;
	end
	
endmodule