library verilog;
use verilog.vl_types.all;
entity Alu_RISC is
    generic(
        word_size       : integer := 10;
        op_size         : integer := 4;
        data_size       : integer := 8;
        ADD             : integer := 0;
        SUB             : integer := 1;
        \AND\           : integer := 2;
        \OR\            : integer := 3;
        \NOT\           : integer := 4
      --JUMP            : integer type with unrepresentable value!
      --STORE           : integer type with unrepresentable value!
      --LOAD            : integer type with unrepresentable value!
      --SAVE            : integer type with unrepresentable value!
    );
    port(
        alu_zero_flag   : out    vl_logic;
        alu_out         : out    vl_logic_vector;
        data_1          : in     vl_logic_vector;
        data_2          : in     vl_logic_vector;
        sel             : in     vl_logic_vector
    );
end Alu_RISC;
