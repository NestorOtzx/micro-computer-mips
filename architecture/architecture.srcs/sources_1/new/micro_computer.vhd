library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity micro_computer is
  Port ( 
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR (19 downto 0);
        
        leds: out std_logic_vector(15 downto 0);
        -- memout: out std_logic_vector(31 downto 0)
        enDigit: out std_logic_vector(3 downto 0);
        display: out std_logic_vector(6 downto 0)
  );
end micro_computer;

architecture Behavioral of micro_computer is

component controlDisplay
    Port ( dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           clock, reset : STD_LOGIC;
           --counter : in STD_LOGIC_VECTOR (1 downto 0);
           enDigit : out STD_LOGIC_VECTOR (3 downto 0);
           sevenSeg : out STD_LOGIC_VECTOR (6 downto 0));
end component;


component mux2to1_32b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC;
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

component ram
    port (    dir       : in std_logic_vector (31 downto 0);
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

signal signal_outenable: STD_LOGIC;
signal signal_outregister: STD_LOGIC_VECTOR (31 downto 0);
signal signal_memwrite, signal_memread: STD_LOGIC;
signal input_signal: STD_LOGIC_VECTOR (31 downto 0);
signal signal_procc_in: STD_LOGIC_VECTOR (31 downto 0);

begin

signal_outenable <= (signal_memwr and  signal_iord(9));
signal_memwrite <= (signal_memwr and not signal_memin(9));
signal_memread <= (singal_memrd and not signal_memin(9));
input_signal <= "000000000000" & input;


U_MUX: mux2to1_32b
port map(
    mux_in0 => signal_memout,
    mux_in1 => input_signal,
    mux_sel => signal_iord(9),
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
    --clk =>  divisor_counter(22),
    clk => clk,
    reset => reset,
    reg_output => signal_outregister
);

U_MEMORY: ram
port map (    dir => signal_iord, --direccion de la instruccion
              data => signal_memin,
              mem_read => singal_memrd,
              mem_write => signal_memwrite,
              mem_data => signal_memout,
              --clk => divisor_counter(22),
              clk => clk,
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
        --main_clk        => divisor_counter(22),
        main_clk        => clk,
        main_reset      => reset
    );

--testIRWRITE <= signal_ir_write;

--leds (15 downto 11) <= signal_iord(4 downto 0);
--leds (10 downto 0) <= signal_aluout(10 downto 0);

leds <= signal_outregister(15 downto 0);

--pcOut <= signal_pcTest;


--aluout<= signal_aluout;
end Behavioral;
