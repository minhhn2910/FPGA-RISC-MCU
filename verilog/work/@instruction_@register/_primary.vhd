library verilog;
use verilog.vl_types.all;
entity Instruction_Register is
    generic(
        word_size       : integer := 10;
        address_size    : integer := 8
    );
    port(
        data_out        : out    vl_logic_vector;
        data_in         : in     vl_logic_vector;
        load            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end Instruction_Register;
