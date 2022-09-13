/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao do banco de 4 registradores de 8 bits
	Leitura assincrona (multiplexadores), escrita sincrona na borda de descida do clock.
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
	
	//muxes de selecao da leitura (assincronos)
	assign out_register_1 = registradores[read_register_1];
	assign out_register_2 = registradores[read_register_2];
	
	always @ (negedge clk) begin
		if(write_enable) begin
			registradores[write_register] = data;
		end
	end
	
endmodule