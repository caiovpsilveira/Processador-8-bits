library verilog;
use verilog.vl_types.all;
entity ula is
    port(
        inA             : in     vl_logic_vector(7 downto 0);
        inB             : in     vl_logic_vector(7 downto 0);
        ctrl_ula        : in     vl_logic_vector(2 downto 0);
        zero            : out    vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end ula;
