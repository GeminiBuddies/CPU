library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity memtest is
	port(
		clk: in std_logic;
		ram_addr: out std_logic_vector(17 downto 0);
		ram_data: inout std_logic_vector(15 downto 0);
		ram_en: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
		wrn: out std_logic;
		tbre: in std_logic;
		tsre: in std_logic;
		rdn: out std_logic;
		data_ready: in std_logic;
		lcd: out std_logic_vector(15 downto 0);
		smg: out std_logic_vector(6 downto 0);
		rst: in std_logic
	);
end memtest;

architecture memtestX of memtest is
	signal clk0: std_logic;
	signal nclk0: std_logic;
	signal clk_wb: std_logic;
	signal nclk_wb: std_logic;
	signal rw: std_logic;
	signal addr: std_logic_vector(15 downto 0);
	signal idata: std_logic_vector(15 downto 0);
	signal odata: std_logic_vector(15 downto 0);
	signal instr: std_logic_vector(15 downto 0);
	signal tempdata: std_logic_vector(15 downto 0);
	
	component mem is
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
			rw: in std_logic; -- r = 0, w = 1
			addr: in std_logic_vector(15 downto 0);
			idata: in std_logic_vector(15 downto 0);
			odata: out std_logic_vector(15 downto 0);
			wrn: out std_logic;
			tbre: in std_logic;
			tsre: in std_logic;
			rdn: out std_logic;
			data_ready: in std_logic
		);
	end component;
	
	signal status: integer := 0;
	
begin
	m : mem port map (
		clk0 => clk0,
		nclk0 => nclk0,
		clk_wb => clk_wb,
		nclk_wb => nclk_wb,
		ram_addr => ram_addr,
		ram_data => ram_data,
		ram_en => ram_en,
		ram_oe => ram_oe,
		ram_we => ram_we,
		pc => addr,
		instr => instr,
		rw => rw,
		addr => addr,
		idata => idata,
		odata => odata,
		wrn => wrn,
		tbre => tbre,
		tsre => tsre,
		rdn => rdn,
		data_ready => data_ready
	);
	
	process(rst, clk)
	begin
		if rst = '0' then
			status <= 0;
			lcd <= (others => '0');
			smg <= (others => '0');
			addr <= (others => '0');
			clk0 <= '0';
			nclk0 <= '0';
			clk_wb <= '0';
			nclk_wb <= '0';
			tempdata <= (others => '0');
		elsif falling_edge(clk) then
			case status is
				when 0 =>
					lcd <= "1100000000000000";
					smg <= "0111111";
					addr <= "1011111100000001";
					rw <= '0';
					clk_wb <= '1';
					status <= 1;
				when 1 =>
					smg <= "0000110";
					lcd <= "0000110000000000";
					clk_wb <= '0';
					nclk_wb <= '1';
					status <= 2;
				when 2 =>
					smg <= "1011011";
					nclk_wb <= '0';
					lcd <= odata;
					if odata(1) = '1' then
						addr <= "1011111100000000";
						rw <= '0';
						clk_wb <= '1';
						status <= 3;
					else
						status <= 0;
					end if;
				when 3 =>
					smg <= "1001111";
					clk_wb <= '0';
					nclk_wb <= '1';
					status <= 4;
				when 4 =>
					smg <= "1100110";
					nclk_wb <= '0';
					lcd <= odata;
					idata <= odata;
					addr <= "0000000000000000";
					rw <= '1';
					clk_wb <= '1';
					status <= 5;
				when 5 =>
					smg <= "1101101";
					clk_wb <= '0';
					nclk_wb <= '1';
					status <= 6;
				when 6 =>
					smg <= "1111101";
					nclk_wb <= '0';
					addr <= "0000000000000000";
					rw <= '0';
					clk0 <= '1';
					status <= 7;
				when 7 =>
					smg <= "0000111";
					clk0 <= '0';
					nclk0 <= '1';
					status <= 8;
				when 8 =>
					smg <= "1111111";
					nclk0 <= '0';
					lcd <= instr;
					tempdata <= instr;
					status <= 9;
				when 9 =>
					smg <= "1101111";
					addr <= "1011111100000001";
					rw <= '0';
					clk_wb <= '1';
					status <= 10;
				when 10 =>
					smg <= "1110111";
					clk_wb <= '0';
					nclk_wb <= '1';
					status <= 11;
				when 11 =>
					smg <= "1111100";
					nclk_wb <= '0';
					lcd <= odata;
					if odata(0) = '1' then
						addr <= "1011111100000000";
						rw <= '1';
						idata <= tempdata;
						clk_wb <= '1';
						status <= 12;
					else
						status <= 9;
					end if;
				when 12 =>
					smg <= "0111001";
					lcd <= tempdata;
					clk_wb <= '0';
					nclk_wb <= '1';
					status <= 13;
				when 13 =>
					smg <= "1011110";
					nclk_wb <= '0';
					status <= 0;
				when others =>
			end case;
		end if;
	end process;

end memtestX;

