library verilog;
use verilog.vl_types.all;
entity D_flop is
    port(
        data_out        : out    vl_logic;
        data_in         : in     vl_logic;
        load            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end D_flop;
