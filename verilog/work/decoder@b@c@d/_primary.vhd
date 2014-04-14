library verilog;
use verilog.vl_types.all;
entity decoderBCD is
    port(
        led             : out    vl_logic_vector(6 downto 0);
        s               : in     vl_logic_vector(3 downto 0)
    );
end decoderBCD;
