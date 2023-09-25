library ieee;
use ieee.std_logic_1164.all;

entity tb_main_arquitecture is
end tb_main_arquitecture;

architecture tb of tb_main_arquitecture is

    component main_arquitecture
        port (main_iord      : in std_logic;
              main_mem_read  : in std_logic;
              main_mem_write : in std_logic;
              main_alusrca   : in std_logic;
              main_alusrcb   : in std_logic_vector (1 downto 0);
              main_ir_write  : in std_logic;
              main_reg_write : in std_logic;
              main_reg_dst   : in std_logic_vector (1 downto 0);
              main_memtoreg  : in std_logic_vector (1 downto 0);
              memOut         : out std_logic_vector (31 downto 0);
              insReg         : out std_logic_vector (31 downto 0);
              sigExtS        : out std_logic_vector (31 downto 0);
              shifleft2      : out std_logic_vector (31 downto 0);
              main_func      : in std_logic_vector (5 downto 0);
              main_aluop     : in std_logic_vector (2 downto 0);
              main_out       : out std_logic_vector (31 downto 0);
              main_zero      : out std_logic;
              main_clk       : in std_logic;
              main_reset     : in std_logic);
    end component;

    signal main_iord      : std_logic;
    signal main_mem_read  : std_logic;
    signal main_mem_write : std_logic;
    signal main_alusrca   : std_logic;
    signal main_alusrcb   : std_logic_vector (1 downto 0);
    signal main_ir_write  : std_logic;
    signal main_reg_write : std_logic;
    signal main_reg_dst   : std_logic_vector (1 downto 0);
    signal main_memtoreg  : std_logic_vector (1 downto 0);
    signal memOut         : std_logic_vector (31 downto 0);
    signal insReg         : std_logic_vector (31 downto 0);
    signal sigExtS        : std_logic_vector (31 downto 0);
    signal shifleft2      : std_logic_vector (31 downto 0);
    signal main_func      : std_logic_vector (5 downto 0);
    signal main_aluop     : std_logic_vector (2 downto 0);
    signal main_out       : std_logic_vector (31 downto 0);
    signal main_zero      : std_logic;
    signal main_clk       : std_logic;
    signal main_reset     : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : main_arquitecture
    port map (main_iord      => main_iord,
              main_mem_read  => main_mem_read,
              main_mem_write => main_mem_write,
              main_alusrca   => main_alusrca,
              main_alusrcb   => main_alusrcb,
              main_ir_write  => main_ir_write,
              main_reg_write => main_reg_write,
              main_reg_dst   => main_reg_dst,
              main_memtoreg  => main_memtoreg,
              memOut         => memOut,
              insReg         => insReg,
              sigExtS        => sigExtS,
              shifleft2      => shifleft2,
              main_func      => main_func,
              main_aluop     => main_aluop,
              main_out       => main_out,
              main_zero      => main_zero,
              main_clk       => main_clk,
              main_reset     => main_reset);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that main_clk is really your main clock signal
    main_clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "00";
        main_ir_write <= '0';
        main_reg_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_func <= "000000";
        main_aluop <= "000";

        -- Reset generation
        -- EDIT: Check that main_reset is really your reset signal
        main_reset <= '1';
        wait for 100 ns;
        main_reset <= '0';

        -- FETCH ---
        main_iord <= '0';
        main_mem_read <= '1';
        main_mem_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "01";
        main_ir_write <= '1';
        main_reg_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_func <= "000000";
        main_aluop <= "000";
        wait for 100 ns;
        
        
        -- DECODE ---
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "11";
        main_ir_write <= '0';
        main_reg_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_func <= "000000";
        main_aluop <= "000";
        wait for 100 ns;
        
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_alusrca <= '1';
        main_alusrcb <= "10";
        main_ir_write <= '0';
        main_reg_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_func <= "000000";
        main_aluop <= "000";
        wait for 100 ns;

        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "00";
        main_ir_write <= '0';
        main_reg_write <= '1';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_func <= "000000";
        main_aluop <= "000";
        wait for 1000 ns;
    
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_main_arquitecture of tb_main_arquitecture is
    for tb
    end for;
end cfg_tb_main_arquitecture;
