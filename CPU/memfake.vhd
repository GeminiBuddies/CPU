library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mem is
	port(
		clk0: in std_logic;
		nclk0: in std_logic;
		clk_wb: in std_logic;
		nclk_wb: in std_logic;
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
			case pc(4 downto 0) is
				when "00000" =>
					instr <= "0100100111111111";
				when "00001" =>
					instr <= "0100001001100101";
				when "00010" =>
					instr <= "0110001100000000";
				when "00011" =>
					instr <= "1110000110010101";
				when "00100" =>
					instr <= "1110111011101100";
				when "00101" =>
					instr <= "1110101101001010";
				when "00110" =>
					instr <= "0110100101111111";
				when "00111" =>
					instr <= "1001111010000000";
				when "01000" =>
					instr <= "1001011100010000";
				when "01001" =>
					instr <= "0000100000000000";
				when "01010" =>
					instr <= "1111000100000000";
				when "01011" =>
					instr <= "1110101101000000";
				when "01100" =>
					instr <= "1111001000000001";
				when "01101" =>
					instr <= "0110010010000000";
				when "01110" =>
					instr <= "1110110111001101";
				when "01111" =>
					instr <= "0011000101000000";
				when "10000" =>
					instr <= "0011001110010100";
				when "10001" =>
					instr <= "0011010111000011";
				when "10010" =>
					instr <= "0011000101000111";
				when "10011" =>
					instr <= "1110000011101111";
				when "10100" =>
					instr <= "0000100000000000";
				when "10101" =>
					instr <= "0000100000000000";
				when "10110" =>
					instr <= "1101100000110100";
				when "10111" =>
					instr <= "1101001000010100";
				when "11000" =>
					instr <= "1110101111000000";
				when "11001" =>
					instr <= "1110100000100000";
				when "11010" =>
					instr <= "0101010000110010";
				when "11011" =>
					instr <= "0011010111001110";
				when "11100" =>
					instr <= "1110111100000011";
			end case;
		elsif clk_wb = '1' then
		elsif nclk_wb = '1' then
			odata <= "0000100000000000";
		end if;
	end process;
end memX;
