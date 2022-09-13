/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao da memoria de instrucao (ROM Sincrona).
	
	Quartus II single port ROM template
*/

module memoria_instrucao
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin : INIT
		$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_inst_bubblesort.txt", rom);
		//$readmemb("E:/Cefet/3periodo/LabAOC/Processador/Processador8b/m_inst_maior.txt", rom);
	end

	always @ (negedge clk) //negedge porque o PC atualiza no posedge
	begin
		q <= rom[addr];
	end

endmodule
