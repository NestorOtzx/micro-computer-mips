library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity registers is
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
           
end registers;

architecture Behavioral of registers is

type tipo_ram is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
                              
signal registros: tipo_ram := (others => (others=>'0'));

begin
    process(clk)
    begin        
         if ((clk'event and clk = '1') and reg_write = '1') then
            registros(to_integer(unsigned(write_register))) <= write_data;
         end if;
     end process;
     
     read_data1 <= registros(to_integer(unsigned(rs)));
     read_data2 <= registros(to_integer(unsigned(rt)));     
    
end Behavioral;