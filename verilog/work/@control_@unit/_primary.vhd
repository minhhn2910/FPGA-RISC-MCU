library verilog;
use verilog.vl_types.all;
entity Control_Unit is
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
        Sel2_size       : integer := 3;
        S_idle          : integer := 0;
        S_fet1          : integer := 1;
        S_fet2          : integer := 2;
        S_fet3          : integer := 3;
        S_dec           : integer := 13;
        S_ex1           : integer := 14;
        S_rd1           : integer := 4;
        S_wr1           : integer := 5;
        S_siz1          : integer := 6;
        S_siz2          : integer := 7;
        S_jump1         : integer := 7;
        S_jump2         : integer := 8;
        S_wait          : integer := 9;
        S_br2           : integer := 10;
        S_halt          : integer := 15;
        S_nop           : integer := 12;
        ADD             : integer := 0;
        SUB             : integer := 1;
        \AND\           : integer := 2;
        \OR\            : integer := 3;
        \NOT\           : integer := 4;
        SIZ             : integer := 10;
        NOP             : integer := 11;
        OP_5            : integer := 5;
      --JUMP            : integer type with unrepresentable value!
      --STORE           : integer type with unrepresentable value!
      --LOAD            : integer type with unrepresentable value!
      --SAVE            : integer type with unrepresentable value!
        R0              : integer := 0;
        R1              : integer := 1;
        R2              : integer := 2;
        R3              : integer := 3
    );
    port(
        Load_R0         : out    vl_logic;
        Load_R1         : out    vl_logic;
        Load_R2         : out    vl_logic;
        Load_R3         : out    vl_logic;
        Load_PC         : out    vl_logic;
        Inc_PC          : out    vl_logic;
        Sel_Bus_1a_Mux  : out    vl_logic_vector;
        Sel_Bus_1b_Mux  : out    vl_logic_vector;
        Sel_Bus_2_Mux   : out    vl_logic_vector;
        Load_IR         : out    vl_logic;
        Load_Add_R      : out    vl_logic;
        Load_Reg_Z      : out    vl_logic;
        write           : out    vl_logic;
        address_decoded : out    vl_logic_vector;
        constant_decoded: out    vl_logic_vector;
        instruction     : in     vl_logic_vector;
        zero            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        state           : out    vl_logic_vector;
        next_state      : out    vl_logic_vector
    );
end Control_Unit;
