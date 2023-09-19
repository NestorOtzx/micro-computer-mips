-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 19.9.2023 02:26:04 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_main_arquitecture is
end tb_main_arquitecture;

architecture tb of tb_main_arquitecture is

    component main_arquitecture
        port (registerA  : in std_logic_vector (31 downto 0);
              registerB  : in std_logic_vector (31 downto 0);
              main_func  : in std_logic_vector (5 downto 0);
              main_aluop : in std_logic_vector (2 downto 0);
              main_out   : out std_logic_vector (31 downto 0);
              main_zero  : out std_logic);
    end component;

    signal registerA  : std_logic_vector (31 downto 0);
    signal registerB  : std_logic_vector (31 downto 0);
    signal main_func  : std_logic_vector (5 downto 0);
    signal main_aluop : std_logic_vector (2 downto 0);
    signal main_out   : std_logic_vector (31 downto 0);
    signal main_zero  : std_logic;

begin

    dut : main_arquitecture
    port map (registerA  => registerA,
              registerB  => registerB,
              main_func  => main_func,
              main_aluop => main_aluop,
              main_out   => main_out,
              main_zero  => main_zero);

    stimuli : process
    begin
    -- PRUEBA DE INMEDIATOS --
        -- SUMA --
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "000000";
        main_aluop <= "000";
        
        wait for 10 ns;
        
        -- RESTA --
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010";
        main_func <= "000000";
        main_aluop <= "001";
        
        wait for 10 ns;
        
        -- ORI --
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010";
        main_func <= "000000";
        main_aluop <= "011";
        
        wait for 10 ns;
        
        -- ANDI --
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010";
        main_func <= "000000";
        main_aluop <= "100";
        
        wait for 10 ns;
        
        -- SLTI --
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010";
        main_func <= "000000";
        main_aluop <= "101";
        
        wait for 10 ns;
    
    -- PRUEBA DE TIPO R --
    
        --SUMA--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "100000";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --RESTA--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "100010";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --AND--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "100100";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --OR--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "100101";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --NOR--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "100111";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --SLT--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "101010";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --SLL--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "000000";
        main_aluop <= "010";
        
        wait for 10 ns;
        
        --SLT--
        registerA <= "00000000000000000000000000001100";
        registerB <= "00000000000000000000000000001010"; --00010110
        main_func <= "000010";
        main_aluop <= "010";
        
        wait for 10 ns;
               
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_main_arquitecture of tb_main_arquitecture is
    for tb
    end for;
end cfg_tb_main_arquitecture;
