library verilog;
use verilog.vl_types.all;
entity RISC_SPM is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8;
        address_size    : integer := 8;
        Sel1_size       : integer := 3;
        Sel2_size       : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        R0_out          : out    vl_logic_vector;
        R1_out          : out    vl_logic_vector;
        R2_out          : out    vl_logic_vector;
        R3_out          : out    vl_logic_vector;
        PC_count        : out    vl_logic_vector;
        instruction     : out    vl_logic_vector;
        zero            : out    vl_logic;
        state           : out    vl_logic_vector(3 downto 0);
        next_state      : out    vl_logic_vector(3 downto 0)
    );
end RISC_SPM;
