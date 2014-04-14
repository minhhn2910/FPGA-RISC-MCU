library verilog;
use verilog.vl_types.all;
entity Processing_Unit is
    generic(
        word_size       : integer := 10;
        data_size       : integer := 8;
        address_size    : integer := 8;
        op_size         : integer := 4;
        Sel1_size       : integer := 3;
        Sel2_size       : integer := 3
    );
    port(
        instruction     : out    vl_logic_vector;
        Zflag           : out    vl_logic;
        address         : out    vl_logic_vector;
        address_decoded : in     vl_logic_vector;
        constant_decoded: in     vl_logic_vector;
        Bus_1a          : out    vl_logic_vector;
        Bus_1b          : out    vl_logic_vector;
        mem_word        : in     vl_logic_vector;
        Load_R0         : in     vl_logic;
        Load_R1         : in     vl_logic;
        Load_R2         : in     vl_logic;
        Load_R3         : in     vl_logic;
        Load_PC         : in     vl_logic;
        Inc_PC          : in     vl_logic;
        Sel_Bus_1a_Mux  : in     vl_logic_vector;
        Sel_Bus_1b_Mux  : in     vl_logic_vector;
        Load_IR         : in     vl_logic;
        Load_Add_R      : in     vl_logic;
        Load_Reg_Z      : in     vl_logic;
        Sel_Bus_2_Mux   : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        R0_out          : out    vl_logic_vector;
        R1_out          : out    vl_logic_vector;
        R2_out          : out    vl_logic_vector;
        R3_out          : out    vl_logic_vector;
        PC_count        : out    vl_logic_vector
    );
end Processing_Unit;
