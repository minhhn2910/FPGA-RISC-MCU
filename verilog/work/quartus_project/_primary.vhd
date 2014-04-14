library verilog;
use verilog.vl_types.all;
entity quartus_project is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8
    );
    port(
        CLOCK_50        : in     vl_logic;
        SW              : in     vl_logic_vector(17 downto 17);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        HEX6            : out    vl_logic_vector(6 downto 0);
        HEX7            : out    vl_logic_vector(6 downto 0);
        LEDR            : out    vl_logic_vector(17 downto 0);
        LEDG            : out    vl_logic_vector(7 downto 0)
    );
end quartus_project;
