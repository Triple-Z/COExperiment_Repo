library verilog;
use verilog.vl_types.all;
entity ctrl is
    generic(
        R               : integer := 0;
        LW              : integer := 35;
        SW              : integer := 43;
        BEQ             : integer := 4;
        J               : integer := 2;
        ADD             : integer := 32;
        SUB             : integer := 34;
        \AND\           : integer := 36;
        \OR\            : integer := 37;
        SLT             : integer := 42
    );
    port(
        ins             : in     vl_logic_vector(31 downto 0);
        branch          : out    vl_logic;
        jump            : out    vl_logic;
        regDst          : out    vl_logic;
        aluSrc          : out    vl_logic;
        aluCtr          : out    vl_logic_vector(3 downto 0);
        regWr           : out    vl_logic;
        memWr           : out    vl_logic;
        extOp           : out    vl_logic;
        memtoReg        : out    vl_logic
    );
end ctrl;
