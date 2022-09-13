/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao da memoria de dados (RAM sincrona).
	
	Sincrona na borda de subida do clock.
*/

module memoria_dados
(
	input clk,
	input [7:0] addr,
	input memR,
	input memW,
	input [7:0] din,
	output [7:0] dout
);

	reg [7:0] ram [255:0];

	reg [7:0] addr_reg;

	initial 
	begin : INIT
		$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_dado_teste_bs_10pos.txt", ram);
		//$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_dado_teste_bs_20pos.txt", ram);
		//$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_dado_teste_maior_10pos.txt", ram);
		//$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_dado_teste_maior_20pos.txt", ram);
	end 

	always @ (posedge clk) //update no posedge, para que a leitura ocorra no negedge e o banco de registradores seja escrito no posedge, para ST
	begin
		if (memW)
			ram[addr] <= din;

		addr_reg <= addr;
	end

	assign dout = memR ? ram[addr_reg] : 8'h00; //se memR = 0: colocar tudo 0

endmodule