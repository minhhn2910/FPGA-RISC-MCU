library verilog;
use verilog.vl_types.all;
entity test_Control_Unit is
    generic(
        word_size       : integer := 10;
        op_size         : integer := 4;
        state_size      : integer := 4;
        address_size    : integer := 8;
        data_size       : integer := 8;
        src0_size       : integer := 2;
        src1_size       : integer := 2;
        dest_size       : integer := 2;
        Sel1_size       : integer := 3;
        Sel2_size       : integer := 3
    );
end test_Control_Unit;
