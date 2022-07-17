library verilog;
use verilog.vl_types.all;
entity registradores_uso_geral is
    port(
        clk             : in     vl_logic;
        read_register_1 : in     vl_logic_vector(1 downto 0);
        read_register_2 : in     vl_logic_vector(1 downto 0);
        write_register  : in     vl_logic_vector(1 downto 0);
        data            : in     vl_logic_vector(7 downto 0);
        write_enable    : in     vl_logic;
        out_register_1  : out    vl_logic_vector(7 downto 0);
        out_register_2  : out    vl_logic_vector(7 downto 0)
    );
end registradores_uso_geral;
