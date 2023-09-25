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
signal memoria: tipo_ram := ( 8 => "00000000000000100000000000000101", others => (others=>'0'));

begin
    process(clk, reset)
    begin
         if(rising_edge(clk)) then
            if(reset ='1') then
                memoria <= ( 8 => "00000000000000100000000000000101", others => (others=>'0'));
                mem_data <= memoria(8);
            else
                if(mem_write = '1') then
                    memoria(to_integer(unsigned(dir))) <= data;
                end if;
                if (mem_read = '1') then
                    mem_data <= memoria(to_integer(unsigned(dir)));
                end if;
            end if;
         end if;
     end process;
     
    
end Behavioral;
