library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           opcode : in STD_LOGIC_VECTOR (5 downto 0);
           func : in STD_LOGIC_VECTOR (5 downto 0);
           irWrite : out STD_LOGIC;
           memToReg : out std_logic_vector(1 downto 0);
           memWrite : out STD_LOGIC;
           memRead : out STD_LOGIC;
           IorD : out STD_LOGIC;
           pcWrite : out STD_LOGIC;
           branch : out STD_LOGIC;
           pcSrc : out STD_LOGIC_VECTOR (1 downto 0);
           aluOP : out STD_LOGIC_VECTOR (2 downto 0);
           aluSrcB : out STD_LOGIC_VECTOR (1 downto 0);
           aluSrcA : out STD_LOGIC;
           regWrite : out STD_LOGIC;
           regDst : out std_logic_vector(1 downto 0)
           );
end control;

architecture Behavioral of control is
    type stateType is (reset_st, fetch, decode, memAddr, memReadST, memWB,memWriteST,
                        execute, aluWB, branchST, jumpST, jalST, jrST, addiST, luiST, oriST, writeRegistersST,
                        addiuST, andiST, sltiST, sltiuST);
signal currentState, nextState : std_logic_vector (3 downto 0);
signal estadoActual, estadoSiguiente : stateType;


begin
    stateRegister: process (clock, reset)
    begin 
        if (reset = '1') then
            estadoActual <= reset_st;
        else
            if (clock'event and clock ='1') then
                estadoActual <= estadoSiguiente;
            end if;
        end if;
    end process;
    
    nextStateFunction: process(opcode, func, estadoActual)
    begin
         case (estadoActual) is
              when reset_st => 
                 estadoSiguiente <= fetch;
              when addiST =>
                 estadoSiguiente<= writeRegistersST;
              when fetch =>
                 estadoSiguiente <= decode;
              when decode =>
                 case (opcode) is
                    when "100011" =>
                        estadoSiguiente <= memAddr;
                    when "101011" =>
                        estadoSiguiente <= memAddr;
                    when "000000" =>
                        if (func = "001000") then
                            estadoSiguiente <= jrST;
                        else
                            estadoSiguiente <= execute;
                        end if;
                    when "000100" =>
                        estadoSiguiente <= branchST;
                    when "000010" =>
                        estadoSiguiente <= jumpST;
                    when "000011" =>
                        estadoSiguiente <= jalST;
                    when "001000"=>
                        estadoSiguiente <= addiST;
                    when "001001"=>
                        estadoSiguiente <= addiuST;
                    when "001100"=>
                        estadoSiguiente <= andiST;
                    when "001010"=>
                        estadoSiguiente <= sltiST;
                    when "001011"=>
                        estadoSiguiente <= sltiuST;
                    when "001111" => 
                        estadoSiguiente <= luiST;
                    when "001101" =>
                        estadoSiguiente <= oriST;
                    when others =>
                        estadoSiguiente <= fetch;
                    end case;
              when memAddr =>
                 if (opcode = "100011") then
                    estadoSiguiente <= memReadST;
                 else
                    estadoSiguiente <= memWriteST;
                 end if;
              when memReadST =>
                 estadoSiguiente <= memWB;
              when memWB =>
                 estadoSiguiente <= fetch;
              when memWriteST =>
                 estadoSiguiente <= fetch;
              when execute =>
                 estadoSiguiente <= aluWB;
              when aluWB =>
                 estadoSiguiente <= fetch;
              when branchST =>
                 estadoSiguiente <= fetch;
              when jumpST =>
                 estadoSiguiente <= fetch;
              when jalST =>
                 estadoSiguiente <= fetch;
              when writeRegistersST =>
                   estadoSiguiente <= fetch;
              when luiST =>
                   estadoSiguiente <= fetch;
              when oriST =>
                   estadoSiguiente <= writeRegistersST;
              when addiuST =>
                   estadoSiguiente <= writeRegistersST;
              when andiST =>
                   estadoSiguiente <= writeRegistersST;
              when sltiST =>
                   estadoSiguiente <= writeRegistersST;
              when sltiuST =>
                   estadoSiguiente <= writeRegistersST;
              when others =>
                 estadoSiguiente <= fetch;
           end case;    
    end process;

    
    outputsFunction: process(estadoActual)
    begin
         case (estadoActual) is
              when addiST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "10";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when writeRegistersST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '1';
                   regDst  <= "00";                               
              when fetch =>
                   irWrite <= '1';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '1';
                   IorD <= '0';
                   pcWrite <= '1';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "01";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";                
              when decode =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "10";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";
              when memAddr =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "10";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";   
              when memReadST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '1';
                   IorD <= '1';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";   
              when memWB =>
                   irWrite <= '0';
                   memToReg <= "01";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '1';
                   regDst  <= "00";
              when memWriteST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '1';
                   memRead <= '0';
                   IorD <= '1';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";
              when execute =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "010";
                   aluSrcB <= "00";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when aluWB =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '1';
                   regDst  <= "01";
              when branchST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '1';
                   pcSrc <= "01";
                   aluOP <= "001";
                   aluSrcB <= "00";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when jumpST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '1';
                   branch <= '0';
                   pcSrc <= "10";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";
              when jalST =>
                   irWrite <= '0';
                   memToReg <= "10";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '1';
                   branch <= '0';
                   pcSrc <= "10";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '1';
                   regDst  <= "10";
              when jrST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '1';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when luiST =>
                   irWrite <= '0';
                   memToReg <= "11";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '1';
                   regDst  <= "00";
              when oriST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "011";
                   aluSrcB <= "11";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when addiuST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "11";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when andiST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "100";
                   aluSrcB <= "10";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when sltiST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "101";
                   aluSrcB <= "10";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when sltiuST =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "101";
                   aluSrcB <= "11";
                   aluSrcA <= '1';
                   regWrite <= '0';
                   regDst  <= "00";
              when others =>
                   irWrite <= '0';
                   memToReg <= "00";
                   memWrite <= '0';
                   memRead <= '0';
                   IorD <= '0';
                   pcWrite <= '0';
                   branch <= '0';
                   pcSrc <= "00";
                   aluOP <= "000";
                   aluSrcB <= "00";
                   aluSrcA <= '0';
                   regWrite <= '0';
                   regDst  <= "00";
           end case;    
    end process;
end Behavioral;
