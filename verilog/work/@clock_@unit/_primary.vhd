library verilog;
use verilog.vl_types.all;
entity Clock_Unit is
    generic(
        delay           : integer := 0;
        half_cycle      : integer := 10
    );
    port(
        clock           : out    vl_logic
    );
end Clock_Unit;
