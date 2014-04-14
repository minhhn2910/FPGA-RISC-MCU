library verilog;
use verilog.vl_types.all;
entity test_Processing_Unit is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8;
        op_size         : integer := 4;
        Sel1_size       : integer := 3;
        Sel2_size       : integer := 3
    );
end test_Processing_Unit;
