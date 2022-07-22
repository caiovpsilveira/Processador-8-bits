/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao da ULA.
	Operacoes: ADD, SUB, SLL, SRL, SLT
*/

`include "define.v"

module ula
(
	input [7:0] inA,
	input [7:0] inB,
	input [2:0] ctrl_ula,
	output zero,
	output reg [7:0] out
);

	assign zero = out == 8'h00;

	always @ (*) begin
		case(ctrl_ula)
			`ULA_ADD: begin
				out = inA + inB;
			end
			`ULA_SUB: begin
				out = inA - inB;
			end
			`ULA_SLL: begin
				out = inA << inB;
			end
			`ULA_SRL: begin
				out = inA >> inB;
			end
			`ULA_SLT: begin
				if(inA < inB)
					out = 8'h01;
				else
					out = 8'h00;
			end
			default: begin //Nao deveria entrar nunca em uma durante uma escrita (erro do controle)
				out = 8'h00;
			end
		endcase
	end
	
endmodule