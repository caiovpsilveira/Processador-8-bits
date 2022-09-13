/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao do registrador program counter (PC).
	Escrita ocorre na borda de subida do clk, reset assincrono
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
	
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			out = 8'h00;
		end
		else if(!hlt) begin
			out = in;
		end
	end

endmodule