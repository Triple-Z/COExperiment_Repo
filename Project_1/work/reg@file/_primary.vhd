library verilog;
use verilog.vl_types.all;
entity regFile is
    port(
        busW            : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        wE              : in     vl_logic;
        rW              : in     vl_logic_vector(4 downto 0);
        rA              : in     vl_logic_vector(4 downto 0);
        rB              : in     vl_logic_vector(4 downto 0);
        busA            : out    vl_logic_vector(31 downto 0);
        busB            : out    vl_logic_vector(31 downto 0)
    );
end regFile;
