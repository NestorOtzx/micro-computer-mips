library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
  Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        opcode: in STD_LOGIC_VECTOR (5 downto 0);
        
        pc_write: out STD_LOGIC;
        branch: out STD_LOGIC;
        iord: out STD_LOGIC;
        mem_read: out STD_LOGIC;
        mem_write: out STD_LOGIC;
        ir_write: out STD_LOGIC;
        reg_dst: out STD_LOGIC_VECTOR(1 downto 0);
        memtoreg: out STD_LOGIC_VECTOR(1 downto 0);
        reg_write: out STD_LOGIC;
        alusrca: out STD_LOGIC;
        alusrcb: out STD_LOGIC_VECTOR (1 downto 0);
        aluop: out STD_LOGIC_VECTOR (2 downto 0);
        pcsrc: out STD_LOGIC_VECTOR (1 downto 0)
   );
end control;

architecture Behavioral of control is

type control_state is (fetch, decode, write_in_reg --basicos
                      , beq, j, jal, addi, andi, lui, ori, slti  --inmediatos
                      , sw, lw, address_computation, write_lw_register--memoria
                      , r_type, write_in_reg_r
                      );

signal state : control_state := fetch;

begin

process(clk) is
begin
    if(rising_edge(clk)) then
        if (reset = '1') then
            pc_write <= '1';
            branch <= '0';
            iord <= '0';
            mem_read <= '1';
            mem_write <= '0';
            ir_write <= '1';
            reg_dst <= "00";
            memtoreg <= "00";
            reg_write <= '0';
            alusrca <= '0';
            alusrcb <= "01";
            aluop <= "000";
            pcsrc <= "00";
            state <= decode;
            state <= fetch;
        else
            case state is
--PRINCIPALES
                when fetch =>               
                    pc_write <= '1';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '1';
                    mem_write <= '0';
                    ir_write <= '1';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '0';
                    alusrcb <= "01";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= decode;
                when decode =>              
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '0';
                    alusrcb <= "11";
                    aluop <= "000";
                    pcsrc <= "00";
                    
                    if opcode = "001000" then --inmediatos
                        state <= addi;
                    elsif opcode = "001100" then
                        state <= andi;
                    elsif opcode = "001111" then
                        state <= lui;
                    elsif opcode = "001101" then
                        state <= ori;
                    elsif opcode = "001010" then
                        state <= slti;
                    elsif opcode = "000100" then
                        state <= beq;
                    elsif opcode = "000010" then
                        state <= j;
                    elsif opcode = "000011" then
                        state <= jal;
                    elsif opcode = "101011" then --sw
                        state <= address_computation;  
                    elsif opcode = "100011" then --lw
                        state <= address_computation;  
                    elsif opcode = "000000" then --TIPO R
                        state <= r_type;
                    end if;    
 --INMEDIATAS
                when j =>
                    pc_write <= '1';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "10";
                    state <= fetch;
                when jal =>
                    pc_write <= '1';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "10";
                    memtoreg <= "10";
                    reg_write <= '1';
                    alusrca <= '0';
                    alusrcb <= "10";
                    aluop <= "000";
                    pcsrc <= "10";
                    state <= fetch;
                when beq =>
                    pc_write <= '0';
                    branch <= '1';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "00";
                    aluop <= "001";
                    pcsrc <= "01";
                    state <= fetch;
                when addi =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= write_in_reg;
                when andi =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "100";
                    pcsrc <= "00";
                    state <= write_in_reg;
                when lui =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= write_in_reg;
                when ori =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "011";
                    pcsrc <= "00";
                    state <= write_in_reg;
                when slti =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "101";
                    pcsrc <= "00";
                    state <= write_in_reg;
                when write_in_reg =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '1';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= fetch;
-- MEMORIA , sw, lw, address_computation, write_lw_register
                 when address_computation =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "10";
                    aluop <= "000";
                    pcsrc <= "00";
                    
                    if (opcode = "101011") then --sw
                        state <= sw;
                    else 
                        state <= lw;
                    end if;
                when sw =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '1';
                    mem_read <= '0';
                    mem_write <= '1';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= fetch;
                when lw =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '1';
                    mem_read <= '1';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= write_lw_register;
                when write_lw_register =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "01";
                    reg_write <= '1';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= fetch;
-- TIPO R , r_type, write_in_reg_r
                 when r_type =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "01";
                    memtoreg <= "00";
                    reg_write <= '0';
                    alusrca <= '1';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= write_in_reg_r;
                when write_in_reg_r =>
                    pc_write <= '0';
                    branch <= '0';
                    iord <= '0';
                    mem_read <= '0';
                    mem_write <= '0';
                    ir_write <= '0';
                    reg_dst <= "00";
                    memtoreg <= "00";
                    reg_write <= '1';
                    alusrca <= '0';
                    alusrcb <= "00";
                    aluop <= "000";
                    pcsrc <= "00";
                    state <= fetch;      
             end case;
        end if;
    end if;
end process;

end Behavioral;
