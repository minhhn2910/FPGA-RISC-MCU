library verilog;
use verilog.vl_types.all;
entity test_Memory_BlockRAM is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8;
        address_size    : integer := 8
    );
    port(
        SW              : in     vl_logic_vector(17 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0)
    );
end test_Memory_BlockRAM;
