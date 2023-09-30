library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        aluout: out STD_LOGIC_VECTOR (31 downto 0)
  );
end micro_computer;

architecture Behavioral of micro_computer is

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
           main_reset: in STD_LOGIC
           );
end component;

component control
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        opcode: in STD_LOGIC_VECTOR (5 downto 0);
        
        pc_write: out STD_LOGIC;
        branch: out STD_LOGIC;
        iord: out STD_LOGIC;
        mem_read: out STD_LOGIC;
        mem_write: out STD_LOGIC;
        ir_write: out STD_LOGIC;
        reg_dst: out STD_LOGIC_VECTOR(1 downto 0);
        memtoreg: out STD_LOGIC_VECTOR(1 downto 0);
        reg_write: out STD_LOGIC;
        alusrca: out STD_LOGIC;
        alusrcb: out STD_LOGIC_VECTOR (1 downto 0);
        aluop: out STD_LOGIC_VECTOR (2 downto 0);
        pcsrc: out STD_LOGIC_VECTOR (1 downto 0)
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

begin

control_unit: control
    port map(
        pc_write    => signal_pc_write,
        branch      => signal_branch,
        iord        => signal_iord,
        mem_read    => signal_mem_read,
        mem_write   => signal_mem_write,
        ir_write    => signal_ir_write,
        reg_dst     => signal_reg_dst,
        memtoreg    => signal_memtoreg,
        reg_write   => signal_reg_write,
        alusrca     => signal_alusrca,
        alusrcb     => signal_alusrcb,
        aluop       => signal_aluop,
        pcsrc       => signal_pcsrc,
        clk         => clk,
        reset       => reset,
        opcode      => signal_opcode
   );

arquitecture: main_arquitecture
    port map(
        main_pc_write => signal_pc_write,
        main_branch   => signal_branch,
        main_iord     => signal_iord,
        main_mem_read => signal_mem_read,
        main_mem_write=> signal_mem_write,
        main_ir_write => signal_ir_write,
        main_reg_dst  => signal_reg_dst,
        main_memtoreg => signal_memtoreg,
        main_reg_write=> signal_reg_write,
        main_alusrca  => signal_alusrca, 
        main_alusrcb  => signal_alusrcb, 
        main_aluop    => signal_aluop,
        main_pcsrc    => signal_pcsrc,
        main_out      => aluout,
        main_opcode   => signal_opcode,
        main_clk      => clk,
        main_reset    => reset
    );
end Behavioral;
