/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao da memoria de dados.
	Leitura assincrona, controlada por memR
	Escrita sincrona na borda de descida do clock.
*/

module memoria_dados //RAM inicializada por arquivo
(
	input clk,
	input [7:0] addr,
	input memR,
	input memW,
	input [7:0] DIN,
	output [7:0] DOUT
);

	reg [7:0] mem [255:0]; //256 posicoes de 8 bits
	
	genvar i;
	generate
		for(i=0; i<8; i=i+1) begin: dout
			assign DOUT[i] = memR & mem[addr][i];
		end
	endgenerate
	
	initial begin
		//deve possuir o PATH completo para o ModelSim
		$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_dado_teste_bs_20pos.txt", mem);
	end

	always @ (negedge clk) begin
		if(memW)
			mem[addr] = DIN;
	end
	
endmodule