
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_arquitecture is
    Port ( registerA : in STD_LOGIC_VECTOR (31 downto 0);
           registerB : in STD_LOGIC_VECTOR (31 downto 0);
           main_func: in STD_LOGIC_VECTOR (5 downto 0);
           main_aluop: in STD_LOGIC_VECTOR (2 downto 0);
           main_out : out STD_LOGIC_VECTOR (31 downto 0);
           main_zero: out STD_LOGIC
           );
end main_arquitecture;

architecture MAIN of main_arquitecture is

component alu
    Port ( alu_in_a : in STD_LOGIC_VECTOR (31 downto 0);
           alu_in_b : in STD_LOGIC_VECTOR (31 downto 0);
           operation: in STD_LOGIC_VECTOR (3 downto 0);
           alu_output : out STD_LOGIC_VECTOR (31 downto 0);
           zero: out STD_LOGIC
           );
end component;

component alu_control
    Port ( func: in STD_LOGIC_VECTOR (5 downto 0);
           alu_op: in STD_LOGIC_VECTOR (2 downto 0);
           control_out: out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

signal tmpAluOperation: STD_LOGIC_VECTOR (3 downto 0);
begin

U_ALUCONTROL : alu_control
port map(
    func => main_func,
    alu_op=>main_aluop,
    control_out => tmpAluOperation
);

U_ALU : alu
port map(
    alu_in_a => registerA,
    alu_in_b => registerB,
    operation => tmpAluOperation,
    alu_output => main_out,
    zero => main_zero
);

end MAIN;
