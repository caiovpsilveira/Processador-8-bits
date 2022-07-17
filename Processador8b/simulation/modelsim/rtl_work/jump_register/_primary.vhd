library verilog;
use verilog.vl_types.all;
entity jump_register is
    port(
        clk             : in     vl_logic;
        write_enable    : in     vl_logic;
        \in\            : in     vl_logic_vector(7 downto 0);
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end jump_register;
