library ieee;
use ieee.std_logic_1164.all;

entity tb_main_arquitecture is
end tb_main_arquitecture;

architecture tb of tb_main_arquitecture is

    component main_arquitecture
        port (main_pc_write  : in std_logic;
              main_branch    : in std_logic;
              main_iord      : in std_logic;
              main_mem_read  : in std_logic;
              main_mem_write : in std_logic;
              main_ir_write  : in std_logic;
              main_reg_dst   : in std_logic_vector (1 downto 0);
              main_memtoreg  : in std_logic_vector (1 downto 0);
              main_reg_write : in std_logic;
              main_alusrca   : in std_logic;
              main_alusrcb   : in std_logic_vector (1 downto 0);
              main_aluop     : in std_logic_vector (2 downto 0);
              main_pcsrc     : in std_logic_vector (1 downto 0);
              main_out       : out std_logic_vector (31 downto 0);
              main_zero      : out std_logic;
              main_clk       : in std_logic;
              main_reset     : in std_logic);
    end component;

    signal main_pc_write  : std_logic;
    signal main_branch    : std_logic;
    signal main_iord      : std_logic;
    signal main_mem_read  : std_logic;
    signal main_mem_write : std_logic;
    signal main_ir_write  : std_logic;
    signal main_reg_dst   : std_logic_vector (1 downto 0);
    signal main_memtoreg  : std_logic_vector (1 downto 0);
    signal main_reg_write : std_logic;
    signal main_alusrca   : std_logic;
    signal main_alusrcb   : std_logic_vector (1 downto 0);
    signal main_aluop     : std_logic_vector (2 downto 0);
    signal main_pcsrc     : std_logic_vector (1 downto 0);
    signal main_out       : std_logic_vector (31 downto 0);
    signal main_zero      : std_logic;
    signal main_clk       : std_logic;
    signal main_reset     : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : main_arquitecture
    port map (main_pc_write  => main_pc_write,
              main_branch    => main_branch,
              main_iord      => main_iord,
              main_mem_read  => main_mem_read,
              main_mem_write => main_mem_write,
              main_ir_write  => main_ir_write,
              main_reg_dst   => main_reg_dst,
              main_memtoreg  => main_memtoreg,
              main_reg_write => main_reg_write,
              main_alusrca   => main_alusrca,
              main_alusrcb   => main_alusrcb,
              main_aluop     => main_aluop,
              main_pcsrc     => main_pcsrc,
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
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "00";
        main_aluop <= "000";
        main_pcsrc <= "00";

        -- Reset generation
        -- EDIT: Check that main_reset is really your reset signal
        main_reset <= '1';
        wait for 100 ns;
        main_reset <= '0';
        wait for 100 ns;

        -- FETCH
        main_pc_write <= '1';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '1';
        main_mem_write <= '0';
        main_ir_write <= '1';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "01";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- DECODE
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "11";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- ADDI
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '1';
        main_alusrcb <= "10";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- WRITE REGISTER
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '1';
        main_alusrca <= '0';
        main_alusrcb <= "00";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
-- ADDDI 2 --
        -- FETCH --
        main_pc_write <= '1';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '1';
        main_mem_write <= '0';
        main_ir_write <= '1';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "01";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- DECODE
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '0';
        main_alusrcb <= "11";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- ADDI
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '0';
        main_alusrca <= '1';
        main_alusrcb <= "10";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;
        
        -- WRITE REGISTER
        main_pc_write <= '0';
        main_branch <= '0';
        main_iord <= '0';
        main_mem_read <= '0';
        main_mem_write <= '0';
        main_ir_write <= '0';
        main_reg_dst <= "00";
        main_memtoreg <= "00";
        main_reg_write <= '1';
        main_alusrca <= '0';
        main_alusrcb <= "00";
        main_aluop <= "000";
        main_pcsrc <= "00";
        wait for 100 ns;

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