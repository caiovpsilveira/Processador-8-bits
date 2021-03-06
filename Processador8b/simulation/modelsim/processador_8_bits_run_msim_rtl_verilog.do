transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/registradores_uso_geral.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/muxes.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/define.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/jump_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/processador_8_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/controle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/ula.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/memoria_instrucao.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/memoria_dados.v}

vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/controle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/define.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/jump_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/memoria_dados.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/memoria_instrucao.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/simulacao_processador.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/registradores_uso_geral.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/processador_8_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/muxes.v}
vlog -vlog01compat -work work +incdir+C:/Users/Estudo/Downloads/Processador8b {C:/Users/Estudo/Downloads/Processador8b/ula.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  simulacao_processador

add wave *
view structure
view signals
run -all
