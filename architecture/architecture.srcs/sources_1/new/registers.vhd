library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

component mux32to1_32b
    Port ( mux_in0 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in1 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in2 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in3 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in4 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in5 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in6 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in7 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in8 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in9 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in10 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in11 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in12 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in13 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in14 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in15 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in16 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in17 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in18 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in19 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in20 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in21 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in22 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in23 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in24 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in25 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in26 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in27 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in28 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in29 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in30 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_in31 : in STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;
    
component register_32b
    Port ( reg_input : in STD_LOGIC_VECTOR (31 downto 0);
           write_enable: in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           reg_output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal tmpDeco, tempDecoEnable: STD_LOGIC_VECTOR (31 downto 0);
signal tempMux0, tempMux1, tempMux2, tempMux3, tempMux4, tempMux5, tempMux6, tempMux7, tempMux8, tempMux9, tempMux10, tempMux11, tempMux12, tempMux13,tempMux14,tempMux15, tempMux16, tempMux17, tempMux18, tempMux19, tempMux20, tempMux21, tempMux22, tempMux23, tempMux24, tempMux25, tempMux26, tempMux27, tempMux28, tempMux29, tempMux30, tempMux31: STD_LOGIC_VECTOR (31 downto 0); 

begin


zero: register_32b
    port map(
     reg_input => write_data,
     write_enable => '0',
     clk => clk,
     reset => reset,
     reg_output => tempMux0
);

at: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(1),
     clk => clk,
     reset => reset,
     reg_output => tempMux1
);

v0: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(2),
     clk => clk,
     reset => reset,
     reg_output => tempMux2
);
v1: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(3),
     clk => clk,
     reset => reset,
     reg_output => tempMux3
);

a0: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(4),
     clk => clk,
     reset => reset,
     reg_output => tempMux4
);
a1: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(5),
     clk => clk,
     reset => reset,
     reg_output => tempMux5
);
a2: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(6),
     clk => clk,
     reset => reset,
     reg_output => tempMux6
);
a3: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(7),
     clk => clk,
     reset => reset,
     reg_output => tempMux7
);

t0: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(8),
     clk => clk,
     reset => reset,
     reg_output => tempMux8
);
t1: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(9),
     clk => clk,
     reset => reset,
     reg_output => tempMux9
);
t2: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(10),
     clk => clk,
     reset => reset,
     reg_output => tempMux10
);
t3: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(11),
     clk => clk,
     reset => reset,
     reg_output => tempMux11
);
t4: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(12),
     clk => clk,
     reset => reset,
     reg_output => tempMux12
);
t5: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(13),
     clk => clk,
     reset => reset,
     reg_output => tempMux13
);
t6: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(14),
     clk => clk,
     reset => reset,
     reg_output => tempMux14
);
t7: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(15),
     clk => clk,
     reset => reset,
     reg_output => tempMux15
);

s0: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(16),
     clk => clk,
     reset => reset,
     reg_output => tempMux16
);
s1: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(17),
     clk => clk,
     reset => reset,
     reg_output => tempMux17
);
s2: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(18),
     clk => clk,
     reset => reset,
     reg_output => tempMux18
);
s3: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(19),
     clk => clk,
     reset => reset,
     reg_output => tempMux19
);
s4: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(20),
     clk => clk,
     reset => reset,
     reg_output => tempMux20
);
s5: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(21),
     clk => clk,
     reset => reset,
     reg_output => tempMux21
);
s6: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(22),
     clk => clk,
     reset => reset,
     reg_output => tempMux22
);
s7: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(23),
     clk => clk,
     reset => reset,
     reg_output => tempMux23
);

t8: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(24),
     clk => clk,
     reset => reset,
     reg_output => tempMux24
);
t9: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(25),
     clk => clk,
     reset => reset,
     reg_output => tempMux25
);

k0: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(26),
     clk => clk,
     reset => reset,
     reg_output => tempMux26
);
k1: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(27),
     clk => clk,
     reset => reset,
     reg_output => tempMux27
);

gp: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(28),
     clk => clk,
     reset => reset,
     reg_output => tempMux28
);
sp: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(29),
     clk => clk,
     reset => reset,
     reg_output => tempMux29
);
fp: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(30),
     clk => clk,
     reset => reset,
     reg_output => tempMux30
);
ra: register_32b
    port map(
     reg_input => write_data,
     write_enable => tmpDeco(31),
     clk => clk,
     reset => reset,
     reg_output => tempMux31
);

