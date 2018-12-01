library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mem is
	port(
		clk0: in std_logic;
		nclk0: in std_logic;
		clk_wb: in std_logic;
		nclk_wb: in std_logic
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		rw: in std_logic; -- r = 0, w = 1
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0)
	);
end mem;

architecture memX of mem is
begin
	process(clk0, nclk0, clk_wb, nclk_wb)
	begin
		if clk0 = '1' then
		elsif nclk0 = '1' then
			instr <= "0000100000000000";
		elsif clk_wb = '1' then
		elsif nclk_wb = '1' then
			odata <= "0000100000000000";
		end if;
	end process;
end memX;
