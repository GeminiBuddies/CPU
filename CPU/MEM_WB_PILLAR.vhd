library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MEM_WB_PILLAR is
    port(
        mem_or_alu_in: in std_logic;
        write_reg_in: in std_logic;
        reg_dst_in: std_logic_vector(3 downto 0);
        mem_data_in: in std_logic_vector(15 downto 0);
        alu_data_in: in std_logic_vector(15 downto 0);
        mem_or_alu_out: out std_logic;
        write_reg_out: out std_logic;
        reg_dst_out: out std_logic_vector(3 downto 0);
        mem_data_out: out std_logic_vector(15 downto 0);
        alu_data_out: out std_logic_vector(15 downto 0);
        clk: in std_logic
    );
end MEM_WB_PILLAR;

architecture MEM_WB_PILLARX of MEM_WB_PILLAR is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            mem_or_alu_out <= mem_or_alu_in;
            write_reg_out <= write_reg_in;
            reg_dst_out <= reg_dst_in;
            mem_data_out <= mem_data_in;
            alu_data_out <= alu_data_in;
        end if;
    end process;
end MEM_WB_PILLARX;
