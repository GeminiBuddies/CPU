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
		ram_addr: out std_logic_vector(17 downto 0);
		ram_data: inout std_logic_vector(15 downto 0);
		ram_en: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		r: in std_logic;
		w: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0);
		wrn: out std_logic;
		tbre: in std_logic;
		tsre: in std_logic;
		rdn: out std_logic;
		data_ready: in std_logic
	);
end mem;

architecture memX of mem is
begin
	process(clk0, nclk0, clk_wb, nclk_wb)
	begin
		if clk0 = '1' then
			ram_en <= '0';
			ram_we <= '1';
			ram_oe <= '0';
			wrn <= '1';
			rdn <= '1';
			ram_data <= "ZZZZZZZZZZZZZZZZ";
			ram_addr <= "00" & pc;
		elsif nclk0 = '1' then
			ram_en <= '0';
			ram_oe <= '1';
			ram_we <= '1';
			wrn <= '1';
			rdn <= '1';
			instr <= ram_data;
		elsif clk_wb = '1' then
			if addr(15 downto 0) = "1011111100000000" then
				ram_en <= '1';
				ram_oe <= '1';
				ram_we <= '1';
				if w = '1' then
					ram_data <= idata;
					wrn <= '0';
					rdn <= '1';
				elsif r = '1' then
					ram_data <= "ZZZZZZZZZZZZZZZZ";
					rdn <= '0';
					wrn <= '1';
				end if;
			elsif addr(15 downto 0) = "1011111100000001" then
				ram_en <= '1';
				ram_oe <= '1';
				ram_we <= '1';
				wrn <= '1';
				rdn <= '1';
			else
				ram_en <= '0';
				wrn <= '1';
				rdn <= '1';
				if r = '1' then
					ram_we <= '1';
					ram_oe <= '0';
					ram_addr <= "00" & addr;
				elsif w = '1' then
					ram_we <= '0';
					ram_oe <= '1';
					ram_addr <= "00" & addr;
					ram_data <= idata;
				end if;
			end if;
		elsif nclk_wb = '1' then
			ram_en <= '1';
			ram_oe <= '1';
			ram_we <= '1';
			rdn <= '1';
			wrn <= '1';
				
			if addr(15 downto 0) = "1011111100000000" then
				if r = '1' then
					odata <= ram_data;
				end if;
			elsif addr(15 downto 0) = "1011111100000001" then
				if r = '1' then
					odata <= "00000000000000" & data_ready & tsre;
				end if;
			else
				if r = '1' then
					odata <= ram_data;
				end if;
			end if;
		end if;
	end process;
end memX;
