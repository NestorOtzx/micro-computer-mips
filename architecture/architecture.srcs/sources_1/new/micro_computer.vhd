library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR (19 downto 0);
        leds: out std_logic_vector(15 downto 0);
        -- debug: out std_logic_vector(31 downto 0);
        -- memout: out std_logic_vector(31 downto 0)
        enDigit: out std_logic_vector(3 downto 0);
        display: out std_logic_vector(6 downto 0);
        
        --UART--
        rx: in std_logic;
        tx: out std_logic
  );
end micro_computer;

architecture Behavioral of micro_computer is

signal nClock: STD_LOGIC;

component quitaRebote
    Port ( boton : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           pulso : out STD_LOGIC);
end component;

component controlDisplay
    Port ( dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           clock, reset : STD_LOGIC;
           --counter : in STD_LOGIC_VECTOR (1 downto 0);
           enDigit : out STD_LOGIC_VECTOR (3 downto 0);
           sevenSeg : out STD_LOGIC_VECTOR (6 downto 0));
end component;


component mux4to1_32b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component count_32bit
    Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component register_32b
    Port ( reg_input : in STD_LOGIC_VECTOR (31 downto 0);
           write_enable: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           reg_output : out STD_LOGIC_VECTOR (31 downto 0));
end component;


component main_arquitecture
    Port ( 
           mem_data: in STD_LOGIC_VECTOR( 31 downto 0 );
           
           --salidas--
           iord_out: out STD_LOGIC_VECTOR (31 downto 0);
           main_out : out STD_LOGIC_VECTOR (31 downto 0);
           registerBout: out STD_LOGIC_VECTOR (31 downto 0);
           
           mem_rd: out STD_LOGIC;
           mem_wr: out STD_LOGIC;           

           --otros--
           main_clk: in STD_LOGIC;
           main_reset: in STD_LOGIC               
           );
end component;

component c_uart_top
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
end component;

component ram
    port (    dir       : in std_logic_vector (8 downto 0);
              data      : in std_logic_vector (31 downto 0);
              mem_read  : in std_logic;
              mem_write : in std_logic;
              mem_data  : out std_logic_vector (31 downto 0);
              clk       : in std_logic;
              reset     : in std_logic);
end component;

signal divisor_counter: STD_LOGIC_VECTOR (31 downto 0); 
signal signal_aluout: STD_LOGIC_VECTOR (31 downto 0);
signal signal_pcTest: STD_LOGIC_VECTOR (31 downto 0);

-- ARQUITECTURE SIGNALS --

signal signal_iord, signal_memout, signal_memin: STD_LOGIC_VECTOR (31 downto 0);
signal signal_memwr, singal_memrd: STD_LOGIC; 

-- OUT CONTROL --

signal signal_outenable, signal_ledsenable: STD_LOGIC;
signal signal_outregister, signal_outleds: STD_LOGIC_VECTOR (31 downto 0);
signal signal_memwrite, signal_memread: STD_LOGIC;
signal input_signal: STD_LOGIC_VECTOR (31 downto 0);
signal signal_procc_in, enter_extend: STD_LOGIC_VECTOR (31 downto 0);
signal enter_signal: STD_LOGIC;

signal signal_send_word: STD_LOGIC;
signal signal_uart_out: STD_LOGIC_VECTOR(7 downto 0);
signal signal_uart_info: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal uart_out_extnd: STD_LOGIC_VECTOR(31 downto 0);

begin

enter_extend <= ("0000000000000000000000000000000"&enter_signal);
nClock <= not divisor_counter(10);

signal_ledsenable <= (signal_memwr and  signal_iord(9) and signal_iord(10));
signal_outenable <= (signal_memwr and  signal_iord(9) and not signal_iord(10));
signal_memwrite <= (signal_memwr and not signal_iord(9) and not signal_iord(10));
signal_memread <= (singal_memrd and not signal_memin(9));
input_signal <= "0000000000000" & input(18 downto 0); -- real
--input_signal <= "000000000000" & input; --simulacion

--UART--
signal_send_word <= (signal_iord(10) and  signal_memin(8) and signal_memwr);
uart_out_extnd <= "000000000000000000000000"&signal_uart_out;

U_UART: c_uart_top
    port map(
    clock => clk,
    reset => reset, 
    send_word => signal_send_word,
    --send_word => '1',
    word => signal_memin(7 downto 0),
    --word => "11111111",
    rx => rx,
    busy_tx => signal_uart_info(1),
    tx => tx,
    word_out => signal_uart_out,
    busy_rx => signal_uart_info(0)
    );

U_QUITA_R: quitaRebote
    Port map ( boton => input(19),
           reset => reset,
           clock => clk,
           pulso => enter_signal
           ); 


U_MUX: mux4to1_32b
port map(
    mux_in0 => signal_memout,
    mux_in1 => input_signal,
    mux_in2 => uart_out_extnd,
    mux_in3 => enter_extend,
    mux_sel => signal_iord(10 downto 9),
    mux_out => signal_procc_in
);

U_SEVSEG: controlDisplay
port map(
    dataIn => signal_outregister(15 downto 0),
    clock => clk,
    reset => reset,
    enDigit => enDigit,
    sevenSeg => display

);


U_OUTREGISTER: register_32b
port map(
    reg_input => signal_memin,
    write_enable => signal_outenable,
    clk =>  divisor_counter(10),
    --clk => nClock,
    reset => reset,
    reg_output => signal_outregister
);

U_LEDSREGISTER: register_32b
port map(
    reg_input => signal_memin,
    write_enable => signal_ledsenable,
    clk =>  divisor_counter(10),
    --clk => nClock,
    reset => reset,
    reg_output => signal_outleds 
);

U_MEMORY: ram
port map (    dir => signal_iord(8 downto 0), --direccion de la instruccion
              data => signal_memin,
              mem_read => singal_memrd,
              mem_write => signal_memwrite,
              mem_data => signal_memout,
              --clk => nClock,
              clk => divisor_counter(10),
              reset => reset
         );


divisor: count_32bit
    port map(
        clk => clk,
        reset => reset,
        count => divisor_counter
    );

arquitecture: main_arquitecture
    port map(
        mem_data => signal_procc_in,
        iord_out => signal_iord,
        main_out => signal_aluout,
        registerBout => signal_memin,
        mem_rd => singal_memrd,
        mem_wr => signal_memwr,   
        main_clk        => divisor_counter(10),
        --main_clk        => clk,
        main_reset      => reset
    );

--testIRWRITE <= signal_ir_write;
-- ENTER NORMAL / ENTER QUITA REBOTE
leds <= input(19)&enter_signal&divisor_counter(10)&signal_outleds(12 downto 0);

--debug <= signal_outregister;
--pcOut <= signal_pcTest;


--aluout<= signal_aluout;
end Behavioral;
