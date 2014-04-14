library verilog;
use verilog.vl_types.all;
entity test_Memory_Unit is
    generic(
        word_size       : integer := 10;
        memory_size     : integer := 256;
        address_size    : integer := 8
    );
end test_Memory_Unit;
