/*
	Caio Vinicius Pereira Silveira
	Revisado 16/07/2022
	
	Macros para substituicao global no projeto
*/

//OPCODES
`define LW 		4'h0
`define SW 		4'h1
`define MOV 	4'h2
`define BEQ 	4'h3
`define BNE 	4'h4
`define BEQZ 	4'h5
`define SLT 	4'h6
`define ADDI 	4'h7
`define MOVI 	4'h8
`define ADD 	4'h9
`define SUB 	4'ha
`define SLL 	4'hb
`define SRL 	4'hc
`define SJMP 	4'hd
`define J 		4'he
`define HLT 	4'hf

//CONTROLE ULA
`define ULA_ADD 3'b000
`define ULA_SUB 3'b001
`define ULA_SLL 3'b010
`define ULA_SRL 3'b011
`define ULA_SLT 3'b100