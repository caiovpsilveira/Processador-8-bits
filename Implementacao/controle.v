/*
	Caio Vinicius Pereira Silveira
	12/09/2022
	
	Descricao do circuito combinacional do controle do fluxo de dados do processador.
*/

`include "define.v"

module controle
(
	input [3:0] opcode,
	output reg branch,
	notEqual,
	jump,
	setJump,
	op1R0,
	imed,
	shift,
	RZero,
	destR0,
	weReg,
	memR,
	memW,
	memToReg,
	hlt,
	output reg [2:0] ctrl_ula
);

	always @ (opcode) begin
		case(opcode)
			`LW: begin //0	X	0	0	X	0	0	1	0	1	1	0	1	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b1;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'b1;
				memW = 1'b0;
				memToReg = 1'b1;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`SW: begin //0	X	0	0	0	0	0	1	X	0	0	1	X	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0; //estava incorreto: alterado de X para 0
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b1;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'b0;
				memW = 1'b1;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`MOV: begin //0	X	0	0	X	0	0	1	0	1	X	0	0	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b1;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`BEQ: begin //1	0	0	0	0	0	0	0	X	0	X	0	X	0	001	(SUB)
				branch = 1'b1;
				notEqual = 1'b0;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = `ULA_SUB;
			end
			`BNE: begin //1	1	0	0	0	0	0	0	X	0	X	0	X	0	001	(SUB)
				branch = 1'b1;
				notEqual = 1'b1;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = `ULA_SUB;
			end
			`BEQZ: begin //1	0	0	0	X	0	0	1	X	0	X	0	X	0	001	(SUB)
				branch = 1'b1;
				notEqual = 1'b0;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b1;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = `ULA_SUB;
			end
			`SLT: begin //0	X	0	0	0	0	0	0	1	1	X	0	0	0	100	(SLT)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'b1;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_SLT;
			end
			`ADDI: begin //0	X	0	0	1	1	0	0	1	1	X	0	0	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b1;
				imed = 1'b1;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'b1;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg =1'b0 ;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`MOVI: begin //0	X	0	0	X	1	0	1	1	1	X	0	0	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'b1;
				shift = 1'b0;
				RZero = 1'b1;
				destR0 = 1'b1;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`ADD: begin //0	X	0	0	0	0	0	0	0	1	X	0	0	0	000	(ADD)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_ADD;
			end
			`SUB: begin //0	X	0	0	0	0	0	0	0	1	X	0	0	0	001	(SUB)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'b0;
				shift = 1'b0;
				RZero = 1'b0;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_SUB;
			end
			`SLL: begin //0	X	0	0	0	X	1	0	0	1	X	0	0	0	010	(SLL)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'bx;
				shift = 1'b1;
				RZero = 1'b0;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_SLL;
			end
			`SRL: begin //0	X	0	0	0	X	1	0	0	1	X	0	0	0	011	(SRL)
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'b0;
				imed = 1'bx;
				shift = 1'b1;
				RZero = 1'b0;
				destR0 = 1'b0;
				weReg = 1'b1;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'b0;
				hlt = 1'b0;
				ctrl_ula = `ULA_SRL;
			end
			`SJMP: begin //0	X	0	1	X	X	X	X	X	0	X	0	X	0	XXX
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b1;
				op1R0 = 1'bx;
				imed = 1'bx;
				shift = 1'bx;
				RZero = 1'bx;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = 3'bxxx;
			end
			`J: begin //X	X	1	0	X	X	X	X	X	0	X	0	X	0	XXX
				branch = 1'bx;
				notEqual = 1'bx;
				jump = 1'b1;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'bx;
				shift = 1'bx;
				RZero = 1'bx;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b0;
				ctrl_ula = 3'bxxx;
			end
			`HLT: begin //0	X	0	0	X	X	X	X	X	0	X	0	X	1	XXX
				branch = 1'b0;
				notEqual = 1'bx;
				jump = 1'b0;
				setJump = 1'b0;
				op1R0 = 1'bx;
				imed = 1'bx;
				shift = 1'bx;
				RZero = 1'bx;
				destR0 = 1'bx;
				weReg = 1'b0;
				memR = 1'bx;
				memW = 1'b0;
				memToReg = 1'bx;
				hlt = 1'b1;
				ctrl_ula = 3'bxxx;
			end
		endcase
	end
	
endmodule