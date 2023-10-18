library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity main_arquitecture is
    Port ( 
           --CONTROL--
           main_pc_write: in STD_LOGIC;
           main_branch: in STD_LOGIC;
           main_iord: in STD_LOGIC;
           main_mem_read: in STD_LOGIC;
           main_mem_write: in STD_LOGIC;
           main_ir_write: in STD_LOGIC;
           main_reg_dst: in STD_LOGIC_VECTOR(1 downto 0);
           main_memtoreg: in STD_LOGIC_VECTOR(1 downto 0);
           main_reg_write: in STD_LOGIC;
           main_alusrca: in STD_LOGIC;
           main_alusrcb: in STD_LOGIC_VECTOR (1 downto 0);
           main_aluop: in STD_LOGIC_VECTOR (2 downto 0);
           main_pcsrc: in STD_LOGIC_VECTOR (1 downto 0);
           
           --salidas--
           main_out : out STD_LOGIC_VECTOR (31 downto 0);
           main_opcode: out STD_LOGIC_VECTOR (5 downto 0);
           
           --otros--
           main_clk: in STD_LOGIC;
           main_reset: in STD_LOGIC;
           
           
           pcOut: out std_logic_vector(31 downto 0 );
           testMemOut: out std_logic_vector(31 downto 0);
           testInstruction: out std_logic_vector(31 downto 0);
           testALUUP: out std_logic_vector(31 downto 0);
           testALUDOWN: out std_logic_vector(31 downto 0);
           testSignExtend: out std_logic_vector(31 downto 0)                  
           );
end main_arquitecture;

architecture MAIN of main_arquitecture is

component ram
    port (    dir       : in std_logic_vector (31 downto 0);
              data      : in std_logic_vector (31 downto 0);
              mem_read  : in std_logic;
              mem_write : in std_logic;
              mem_data  : out std_logic_vector (31 downto 0);
              clk       : in std_logic;
              reset     : in std_logic);
end component;

component alu
    Port ( alu_in_a : in STD_LOGIC_VECTOR (31 downto 0);
           alu_in_b : in STD_LOGIC_VECTOR (31 downto 0);
           operation: in STD_LOGIC_VECTOR (3 downto 0);
           alu_output : out STD_LOGIC_VECTOR (31 downto 0);
           zero: out STD_LOGIC
           );
end component;

