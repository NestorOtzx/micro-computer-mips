library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c_uart_tx is
    port (
    clock       : in std_logic;
    reset      : in std_logic;
    send_word : in std_logic;
    word      : in std_logic_vector(7 downto 0);
    busy_tx   : out std_logic;
    tx        : out std_logic
  );
end c_uart_tx;

architecture Behavioral of c_uart_tx is

type stateType is (idleST, startST, dato0ST, dato1ST, dato2ST, dato3ST, dato4ST, dato5ST, dato6ST, dato7ST, stopST);
signal estadoActual, estadoSiguiente : stateType;

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
    
    process(estadoActual)
    begin
         case (estadoActual) is
              when idleST => 
                 if (send_word = '1') then
                    estadoSiguiente <= startST;
                 else
                    estadoSiguiente <= idleST;
                 end if;
              when startST => 
                 estadoSiguiente <= dato0ST;
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
                 tx <= '0';
                 busy_tx <= '0';
              when startST => 
                 tx <= '1';
                 busy_tx <= '1';
              when dato0ST => 
                 tx <= word(0);
                 busy_tx <= '1';
              when dato1ST => 
                 tx <= word(1);
                 busy_tx <= '1';
              when dato2ST => 
                 tx <= word(2);
                 busy_tx <= '1';
              when dato3ST => 
                 tx <= word(3);
                 busy_tx <= '1';
              when dato4ST => 
                 tx <= word(4);
                 busy_tx <= '1';
              when dato5ST => 
                 tx <= word(5);
                 busy_tx <= '1';
              when dato6ST => 
                 tx <= word(6);
                 busy_tx <= '1';
              when dato7ST => 
                 tx <= word(7);
                 busy_tx <= '1';
              when stopST => 
                 tx <= '1';
                 busy_tx <= '0';
              when others =>
                 tx <= '0';
                 busy_tx <= '0';
                            
           end case;    
    end process;
end Behavioral;
