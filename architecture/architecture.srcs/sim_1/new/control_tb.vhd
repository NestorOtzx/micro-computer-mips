library ieee;
use ieee.std_logic_1164.all;

entity tb_control is
end tb_control;

architecture tb of tb_control is

    component control
        port (clk       : in std_logic;
              reset     : in std_logic;
              opcode    : in std_logic_vector (5 downto 0);
              pc_write  : out std_logic;
              branch    : out std_logic;
              iord      : out std_logic;
              mem_read  : out std_logic;
              mem_write : out std_logic;
              ir_write  : out std_logic;
              reg_dst   : out std_logic_vector (1 downto 0);
              memtoreg  : out std_logic_vector (1 downto 0);
              reg_write : out std_logic;
              alusrca   : out std_logic;
              alusrcb   : out std_logic_vector (1 downto 0);
              aluop     : out std_logic_vector (2 downto 0);
              pcsrc     : out std_logic_vector (1 downto 0));
    end component;

    signal clk       : std_logic;
    signal reset     : std_logic;
    signal opcode    : std_logic_vector (5 downto 0);
    signal pc_write  : std_logic;
    signal branch    : std_logic;
    signal iord      : std_logic;
    signal mem_read  : std_logic;
    signal mem_write : std_logic;
    signal ir_write  : std_logic;
    signal reg_dst   : std_logic_vector (1 downto 0);
    signal memtoreg  : std_logic_vector (1 downto 0);
    signal reg_write : std_logic;
    signal alusrca   : std_logic;
    signal alusrcb   : std_logic_vector (1 downto 0);
    signal aluop     : std_logic_vector (2 downto 0);
    signal pcsrc     : std_logic_vector (1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : control
    port map (clk       => clk,
              reset     => reset,
              opcode    => opcode,
              pc_write  => pc_write,
              branch    => branch,
              iord      => iord,
              mem_read  => mem_read,
              mem_write => mem_write,
              ir_write  => ir_write,
              reg_dst   => reg_dst,
              memtoreg  => memtoreg,
              reg_write => reg_write,
              alusrca   => alusrca,
              alusrcb   => alusrcb,
              aluop     => aluop,
              pcsrc     => pcsrc);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        opcode <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        opcode <= "001000"; --addi
        
        wait for 400 ns;
        
        opcode <= "001010"; --slti
        
        wait for 400 ns;
        
        opcode <= "001101"; --ori
        
        wait for 400 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_control of tb_control is
    for tb
    end for;
end cfg_tb_control;