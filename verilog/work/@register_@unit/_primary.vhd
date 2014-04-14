library verilog;
use verilog.vl_types.all;
entity Register_Unit is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8
    );
    port(
        data_out        : out    vl_logic_vector;
        data_in         : in     vl_logic_vector;
        load            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end Register_Unit;
