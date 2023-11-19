library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c_uart_rx is
    port (
    clock     : in std_logic;
    reset     : in std_logic;
    rx        : in std_logic;
    word      : out std_logic_vector(8 downto 0);
    busy_rx   : out std_logic
  );
end c_uart_rx;

architecture Behavioral of c_uart_rx is

 
type stateType is (idleST, dato0ST, dato1ST, dato2ST, dato3ST, dato4ST, dato5ST, dato6ST, dato7ST, stopST);
signal estadoActual, estadoSiguiente : stateType;
signal word_signal, word_signal_tmp: STD_LOGIC_VECTOR(8 downto 0) := "000000000";


begin
    process (clock, reset)
    begin
       if (reset = '1') then
            word_signal <= "000000000";
        else
            if (clock'event and clock ='1') then
                word_signal <= word_signal_tmp;
            end if;
        end if;
    end process;

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

    
    outputsFunction: process(estadoActual, rx, word_signal_tmp)
    begin
         case (estadoActual) is
              when idleST =>
                 word_signal_tmp <= word_signal;
                 busy_rx <= '0';
              when dato0ST => 
                 word_signal_tmp <= "00000000"&rx;
                 busy_rx <= '1';
              when dato1ST => 
                 word_signal_tmp <= "0000000"&rx&word_signal(0);
                 busy_rx <= '1';
              when dato2ST => 
                 word_signal_tmp <= "000000"&rx&word_signal(1 downto 0);
                 busy_rx <= '1';
              when dato3ST => 
                 word_signal_tmp <= "00000"&rx&word_signal(2 downto 0);
                 busy_rx <= '1';
              when dato4ST => 
                 word_signal_tmp <= "0000"&rx&word_signal(3 downto 0);
                 busy_rx <= '1';
              when dato5ST => 
                 word_signal_tmp <= "000"&rx&word_signal(4 downto 0);
                 busy_rx <= '1';
              when dato6ST => 
                 word_signal_tmp <= "00"&rx&word_signal(5 downto 0);
                 busy_rx <= '1';
              when dato7ST => 
                 word_signal_tmp <= "0"&rx&word_signal(6 downto 0);
                 busy_rx <= '1';
              when stopST =>
                 word_signal_tmp <= "1"&word_signal(7 downto 0);
                 busy_rx <= '0';
              when others =>
                 word_signal_tmp <= (others => '0');
                 busy_rx <= '0';                            
           end case;    
    end process;
word <= word_signal;

end Behavioral;
