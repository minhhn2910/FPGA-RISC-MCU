library verilog;
use verilog.vl_types.all;
entity test_ALU is
    generic(
        word_size       : integer := 10;
        op_size         : integer := 4;
        data_size       : integer := 8
    );
end test_ALU;
