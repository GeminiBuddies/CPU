library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity memf is
	port(
		clk0: in std_logic;
		nclk0: in std_logic;
		clk_wb: in std_logic;
		nclk_wb: in std_logic;
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		r: in std_logic;
		w: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0)
	);
end memf;

architecture memX of memf is

type DATA_MEM is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal datamem:DATA_MEM:=(x"0000",x"0001",x"0002",x"0003",x"0004",x"0005",x"0006",x"0007",
x"0008",x"0009",x"000A",x"000B",x"000C",x"000D",x"000E",x"000F");

begin
	process(clk0, nclk0, clk_wb, nclk_wb)
	begin
		if clk0 = '1' then
		elsif nclk0 = '1' then
			case pc(5 downto 0) is
				when "000000" =>
					instr <= "0100100111111111";
				when "000001" =>
					instr <= "0100001001100101";
				when "000010" =>
					instr <= "0110001100000000";
				when "000011" =>
					instr <= "1110000110010101";
				when "000100" =>
					instr <= "1110111011101100";
				when "000101" =>
					instr <= "1110101101001010";
				when "000110" =>
					instr <= "0110100101111111";
				when "000111" =>
					instr <= "1001111010000000";
				when "001000" =>
					instr <= "1001011100010000";
				when "001001" =>
					instr <= "0000100000000000";
				when "001010" =>
					instr <= "1111000100000000";
				when "001011" =>
					instr <= "1110101101000000";
				when "001100" =>
					instr <= "1111001000000001";
				when "001101" =>
					instr <= "0110010010000000";
				when "001110" =>
					instr <= "1110110111001101";
				when "001111" =>
					instr <= "0011000101000000";
				when "010000" =>
					instr <= "0011001110010100";
				when "010001" =>
					instr <= "0011010111000011";
				when "010010" =>
					instr <= "0011000101000111";
				when "010011" =>
					instr <= "1110000011101111";
				when "010100" =>
					instr <= "0000100000000000";
				when "010101" =>
					instr <= "0000100000000000";
				when "010110" =>
					instr <= "1101100000110100";
				when "010111" =>
					instr <= "1101001000010100";
				when "011000" =>
					instr <= "0000100000000000";
				when "011001" =>
					instr <= "0000100000000000";
				when "011010" =>
					instr <= "0101010000110010";
				when "011011" =>
					instr <= "0011010111000110";
				when "011100" =>
					instr <= "1110111100000011";
				when "011101" =>
					instr <= "0000100000000000";
				when "011110" =>
					instr <= "0100110100000111";
				when "011111" =>
					instr <= "1110010111011111";
				when "100000" =>
					instr <= "1001110100100001";
				when "100001" =>
					instr <= "0011000111100100";
				when "100010" =>
					instr <= "1110000111011101";
				when "100011" =>
					instr <= "1001111000100000";
				when "100100" =>
					instr <= "0011001000101011";
				when "100101" =>
					instr <= "1110000101001101";
				when "100110" =>
					instr <= "0110110100000000";
				when "100111" =>
					instr <= "0010101111111101";
				when "101000" =>
					instr <= "0100100111111111"; 
				when "101001" =>
					instr <= "0001000000000100";
				when "101010" =>
					instr <= "0110100100110000";
				when "101011" =>
					instr <= "0100100100000001";
				when "101100" =>
					instr <= "0010000000000101";
				when "101101" =>
					instr <= "0110110000110101";
				when "101110" =>
					instr <= "1110100100000000";
				when "101111" =>
					instr <= "1110100010101010";
				when "110000" =>
					instr <= "0110000011111011";
				when "110001" =>
					instr <= "0000100000000000";
				when "110010" =>
					instr <= "1110110011000000";
				when "110011" =>
					instr <= "0110111000000110";
				when "110100" =>
					instr <= "1101100010000100";
				when "110101" =>
					instr <= "1110100000100000";
				when "110110" =>
					instr <= "0000100000000000";
				when others =>
					instr <= "0000100000000000";
			end case;
		elsif clk_wb = '1' then
		elsif nclk_wb = '1' then
			if r = '1' then
				odata <= datamem(CONV_INTEGER(addr(3 downto 0)));
			elsif w = '1' then
				datamem(CONV_INTEGER(addr(3 downto 0))) <= idata;
			end if;
		end if;
	end process;
end memX;
