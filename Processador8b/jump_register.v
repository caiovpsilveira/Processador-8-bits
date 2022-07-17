/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao do registrador do endereco de branch.
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