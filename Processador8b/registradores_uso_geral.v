/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Descricao do banco de 4 registradores de 8 bits
	Leitura assincrona, escrita sincrona na borda de descida do clock.
*/

module registradores_uso_geral
(
	input clk,
	input [1:0] read_register_1,
	input [1:0] read_register_2,
	input [1:0] write_register,
	input [7:0] data,
	input write_enable,
	output [7:0] out_register_1,
	output [7:0] out_register_2
);

	reg [7:0] registradores [3:0]; //4 registradores de 8 bits
	
	assign out_register_1 = registradores[read_register_1];
	assign out_register_2 = registradores[read_register_2];
	
	//Se a escrita for "assincrona" (ocorrer sempre que write_register ou write_enable ou data se alterarem)
	//ocorrera um "loop" infinito com a memoria de dados e a ULA, porque alterar o registrador pode alterar a saida da ULA (e o endereco de mem dado)
	//o que faz com que altere o dado de entrada dos registradores novamente ...
	always @ (negedge clk) begin
		if(write_enable) begin
			registradores[write_register] = data;
		end
	end
	
endmodule