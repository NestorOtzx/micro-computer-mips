library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity c_uart_top is
  Port (
        clock: in STD_LOGIC;
        reset: in STD_LOGIC;
        send_word : in std_logic;
        word      : in std_logic_vector(7 downto 0);
        rx        : in std_logic;
        busy_tx   : out std_logic;
        tx        : out std_logic;
        word_out  : out std_logic_vector(7 downto 0);
        busy_rx   : out std_logic
  );
end c_uart_top;

architecture Behavioral of c_uart_top is

signal UART_CLK: STD_LOGIC := '0';
signal signal_sendword: STD_LOGIC:= '0';

component c_uart_tx
    port (
    clock       : in std_logic;
    reset      : in std_logic;
    send_word : in std_logic;
    word      : in std_logic_vector(7 downto 0);
    busy_tx   : out std_logic;
    tx        : out std_logic
  );
end component; 

component c_uart_rx
    port (
        clock     : in std_logic;
        reset     : in std_logic;
        rx        : in std_logic;
        word      : out std_logic_vector(7 downto 0);
        busy_rx   : out std_logic
    );
end component;

component uart_clockgen
    port(
        clock: in STD_LOGIC;
        reset: in STD_LOGIC;
        output: out STD_LOGIC
    );
end component;    

component extensor_uart
    port( clk: in STD_LOGIC;
    reset: in STD_LOGIC;
    send_word: in STD_LOGIC;
    word: in STD_LOGIC_VECTOR(7 downto 0);
    out_send_word: out STD_LOGIC;
    out_word: out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

signal signal_send_word: STD_LOGIC;
signal signal_word: STD_LOGIC_VECTOR(7 downto 0);

begin

U_EXT: extensor_uart
    port map(
        clk => clock,
        reset => reset,
        send_word => send_word,
        word => word,
        out_send_word =>signal_send_word, 
        out_word => signal_word
    );

U_CLOCK: uart_clockgen
    port map(
        clock => clock,
        reset => reset,
        output => UART_CLK
        );

U_TX: c_uart_tx
port map(
    clock    => UART_CLK,
    reset    => reset,
    send_word=> signal_send_word,
    word     => signal_word,
    busy_tx  => busy_tx,
    tx       => tx
);

U_RX: c_uart_rx
port map(
    clock    => UART_CLK,
    reset    => reset,
    rx       => rx,
    word     => word_out,
    busy_rx  => busy_rx
);
    

end Behavioral;
