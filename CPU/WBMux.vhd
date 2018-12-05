library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity WBMux is
	port(
		output: out std_logic_vector(15 downto 0);
		memdata: in std_logic_vector(15 downto 0);
		aludata: in std_logic_vector(15 downto 0);
		mem_or_alu: in std_logic -- '1' = mem
	);
end WBMux;

architecture WBMuxX of WBMux is
begin
	process(memdata, aludata, mem_or_alu)
	begin
		if mem_or_alu = '1' then
			output <= memdata;
		else
			output <= aludata;
		end if;
	end process;
end WBMuxX;

