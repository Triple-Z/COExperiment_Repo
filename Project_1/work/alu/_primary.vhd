library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        ALUop           : in     vl_logic_vector(3 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic
    );
end alu;
