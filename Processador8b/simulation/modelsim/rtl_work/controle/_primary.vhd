library verilog;
use verilog.vl_types.all;
entity controle is
    port(
        opcode          : in     vl_logic_vector(3 downto 0);
        branch          : out    vl_logic;
        notEqual        : out    vl_logic;
        jump            : out    vl_logic;
        setJump         : out    vl_logic;
        op1R0           : out    vl_logic;
        imed            : out    vl_logic;
        shift           : out    vl_logic;
        RZero           : out    vl_logic;
        destR0          : out    vl_logic;
        weReg           : out    vl_logic;
        memR            : out    vl_logic;
        memW            : out    vl_logic;
        memToReg        : out    vl_logic;
        hlt             : out    vl_logic;
        ctrl_ula        : out    vl_logic_vector(2 downto 0)
    );
end controle;