component alu_control
    Port ( func: in STD_LOGIC_VECTOR (5 downto 0);
           alu_op: in STD_LOGIC_VECTOR (2 downto 0);
           control_out: out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

component register_32b
    Port ( reg_input : in STD_LOGIC_VECTOR (31 downto 0);
           write_enable: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           reg_output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component registers
    Port ( rs : in STD_LOGIC_VECTOR (4 downto 0);
           rt : in STD_LOGIC_VECTOR (4 downto 0);
           write_register : in STD_LOGIC_VECTOR (4 downto 0);
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           reg_write : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_data1 : out STD_LOGIC_VECTOR (31 downto 0);
           read_data2 : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component mux4to1_5b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (4 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component mux4to1_32b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux2to1_32b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component sign_extend
    Port (
           input: in STD_LOGIC_VECTOR(15 downto 0);
           output: out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

component program_counter
     Port ( pc_in : in STD_LOGIC_VECTOR (31 downto 0);
           pc_write: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pc_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--Signals auxiliares--
signal nclock: STD_LOGIC;



--Multiplexores
signal tmpWriteData, tmpIorD, tmpPcSrc: STD_LOGIC_VECTOR (31 downto 0);
signal tmpWriteRegister: STD_LOGIC_VECTOR (4 downto 0);
signal tmpAluSrcA, tmpAluSrcB: STD_LOGIC_VECTOR (31 downto 0);


--Registeros--
signal tmpRegAout, tmpRegBout, tmpAluoutOut, tmpPCout: STD_LOGIC_VECTOR (31 downto 0);
signal tmpRegAin, tmpRegBin, tmpAluoutIn: STD_LOGIC_VECTOR (31 downto 0);
signal tmpInstruction, tmpMemoryDataReg: STD_LOGIC_VECTOR (31 downto 0);

--Otros--
signal tmpAluOperation: STD_LOGIC_VECTOR (3 downto 0);
signal inmediate: STD_LOGIC_VECTOR (15 downto 0);
signal signExtendInmediate, shiftLeft2Inmediate, tmpMemorySignal, jumpSignal: STD_LOGIC_VECTOR (31 downto 0);
signal pcEnable, tmpAluZero: STD_LOGIC;
begin

nclock <= not main_clk;

pcEnable <= main_pc_write or (main_branch and tmpAluZero);
U_PC: program_counter
    port map(
        pc_in  => tmpPcSrc,
        pc_write => pcEnable,
        clk => main_clk,
        reset => main_reset,
        pc_out => tmpPCout
    );

pcOut <= tmpIorD;

U_MUX_IORD: mux2to1_32b
    port map ( mux_in0 => tmpPCout, --PC
               mux_in1 => tmpAluoutOut,
               mux_sel => main_iord,
               mux_out => tmpIorD
               );

testMemOut <= tmpMemorySignal;

U_MEMORY: ram
port map (    dir => tmpIorD, --direccion de la instruccion
              data => tmpRegBout,
              mem_read =>  main_mem_read,
              mem_write =>  main_mem_write,
              mem_data => tmpMemorySignal,
              clk => main_clk,
              reset => main_reset
         );
testInstruction <= tmpInstruction;

U_INSTRUCTION_REGISTER: register_32b
port map(
    reg_input => tmpMemorySignal,
    write_enable => main_ir_write,
    clk => nclock,
    reset => main_reset,
    reg_output => tmpInstruction
);

U_MEMORY_DATA_REGISTER: register_32b
port map(
    reg_input => tmpMemorySignal,
    write_enable => '1',
    clk => main_clk,
    reset => main_reset,
    reg_output => tmpMemoryDataReg
);

U_MUX_RGDST: mux4to1_5b
    port map ( mux_in0 => tmpInstruction(20 downto 16),
               mux_in1 => tmpInstruction(15 downto 11),
               mux_in2 => "11111",
               mux_in3 => "00000",
               mux_sel => main_reg_dst,
               mux_out => tmpWriteRegister
               );

U_MUX_MEMTOREG: mux4to1_32b
    port map ( mux_in0 => tmpAluoutOut,
               mux_in1 => tmpMemoryDataReg,
               mux_in2 => tmpPCout, --PC
               mux_in3 => "00000000000000000000000000000000", --NADA
               mux_sel => main_memtoreg,
               mux_out => tmpWriteData
               );

U_REGISTERS: registers
    port map( 
           rs => tmpInstruction(25 downto 21),
           rt => tmpInstruction(20 downto 16),
           write_register => tmpWriteRegister,
           write_data => tmpWriteData,
           reg_write => main_reg_write,
           clk => main_clk,
           reset => main_reset,
           read_data1 => tmpRegAin,
           read_data2 => tmpRegBin
    );

U_REGISTER_A: register_32b
port map(
    reg_input => tmpRegAin,
    write_enable => '1',
    clk => main_clk,
    reset => main_reset,
    reg_output => tmpRegAout
);

U_REGISTER_B: register_32b
port map(
    reg_input => tmpRegBin,
    write_enable => '1',
    clk => main_clk,
    reset => main_reset,
    reg_output => tmpRegBout
);
testSignExtend <= signExtendInmediate;
--SIGN EXTEND
U_SIGN_EXTEND: sign_extend
    port map(
        input => tmpInstruction(15 downto 0), 
        output=> signExtendInmediate
    );

--SHIFT LEFT 2

U_MUX_ALUSRCA: mux2to1_32b
    port map ( mux_in0 => tmpPCout, --PC
               mux_in1 => tmpRegAout,
               mux_sel => main_alusrca,
               mux_out => tmpAluSrcA
               );

U_MUX_ALUSRCB: mux4to1_32b
    port map ( mux_in0 => tmpRegBout,
               mux_in1 => "00000000000000000000000000000001", --cambiar a 4
               mux_in2 => signExtendInmediate, -- sign extend inmediate
               mux_in3 => signExtendInmediate, -- sign extend inmediate shift left 2
               mux_sel => main_alusrcb,
               mux_out => tmpAluSrcB
               );

U_ALUCONTROL : alu_control
port map(
    func => tmpInstruction(5 downto 0),
    alu_op=>main_aluop,
    control_out => tmpAluOperation
);
testALUUP <= tmpAluSrcA;
testALUDOWN <= tmpAluSrcB;
U_ALU : alu
port map(
    alu_in_a => tmpAluSrcA,
    alu_in_b => tmpAluSrcB,
    operation => tmpAluOperation,
    alu_output => tmpAluoutIn,
    zero => tmpAluZero
);

U_ALUOUT: register_32b
port map(
    reg_input => tmpAluoutIn,
    write_enable => '1',
    clk => main_clk,
    reset => main_reset,
    reg_output => tmpAluoutOut
);

jumpSignal <= (tmpPCout(31 downto 26))&tmpInstruction(25 downto 0);

U_MUX_PC_SRC: mux4to1_32b
    port map ( mux_in0 => tmpAluoutIn,
               mux_in1 => tmpAluoutOut,
               mux_in2 => jumpSignal, --J
               mux_in3 => "00000000000000000000000000001000", --NADA
               mux_sel => main_pcsrc,
               mux_out => tmpPcSrc
               );


main_out<=tmpAluoutOut;
main_opcode <= tmpInstruction (31 downto 26);

end MAIN;
