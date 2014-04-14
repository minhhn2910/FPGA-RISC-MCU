library verilog;
use verilog.vl_types.all;
entity Multiplexer_3ch is
    generic(
        word_size       : integer := 10
    );
    port(
        mux_out         : out    vl_logic_vector;
        data_a          : in     vl_logic_vector;
        data_b          : in     vl_logic_vector;
        data_c          : in     vl_logic_vector;
        data_d          : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0)
    );
end Multiplexer_3ch;
