library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        niaddr          : in     vl_logic_vector(31 downto 0);
        iaddr           : out    vl_logic_vector(31 downto 0)
    );
end pc;
