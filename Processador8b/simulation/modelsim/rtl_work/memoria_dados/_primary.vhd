library verilog;
use verilog.vl_types.all;
entity memoria_dados is
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector(7 downto 0);
        memR            : in     vl_logic;
        memW            : in     vl_logic;
        DIN             : in     vl_logic_vector(7 downto 0);
        DOUT            : out    vl_logic_vector(7 downto 0)
    );
end memoria_dados;
