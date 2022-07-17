/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao da memoria de instrucao (ROM assincrona).
*/

module memoria_instrucao
(
	input clk,
	input [7:0] addr,
	output [7:0] out
);

	reg [7:0] mem [255:0]; //256 posicoes de 8 bits
	
	assign out = mem[addr];
	
	initial begin
		//deve possuir o PATH completo para o ModelSim
		$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_inst_bubblesort.txt", mem);
	end
	
endmodule