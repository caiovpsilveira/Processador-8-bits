/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Top level processador de 8 bits.
	
	Sincronizacao do circuito:
	
	O PC e a memoria de dados atualizam na borda de subida (posedge).
	
	Os registradores tem a leitura assincrona (multiplexada), e a escrita ocorre na borda de descida (negedge).
	A memoria de instrucoes atualiza na borda de descida (negedge).
	
	A primeira borda de clk deve ser uma borda de descida, para que memoria de instrucao leia a instrucao em [0].
	
	Exemplo do fluxo de dados:
	
	Ciclo 1:
	negedge e semiciclo negativo:
	A memoria de instrucao lê a instrucao apontada por PC. A saida dos registradores
	eh multiplexada de acordo com a saida da memoria de instrucao. A ULA opera no conteudo lido pelos registradores e selecionado
	pelo controle. A memoria de dados recebe o conteudo lido dos registradores e o endereco calculado pela ULA.
	
	Posedge:
	O PC atualiza (incrementando ou recebendo rjump, de acordo com o controle selecionado pelo OPCODE lido), e a memoria de dados le ou
	escreve de acordo com o controle.
	
	Ciclo 2:
	no negedge, os registradores escrevem o conteudo lido na memoria de dados, se for uma operacao de LD. O restante se repete.
	
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
	
	wire [7:0] out_mux_pc, out_mux_memToReg, out_mux_imed, out_mux_shift, out_mux_rzero;
	
	wire sel_mux_pc;
	assign sel_mux_pc = (branch & (notEqual ^ zero)) | jump;
	
	//Separacao do opcode da saida da memoria de instrucao
	wire [3:0] opcode = m_inst_out[7:4];
	
	//Separacao da selecao do banco de registradores enderecados no campo da instrucao
	wire [1:0] read_reg_1_inst_sel = m_inst_out[3:2];
	wire [1:0] read_reg_2_inst_sel = m_inst_out[1:0];
	wire [1:0] write_reg_inst_sel = m_inst_out[3:2];
	
	//Separacao dos imediatos enderecados no campo da instrucao
	wire [3:0] imed_inst = m_inst_out[3:0];
	wire [1:0] shift_inst = m_inst_out[1:0];
	
	jump_register rjump
	(
		.clk(clk),
		.write_enable(setJump),
		.in(out_register_2),
		.out(out_rjump)
	);
	
	//2:1 muxes podem ser descritos com o comando assign out = sel ? in1 : in0;
	//Extensores podem ser feitos concatenando (operador {}).
	assign out_mux_pc = sel_mux_pc ? out_rjump : soma_pc;
	assign read_register_1 = op1R0 ? 2'b00 : read_reg_1_inst_sel;
	assign write_register = destR0 ? 2'b00 : write_reg_inst_sel;
	assign out_mux_imed = imed ? {4'h0, imed_inst} : out_register_2;
	assign out_mux_shift = shift ? {6'h00, shift_inst} : out_mux_imed;
	assign out_mux_rzero = RZero ? 8'h00 : out_register_1;
	assign out_mux_memToReg = memToReg ? m_dado_out : ula_out;
	
	//Instancias e conexoes
	
	pc pc
	(
		.clk(clk),
		.hlt(hlt),
		.reset(reset),
		.in(out_mux_pc),
		.out(out_pc)
	);
	
	memoria_instrucao#(8,8) mem_inst
	(
		.addr(out_pc),
		.clk(clk),
		.q(m_inst_out)
	);
	
	controle controle
	(
		.opcode(opcode),
		.branch(branch),
		.notEqual(notEqual),
		.jump(jump),
		.setJump(setJump),
		.op1R0(op1R0),
		.imed(imed),
		.shift(shift),
		.RZero(RZero),
		.destR0(destR0),
		.weReg(weReg),
		.memR(memR),
		.memW(memW),
		.memToReg(memToReg),
		.hlt(hlt),
		.ctrl_ula(ctrl_ula)
	);

	registradores_uso_geral regs
	(
		.clk(clk),
		.read_register_1(read_register_1),
		.read_register_2(read_reg_2_inst_sel),
		.write_register(write_register),
		.data(out_mux_memToReg),
		.write_enable(weReg),
		.out_register_1(out_register_1),
		.out_register_2(out_register_2)
	);
	
	ula ula
	(
		.inA(out_mux_rzero),
		.inB(out_mux_shift),
		.ctrl_ula(ctrl_ula),
		.zero(zero),
		.out(ula_out)
	);
	
	memoria_dados mem_dados
	(
		.clk(clk),
		.addr(ula_out),
		.memR(memR),
		.memW(memW),
		.din(out_register_1),
		.dout(m_dado_out)
	);
	
endmodule