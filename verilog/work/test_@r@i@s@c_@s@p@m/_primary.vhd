library verilog;
use verilog.vl_types.all;
entity test_RISC_SPM is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8
    );
end test_RISC_SPM;