muxA: mux32to1_32b
    port map(
           mux_in0 => tempMux0,
           mux_in1 => tempMux1,
           mux_in2 => tempMux2,
           mux_in3 => tempMux3,
           mux_in4 => tempMux4,
           mux_in5 => tempMux5,
           mux_in6 => tempMux6,
           mux_in7 => tempMux7,
           mux_in8 => tempMux8,
           mux_in9 => tempMux9,
           mux_in10=> tempMux10,
           mux_in11=> tempMux11,
           mux_in12=> tempMux12,
           mux_in13=> tempMux13,
           mux_in14=> tempMux14,
           mux_in15=> tempMux15,
           mux_in16=> tempMux16,
           mux_in17=> tempMux17,
           mux_in18=> tempMux18,
           mux_in19=> tempMux19,
           mux_in20=> tempMux20,
           mux_in21=> tempMux21,
           mux_in22=> tempMux22,
           mux_in23=> tempMux23,
           mux_in24=> tempMux24,
           mux_in25=> tempMux25,
           mux_in26=> tempMux26,
           mux_in27=> tempMux27,
           mux_in28=> tempMux28,
           mux_in29=> tempMux29,
           mux_in30=> tempMux30,
           mux_in31=> tempMux31,
           mux_sel => rs,
           mux_out => read_data1
    );
muxB: mux32to1_32b
    port map(
           mux_in0 => tempMux0,
           mux_in1 => tempMux1,
           mux_in2 => tempMux2,
           mux_in3 => tempMux3,
           mux_in4 => tempMux4,
           mux_in5 => tempMux5,
           mux_in6 => tempMux6,
           mux_in7 => tempMux7,
           mux_in8 => tempMux8,
           mux_in9 => tempMux9,
           mux_in10=> tempMux10,
           mux_in11=> tempMux11,
           mux_in12=> tempMux12,
           mux_in13=> tempMux13,
           mux_in14=> tempMux14,
           mux_in15=> tempMux15,
           mux_in16=> tempMux16,
           mux_in17=> tempMux17,
           mux_in18=> tempMux18,
           mux_in19=> tempMux19,
           mux_in20=> tempMux20,
           mux_in21=> tempMux21,
           mux_in22=> tempMux22,
           mux_in23=> tempMux23,
           mux_in24=> tempMux24,
           mux_in25=> tempMux25,
           mux_in26=> tempMux26,
           mux_in27=> tempMux27,
           mux_in28=> tempMux28,
           mux_in29=> tempMux29,
           mux_in30=> tempMux30,
           mux_in31=> tempMux31,
           mux_sel => rt,
           mux_out => read_data2
    );
  
    with write_register select
        tempDecoEnable <=  "00000000000000000000000000000001" when "00000",
                    "00000000000000000000000000000010" when "00001",
                    "00000000000000000000000000000100" when "00010",
                    "00000000000000000000000000001000" when "00011",
                    "00000000000000000000000000010000" when "00100",
                    "00000000000000000000000000100000" when "00101",
                    "00000000000000000000000001000000" when "00110",
                    "00000000000000000000000010000000" when "00111",
                    "00000000000000000000000100000000" when "01000",
                    "00000000000000000000001000000000" when "01001",
                    "00000000000000000000010000000000" when "01010",
                    "00000000000000000000100000000000" when "01011",
                    "00000000000000000001000000000000" when "01100",
                    "00000000000000000010000000000000" when "01101",
                    "00000000000000000100000000000000" when "01110",
                    "00000000000000001000000000000000" when "01111",
                    "00000000000000010000000000000000" when "10000",
                    "00000000000000100000000000000000" when "10001",
                    "00000000000001000000000000000000" when "10010",
                    "00000000000010000000000000000000" when "10011",
                    "00000000000100000000000000000000" when "10100",
                    "00000000001000000000000000000000" when "10101",
                    "00000000010000000000000000000000" when "10110",
                    "00000000100000000000000000000000" when "10111",
                    "00000001000000000000000000000000" when "11000",
                    "00000010000000000000000000000000" when "11001",
                    "00000100000000000000000000000000" when "11010",
                    "00001000000000000000000000000000" when "11011",
                    "00010000000000000000000000000000" when "11100",
                    "00100000000000000000000000000000" when "11101",
                    "01000000000000000000000000000000" when "11110",
                    "10000000000000000000000000000000" when others;
                    
    process (reg_write, tempDecoEnable)
    begin
        if (reg_write = '0') then
            tmpDeco <= "00000000000000000000000000000000";
        else 
            tmpDeco <= tempDecoEnable;
        end if;
    end process;

end Behavioral;
