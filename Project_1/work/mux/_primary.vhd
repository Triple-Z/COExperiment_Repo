library verilog;
use verilog.vl_types.all;
entity mux is
    generic(
        WIDTH           : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        ctrl_s          : in     vl_logic;
        dout            : out    vl_logic_vector
    );
end mux;
