library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        iaddr           : in     vl_logic_vector(31 downto 0);
        branch          : in     vl_logic;
        jump            : in     vl_logic;
        zero            : in     vl_logic;
        imm16           : in     vl_logic_vector(15 downto 0);
        imm26           : in     vl_logic_vector(25 downto 0);
        niaddr          : out    vl_logic_vector(31 downto 0)
    );
end npc;
