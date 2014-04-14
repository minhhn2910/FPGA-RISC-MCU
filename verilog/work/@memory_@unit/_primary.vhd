library verilog;
use verilog.vl_types.all;
entity Memory_Unit is
    generic(
        word_size       : integer := 10;
        memory_size     : integer := 256;
        address_size    : integer := 8
    );
    port(
        data_out        : out    vl_logic_vector;
        data_in         : in     vl_logic_vector;
        address         : in     vl_logic_vector;
        clk             : in     vl_logic;
        write           : in     vl_logic
    );
end Memory_Unit;
