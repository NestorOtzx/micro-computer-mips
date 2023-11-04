library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ram is
    Port ( dir : in STD_LOGIC_VECTOR (31 downto 0);
           data : in STD_LOGIC_VECTOR (31 downto 0);
           mem_read : in STD_LOGIC;
           mem_write : in STD_LOGIC;
           mem_data : out STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC;
           reset: in STD_LOGIC
           );
end ram;

architecture Behavioral of ram is

type tipo_ram is array (1024 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
                                  --OPCOD| rs | rt | inmediato              --OPCOD| rs | rt | inmediato  
signal memoria: tipo_ram := ( 0 =>  "00001100000000000000000000000010",  
                              1 =>  "00001000000000000000000000001010",
                              2 =>  "00111100000010000000000000001000",
                              3 =>  "00100000000011000000000000000001",
                              4 =>  "10001100000010010000001000000000",
                              5 =>  "00000001000010010101100000101010",
                              6 =>  "00010001011011000000000000000001",
                              7 =>  "00001000000000000000000000000100",
                              8 =>  "00000001001010000001000000100010",
                              9 =>  "00000011111000000000000000001000",
                              10 => "00000000000000100100000000100000",
                              11 => "10101100000000100000001000000000",
                              

                              others => (others=>'0'));
    
    
--- Entrada con enter
--00100000000100000111111111111111
--00100000000100010000000000000001
--10001100000100100000001000000000
--10101100000100100000001000000000
--00000010000100101001100000101010
--00010010011100010000000000000010
--00001000000000000000000000000000
--00100000000100010000000000000101
--10101100000100010000000100000000



--- Contadr de n a 10
-- 0 => "00100000000100010000000000001010",  
-- 1 => "10001100000100000000001000000000",
-- 2 => "00010010000100010000000000000011",
-- 3 => "00100010000100000000000000000001",
-- 4 => "10101100000100000000001000000000",
-- 5 => "00001000000000000000000000000010",
-- 6 => "00100000000100000000000000000000",
-- 7 => "10101100000100000000001000000000",
-- 8 => "00001000000000000000000000000001",

begin
    process(clk, mem_write)
    begin
         if((clk'event and clk = '1') and mem_write = '1') then
            memoria(to_integer(unsigned(dir(9 downto 0)))) <= data;    
         end if;
     end process;
     
     mem_data <= memoria(to_integer(unsigned(dir(9 downto 0))));
    
end Behavioral;
