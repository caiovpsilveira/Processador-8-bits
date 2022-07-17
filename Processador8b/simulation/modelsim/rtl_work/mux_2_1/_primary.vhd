library verilog;
use verilog.vl_types.all;
entity mux_2_1 is
    generic(
        BITS            : integer := 8
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end mux_2_1;
