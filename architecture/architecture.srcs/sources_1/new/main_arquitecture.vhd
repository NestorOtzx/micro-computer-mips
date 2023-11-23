library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity main_arquitecture is
    Port ( 
           mem_data: in STD_LOGIC_VECTOR( 31 downto 0 );
           
           --salidas--
           iord_out: out STD_LOGIC_VECTOR (31 downto 0);
           main_out : out STD_LOGIC_VECTOR (31 downto 0);
           registerBout: out STD_LOGIC_VECTOR (31 downto 0);
           
           mem_rd: out STD_LOGIC;
           mem_wr: out STD_LOGIC;           

           --otros--
           main_clk: in STD_LOGIC;
           main_reset: in STD_LOGIC              
           );
end main_arquitecture;

architecture MAIN of main_arquitecture is

component control
    Port ( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        opcode : in STD_LOGIC_VECTOR (5 downto 0);
        func : in STD_LOGIC_VECTOR (5 downto 0);
        irWrite : out STD_LOGIC;
        memToReg : out std_logic_vector(1 downto 0);
        memWrite : out STD_LOGIC;
        memRead : out STD_LOGIC;
        IorD : out STD_LOGIC;
        pcWrite : out STD_LOGIC;
        branch : out STD_LOGIC;
        pcSrc : out STD_LOGIC_VECTOR (1 downto 0);
        aluOP : out STD_LOGIC_VECTOR (2 downto 0);
        aluSrcB : out STD_LOGIC_VECTOR (1 downto 0);
        aluSrcA : out STD_LOGIC;
        regWrite : out STD_LOGIC;
        regDst : out STD_LOGIC_vector(1 downto 0)
   );
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

           --CONTROL--
signal main_pc_write: STD_LOGIC;
signal main_branch: STD_LOGIC;
signal main_iord: STD_LOGIC;
signal main_ir_write: STD_LOGIC;
signal main_reg_dst: STD_LOGIC_VECTOR(1 downto 0);
signal main_memtoreg: STD_LOGIC_VECTOR(1 downto 0);
signal main_reg_write: STD_LOGIC;
signal main_alusrca: STD_LOGIC;
signal main_alusrcb: STD_LOGIC_VECTOR (1 downto 0);
signal main_aluop: STD_LOGIC_VECTOR (2 downto 0);
signal main_pcsrc: STD_LOGIC_VECTOR (1 downto 0);

--Signals auxiliares--
signal nclock: STD_LOGIC;



--Multiplexores
signal tmpWriteData, tmpPcSrc: STD_LOGIC_VECTOR (31 downto 0);
signal tmpWriteRegister: STD_LOGIC_VECTOR (4 downto 0);
signal tmpAluSrcA, tmpAluSrcB: STD_LOGIC_VECTOR (31 downto 0);


--Registeros--
signal tmpRegAout, tmpRegBout, tmpAluoutOut, tmpPCout: STD_LOGIC_VECTOR (31 downto 0);
signal tmpRegAin, tmpRegBin, tmpAluoutIn: STD_LOGIC_VECTOR (31 downto 0);
signal tmpInstruction, tmpMemoryDataReg: STD_LOGIC_VECTOR (31 downto 0);

--Otros--
signal tmpAluOperation: STD_LOGIC_VECTOR (3 downto 0);
signal inmediate: STD_LOGIC_VECTOR (15 downto 0);
signal signExtendInmediate, shiftLeft2Inmediate, jumpSignal, luiSignal, inmUnsignedSignal: STD_LOGIC_VECTOR (31 downto 0);
signal pcEnable, tmpAluZero: STD_LOGIC;
begin

nclock <= not main_clk;

pcEnable <= main_pc_write or (main_branch and tmpAluZero);


control_unit: control
    port map(
        pcWrite     =>  main_pc_write,
        branch      =>  main_branch,
        IorD        =>  main_iord,
        memRead     =>  mem_rd,
        memWrite    =>  mem_wr,
        irWrite     =>  main_ir_write,
        regDst      =>  main_reg_dst,
        memToReg    =>  main_memtoreg,
        regWrite    =>  main_reg_write,
        aluSrcA     =>  main_alusrca,
        aluSrcB     =>  main_alusrcb,
        aluOP       =>  main_aluop,
        pcSrc       =>  main_pcsrc,
        clock       => main_clk,
        reset       => main_reset,
        opcode      => tmpInstruction (31 downto 26),
        func        => tmpInstruction (5 downto 0)
        
   );

U_PC: program_counter
    port map(
        pc_in  => tmpPcSrc,
        pc_write => pcEnable,
        clk => nclock,
        reset => main_reset,
        pc_out => tmpPCout
    );


U_MUX_IORD: mux2to1_32b
    port map ( mux_in0 => tmpPCout, --PC
               mux_in1 => tmpAluoutOut,
               mux_sel => main_iord,
               mux_out => iord_out
               );

U_INSTRUCTION_REGISTER: register_32b
port map(
    reg_input => mem_data,
    write_enable => main_ir_write,
    clk => nclock,
    reset => main_reset,
    reg_output => tmpInstruction
);

U_MEMORY_DATA_REGISTER: register_32b
port map(
    reg_input => mem_data,
    write_enable => '1',
    clk => nclock,
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

luiSignal <= (tmpInstruction(15 downto 0) & "0000000000000000");
U_MUX_MEMTOREG: mux4to1_32b
    port map ( mux_in0 => tmpAluoutOut,
               mux_in1 => tmpMemoryDataReg,
               mux_in2 => tmpPCout, --PC
               mux_in3 => luiSignal,
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
           clk => nclock,
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

registerBout <= tmpRegBout;
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

inmUnsignedSignal <= "0000000000000000"&tmpInstruction(15 downto 0);
U_MUX_ALUSRCB: mux4to1_32b
    port map ( mux_in0 => tmpRegBout,
               mux_in1 => "00000000000000000000000000000001", 
               mux_in2 => signExtendInmediate, -- sign extend inmediate
               mux_in3 => inmUnsignedSignal, -- sign extend inmediate shift left 2
               mux_sel => main_alusrcb,
               mux_out => tmpAluSrcB
               );

U_ALUCONTROL : alu_control
port map(
    func => tmpInstruction(5 downto 0),
    alu_op=>main_aluop,
    control_out => tmpAluOperation
);
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
    clk => nclock,
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


end MAIN;
