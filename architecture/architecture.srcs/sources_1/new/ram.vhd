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

type tipo_ram is array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
                                  --OPCOD| rs | rt | inmediato              --OPCOD| rs | rt | inmediato  
signal memoria: tipo_ram := ( 0 => "00100000000100000000000000000101",  
                              1 => "00100000000100010000000000001010",
                              2 => "00000010000100011000000000100000",
                              others => (others=>'0'));

begin
    process(clk, mem_write)
    begin
         if((clk'event and clk = '1') and mem_write = '1') then
            memoria(to_integer(unsigned(dir))) <= data;    
         end if;
     end process;
     
     mem_data <= memoria(to_integer(unsigned(dir)));
    
end Behavioral;
