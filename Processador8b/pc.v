/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao do program counter.
*/

module pc
(
	input clk,
	input hlt,
	input reset,
	input [7:0] in,
	output reg [7:0] out
);

	initial begin
		out = 8'h00;
	end
	
	//reset assincrono: poderia conflitar com a memoria de instrucao, no mundo real, se o clock variar
	//antes da memoria e dos demais componentes processarem completamente a instrucao no endereco[0].
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			out = 8'h00;
		end
		else if(!hlt) begin
			out = in;
		end
	end

endmodule