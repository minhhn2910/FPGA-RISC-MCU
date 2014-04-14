library verilog;
use verilog.vl_types.all;
entity generator is
    port(
        clock_in        : in     vl_logic;
        clock_out       : out    vl_logic
    );
end generator;
