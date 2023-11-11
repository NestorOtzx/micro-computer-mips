library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c_uart_rx is
    port (
    clock     : in std_logic;
    reset     : in std_logic;
    rx        : in std_logic;
    word      : out std_logic_vector(7 downto 0);
    busy_rx   : out std_logic
  );
end c_uart_rx;

architecture Behavioral of c_uart_rx is

type stateType is (idleST, dato0ST, dato1ST, dato2ST, dato3ST, dato4ST, dato5ST, dato6ST, dato7ST, stopST);
signal estadoActual, estadoSiguiente : stateType;
signal word_signal: STD_LOGIC_VECTOR(7 downto 0) := "00000000";

begin
    stateRegister: process (clock, reset)
    begin 
        if (reset = '1') then
            estadoActual <= idleST;
        else
            if (clock'event and clock ='1') then
                estadoActual <= estadoSiguiente;
            end if;
        end if;
    end process;
    
    process(estadoActual, rx)
    begin
         case (estadoActual) is
              when idleST => 
                 if (rx = '0') then
                    estadoSiguiente <= dato0ST;
                 else
                    estadoSiguiente <= idleST;
                 end if;
              when dato0ST => 
                 estadoSiguiente <= dato1ST;
              when dato1ST => 
                 estadoSiguiente <= dato2ST;
              when dato2ST => 
                 estadoSiguiente <= dato3ST;
              when dato3ST => 
                 estadoSiguiente <= dato4ST;
              when dato4ST => 
                 estadoSiguiente <= dato5ST;
              when dato5ST => 
                 estadoSiguiente <= dato6ST;
              when dato6ST => 
                 estadoSiguiente <= dato7ST;
              when dato7ST => 
                 estadoSiguiente <= stopST;
              when stopST => 
                 estadoSiguiente <= idleST;
              when others =>
                 estadoSiguiente <= idleST;
           end case;    
    end process;

    
    outputsFunction: process(estadoActual)
    begin
         case (estadoActual) is
              when idleST =>
                 word_signal <= "00000000";
                 busy_rx <= '0';
              when dato0ST => 
                 word_signal(0) <= rx;
                 busy_rx <= '1';
              when dato1ST => 
                 word_signal(1) <= rx;
                 busy_rx <= '1';
              when dato2ST => 
                 word_signal(2) <= rx;
                 busy_rx <= '1';
              when dato3ST => 
                 word_signal(3) <= rx;
                 busy_rx <= '1';
              when dato4ST => 
                 word_signal(4) <= rx;
                 busy_rx <= '1';
              when dato5ST => 
                 word_signal(5) <= rx;
                 busy_rx <= '1';
              when dato6ST => 
                 word_signal(6) <= rx;
                 busy_rx <= '1';
              when dato7ST => 
                 word_signal(7) <= rx;
                 busy_rx <= '1';
              when stopST => 
                 word <= word_signal;
                 busy_rx <= '0';
              when others =>
                 word_signal <= "00000000";
                 busy_rx <= '0';                            
           end case;    
    end process;

end Behavioral;
