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
		ram_addr: out std_logic_vector(15 downto 0);
		ram_data: inout std_logic_vector(15 downto 0);
		ram_en: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
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
		ram_en <= '0';
		if clk0 = '1' then
			ram_we <= '1';
			ram_oe <= '0';
			ram_addr <= pc;
		elsif nclk0 = '1' then
			instr <= ram_data;
			ram_oe <= '1';
		elsif clk_wb = '1' then
			if rw = '0' then
				ram_we <= '1';
				ram_oe <= '0';
				ram_addr <= addr;
			else
				ram_we <= '0';
				ram_oe <= '1';
				ram_addr <= addr;
				ram_data <= idata;
			end if;
		elsif nclk_wb = '1' then
			ram_we <= '1';
			ram_oe <= '1';
			odata <= ram_data;
		end if;
	end process;
end memX;
