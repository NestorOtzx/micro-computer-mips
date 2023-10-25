library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
--        aluout: out STD_LOGIC_VECTOR (31 downto 0);
--        pcOut: out std_logic_vector(31 downto 0);
--        testMemOut: out std_logic_vector(31 downto 0);
--        testInstruction: out std_logic_vector(31 downto 0);
--        testALUUP: out std_logic_vector(31 downto 0);
--        testALUDOWN: out std_logic_vector(31 downto 0);
--        testSignExtend: out std_logic_vector(31 downto 0);
--        testIRWRITE: out std_logic;

        leds: out std_logic_vector(15 downto 0)
  );
end micro_computer;

architecture Behavioral of micro_computer is

component count_32bit
    Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component main_arquitecture
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
           pcOut: out std_logic_vector(31 downto 0);
           
           testMemOut: out std_logic_vector(31 downto 0);
           testInstruction: out std_logic_vector(31 downto 0);
           testALUUP: out std_logic_vector(31 downto 0);
           testALUDOWN: out std_logic_vector(31 downto 0);
           testSignExtend: out std_logic_vector(31 downto 0)

           );
end component;

component control
    Port ( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        opcode : in STD_LOGIC_VECTOR (5 downto 0);
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
    
signal signal_pc_write: STD_LOGIC;
signal signal_branch: STD_LOGIC;
signal signal_iord: STD_LOGIC;
signal signal_mem_read: STD_LOGIC;
signal signal_mem_write: STD_LOGIC;
signal signal_ir_write: STD_LOGIC;
signal signal_reg_dst: STD_LOGIC_VECTOR(1 downto 0);
signal signal_memtoreg: STD_LOGIC_VECTOR(1 downto 0);
signal signal_reg_write: STD_LOGIC;
signal signal_alusrca: STD_LOGIC;
signal signal_alusrcb: STD_LOGIC_VECTOR (1 downto 0);
signal signal_aluop: STD_LOGIC_VECTOR (2 downto 0);
signal signal_pcsrc: STD_LOGIC_VECTOR (1 downto 0);
signal signal_opcode: STD_LOGIC_VECTOR (5 downto 0);
signal divisor_counter: STD_LOGIC_VECTOR (31 downto 0); 
signal signal_aluout: STD_LOGIC_VECTOR (31 downto 0);
signal signal_pcTest: STD_LOGIC_VECTOR (31 downto 0);
begin

divisor: count_32bit
    port map(
        clk => clk,
        reset => reset,
        count => divisor_counter
    );



control_unit: control
    port map(
        pcWrite     => signal_pc_write,
        branch      => signal_branch,
        IorD        => signal_iord,
        memRead     => signal_mem_read,
        memWrite    => signal_mem_write,
        irWrite     => signal_ir_write,
        regDst      => signal_reg_dst,
        memToReg    => signal_memtoreg,
        regWrite    => signal_reg_write,
        aluSrcA     => signal_alusrca,
        aluSrcB     => signal_alusrcb,
        aluOP       => signal_aluop,
        pcSrc       => signal_pcsrc,
        clock       => divisor_counter(26),
--        clock       => clk,
        reset       => reset,
        opcode      => signal_opcode
        
   );
   
   

arquitecture: main_arquitecture
    port map(
        main_pc_write   => signal_pc_write,
        main_branch     => signal_branch,
        main_iord       => signal_iord,
        main_mem_read   => signal_mem_read,
        main_mem_write  => signal_mem_write,
        main_ir_write   => signal_ir_write,
        main_reg_dst    => signal_reg_dst,
        main_memtoreg   => signal_memtoreg,
        main_reg_write  => signal_reg_write,
        main_alusrca    => signal_alusrca, 
        main_alusrcb    => signal_alusrcb, 
        main_aluop      => signal_aluop,
        main_pcsrc      => signal_pcsrc,
        main_out        => signal_aluout,
        main_opcode     => signal_opcode,
        main_clk        => divisor_counter(26),
--        main_clk        => clk,
        main_reset      => reset,
        pcOut           => signal_pcTest
--        testMemOut      => testMemOut,
--        testInstruction => testInstruction,
--        testALUUP       => testALUUP,
--        testALUDOWN     => testALUDOWN,
--        testSignExtend  => testSignExtend
    );

--testIRWRITE <= signal_ir_write;
leds (15 downto 12) <= signal_pcTest(3 downto 0);
leds (11 downto 0) <= signal_aluout(11 downto 0);
--pcOut <= signal_pcTest;


--aluout<= signal_aluout;
end Behavioral;
