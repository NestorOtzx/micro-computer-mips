library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
    Port ( pc_in : in STD_LOGIC_VECTOR (31 downto 0);
           pc_write: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pc_out : out STD_LOGIC_VECTOR (31 downto 0));
end program_counter;

architecture Behavioral of program_counter is

signal pcSignal : std_logic_vector(31 downto 0) := "00000000000000000000000000001000";

begin
    process(clk, reset)
    begin 
        if reset = '1' then
            pcSignal <= "00000000000000000000000000001000";
        elsif rising_edge(clk) then
            if pc_write = '1' then
                pcSignal <= pc_in;
            end if;
        end if;
    end process;
    
    pc_out <= pcSignal;
end Behavioral;