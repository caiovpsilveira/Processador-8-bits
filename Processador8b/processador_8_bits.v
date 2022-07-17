/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Modulo principal do processador de 8 bits.
	
	Para sincronizar o circuito, o IF - ID - EXE e leitura MEM_DADO sao executados durante o semiciclo positivo do clock.
	A etapa de escrita na MEM_DADO e no banco de registradores ocorre na borda de descida do clock
*/

module processador_8_bits
(
	input clk,
	input reset
);
	
	//wires
	wire branch, notEqual, jump, setJump, RZero, imed, shift, op1R0, destR0, memR, memW, memToReg, weReg, hlt;
	wire [2:0] ctrl_ula;

	wire [7:0] out_rjump;
	
	wire [7:0] m_inst_out;
	
	wire [7:0] m_dado_out;
	
	wire [1:0] read_register_1, write_register;
	wire [7:0] out_register_1, out_register_2;
	
	wire [7:0] out_pc;
	wire [7:0] soma_pc;
	assign soma_pc = out_pc + 8'h01;
	
	wire zero;
	wire [7:0] ula_out;
	
	wire sel_mux_pc;
	assign sel_mux_pc = (branch & (notEqual ^ zero)) | jump;
	
	wire [7:0] out_mux_pc, out_mux_memToReg, out_mux_imed, out_mux_shift, out_mux_rzero;
	
	//	module jump_register
	//(
	//	input clk,
	//	input write_enable,
	//	input [7:0] in,
	//	output reg [7:0] out
	//);
	jump_register rjump(clk, setJump, out_register_2, out_rjump);
	
	//	module mux_2_1
	//#(parameter BITS = 8)
	//(
	//	input [BITS-1:0] in0,
	//	input [BITS-1:0] in1,
	//	input sel,
	//	output [BITS-1:0] out
	//);
	mux_2_1 #(8) mux_pc(soma_pc, out_rjump, sel_mux_pc, out_mux_pc);
	mux_2_1 #(2) mux_op1r0(m_inst_out[3:2], 2'b00, op1R0, read_register_1);
	mux_2_1 #(2) mux_destR0(m_inst_out[3:2], 2'b00, destR0, write_register);
	mux_2_1 #(8) mux_imed(out_register_2, {4'b0000,m_inst_out[3:0]}, imed, out_mux_imed);
	mux_2_1 #(8) mux_shift(out_mux_imed, {6'b00_0000,m_inst_out[1:0]}, shift, out_mux_shift);
	mux_2_1 #(8) mux_rzero(out_register_1, 8'h00, RZero, out_mux_rzero);
	mux_2_1 #(8) mux_memToReg(ula_out, m_dado_out, memToReg, out_mux_memToReg);
	
	//	module pc
	//(
	//	input clk,
	//	input hlt,
	//	input reset,
	//	input [7:0] in,
	//	output reg [7:0] out
	//);
	pc pc(clk, hlt, reset, out_mux_pc, out_pc);
	
	//	module memoria_instrucao //ROM
	//	(
	//		input clk,
	//		input [7:0] addr,
	//		output reg [7:0] out
	//	);
	memoria_instrucao mem_inst(clk, out_pc, m_inst_out);
	
	//	module controle
	//(
	//	input [3:0] opcode,
	//	output reg branch,
	//	notEqual,
	//	jump,
	//	setJump,
	//	op1R0,
	//	imed,
	//	shift,
	//	RZero,
	//	destR0,
	//	weReg,
	//	memR,
	//	memW,
	//	memToReg,
	//	hlt,
	//	output reg [2:0] ctrl_ula
	//);
	controle controle(m_inst_out[7:4], branch, notEqual, jump, setJump, op1R0, imed, shift, RZero, destR0, weReg, memR, memW, memToReg, hlt, ctrl_ula);
	
	//	module registradores_uso_geral
	//(
	//	input clk,
	//	input [1:0] read_register_1,
	//	input [1:0] read_register_2,
	//	input [1:0] write_register,
	//	input [7:0] data,
	//	input write_enable,
	//	output reg [7:0] out_register_1,
	//	output reg [7:0] out_register_2
	//);
	registradores_uso_geral regs(clk, read_register_1, m_inst_out[1:0], write_register, out_mux_memToReg, weReg, out_register_1, out_register_2);

	//module ula
	//(
	//	input [7:0] inA,
	//	input [7:0] inB,
	//	input [2:0] ctrl_ula,
	//	output reg zero,
	//	output reg [7:0] out
	//);	
	ula ula(out_mux_rzero, out_mux_shift, ctrl_ula, zero, ula_out);
	
	//	module memoria_dados //RAM
	//(
	//	input clk,
	//	input [7:0] addr,
	//	input memR,
	//	input memW,
	//	input [7:0] DIN,
	//	output reg [7:0] DOUT
	//);
	memoria_dados mem_dado(clk, ula_out, memR, memW, out_register_1, m_dado_out);
	
endmodule