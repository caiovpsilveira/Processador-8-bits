/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Simulacao do processador
	Ao se trocar de programa entre o bubblesort e o maior elemento,
	trocar os comentarios do bloco initial e do fim do bloco alwyas para
	que se imprima corretamente os valores do vetor e da saida no console
*/

`include "define.v"

module simulacao_processador();

	reg clk, reset;
	
	initial begin
		reset = 1'b0;
		clk = 1'b1;
		forever begin
			#1;
			clk = !clk;
		end
	end
	
	//	module processador_8_bits
	//(
	//	input clk,
	//	input reset
	//);
	processador_8_bits proc(clk, reset);
	
	integer i, n, vet;
	
	initial begin
		//Para o teste do bubblesort
		$display("BS: Antes de ordenar");
		vet = proc.mem_dado.mem[4];
		n = proc.mem_dado.mem[3];
		for(i = 0; i<n; i = i+1)
			$display("%d", proc.mem_dado.mem[vet+i]);
			
		//Para o teste do maior
		/*$display("Maior: Vetor informado");
		vet = proc.mem_dado.mem[3];
		n = proc.mem_dado.mem[2];
		for(i = 0; i<n; i = i+1)
			$display("%d", proc.mem_dado.mem[vet+i]);*/
	end
	
	always @ (posedge clk) begin
		$display("_____________________________________");
		$display("PC e RJUMP");
		$display("PC = d%d, RJUMP = d%d", proc.pc.out, proc.rjump.out);
		
		$display("_____________________________________");
		$display("Memoria instrucao");
		$display("ADDR: d%d", proc.out_pc);
		case(proc.m_inst_out[7:4])
			`LW: begin $display("%d: LW R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`SW: begin $display("%d: SW R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`MOV: begin $display("%d: MOV R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`BEQ: begin $display("%d: BEQ R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`BNE: begin $display("%d: BNE R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`BEQZ: begin $display("%d: BEQZ R%d", proc.out_pc, proc.m_inst_out[1:0]); end
			`SLT: begin $display("%d: SLT R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`ADDI: begin $display("%d: ADDI (R0) #%d", proc.out_pc, proc.m_inst_out[3:0]); end
			`MOVI: begin $display("%d: MOVI (R0) #%d", proc.out_pc, proc.m_inst_out[3:0]); end
			`ADD: begin $display("%d: ADD R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`SUB: begin $display("%d: SUB R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`SLL: begin $display("%d: SLL R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`SRL: begin $display("%d: SRL R%d R%d", proc.out_pc, proc.m_inst_out[3:2], proc.m_inst_out[1:0]); end
			`SJMP: begin $display("%d: SJMP R%d", proc.out_pc, proc.m_inst_out[1:0]); end
			`J: begin $display("%d: J", proc.out_pc); end
			`HLT: begin $display("%d: HLT", proc.out_pc); end
		endcase
		
		$display("_____________________________________");
		$display("Controle");
		$display("Opcode: %d", proc.m_inst_out[7:4]);
		$display("branch %b, notEqual %b, jump %b, setJump %b, op1R0 %b, imed %b, shift %b, RZero %b, destR0 %b, weReg %b, memR %b, memW %b, memToReg %b, hlt %b, ctrl_ula %b", proc.branch, proc.notEqual, proc.jump, proc.setJump, proc.op1R0, proc.imed, proc.shift, proc.RZero, proc.destR0, proc.weReg, proc.memR, proc.memW, proc.memToReg, proc.hlt, proc.ctrl_ula);
		
		$display("_____________________________________");
		$display("Registradores");
		$display("R0: h%h, d%d",proc.regs.registradores[0], proc.regs.registradores[0]);
		$display("R1: h%h, d%d",proc.regs.registradores[1], proc.regs.registradores[1]);
		$display("R2: h%h, d%d",proc.regs.registradores[2], proc.regs.registradores[2]);
		$display("R3: h%h, d%d",proc.regs.registradores[3], proc.regs.registradores[3]);
		
		$display("_____________________________________");
		$display("ULA");
		$display("A %d, B %d", proc.out_mux_rzero, proc.out_mux_shift);
		$display("Saida %d, zero %b", proc.ula_out, proc.zero);
		
		$display("_____________________________________");
		$display("Memoria de dados");
		$display("Addr: %h, memR %b, memW, %b, DIN %d", proc.ula_out, proc.memR, proc.memW, proc.out_register_1);
		$display("DOUT: %d", proc.m_dado_out);
		
		//por comodidade, parar a simulacao quando encontrar uma instrucao de HLT.
		//HLT faz com que PC se mantenha no mesmo endereco e desabilita todas as escritas dos componentes do processador,
		//resultando sempre no fetch da mesma instrucao de HLT.
		
		//Para o teste do bubblesort:
		if(proc.m_inst_out[7:4] == `HLT) begin
			$display("Apos ordenar");
			vet = proc.mem_dado.mem[4];
			n = proc.mem_dado.mem[3];
			for(i = 0; i<n; i = i+1)
				$display("%d", proc.mem_dado.mem[vet+i]);
			$stop;
		end
		
		//Para o teste do maior:
		/*if(proc.m_inst_out[7:4] == `HLT) begin
			$display("O maior elemento encontrado foi:");
			$display("%d", proc.mem_dado.mem[1]);
			$stop;
		end*/
		
	end

endmodule