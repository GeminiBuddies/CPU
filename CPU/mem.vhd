library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mem is
	port(
		-- clock
		clk: in std_logic;

		-- clocks output
		clk0: out std_logic := '0';
		clk1: out std_logic := '0';
		
		-- ram and serial bus
		ram_addr: out std_logic_vector(17 downto 0) := (others => '0');
		ram_data: inout std_logic_vector(15 downto 0);
		ram_en: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
		wrn: out std_logic;
		tbre: in std_logic;
		tsre: in std_logic;
		rdn: out std_logic;
		data_ready: in std_logic;
		
		-- flash bus
		flash_byte: out std_logic; --操作模式，采用字模式
		flash_vpen: out std_logic; --写保护，置为1
		flash_ce: out std_logic; --使能信号,该模块只负责flash的读，故ce置为0即可 
		flash_oe: out std_logic; --读使�
		flash_we: out std_logic; --写使�
		flash_rp: out std_logic; --工作模式�为工�
		flash_addr: out std_logic_vector(22 downto 1); --flash内存地址
		flash_data: inout std_logic_vector(15 downto 0);
			
		-- debug output
--		lcd: out std_logic_vector(15 downto 0);
		
		-- interface
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		r: in std_logic;
		w: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0)
	);
end mem;

architecture memX of mem is
	type STATUS_T is ( S_START, S_FLASH, S_FLASH_NOP0, S_FLASH_NOP1, S_IF_B, S_IF_E, S_MEM_B, S_MEM_E );

	signal status: STATUS_T := S_IF_B;

	component FLASH
		port(
			address		: in std_logic_vector(22 downto 1); --
			dataout		: out std_logic_vector(15 downto 0); --flash
			flash_read 	: in  std_logic; --flash
			clk			: in std_logic; --
			reset			: in std_logic;
			
			flash_byte 	: out std_logic := '1'; --
			flash_vpen	: out std_logic := '1'; --1
			flash_ce		: out std_logic := '0'; --,flashce0 
			flash_oe		: out std_logic := '1'; --
			flash_we		: out std_logic := '1'; --
			flash_rp		: out std_logic := '1'; --1
			flash_addr	: out std_logic_vector(22 downto 1); --flash
			flash_data	: inout std_logic_vector(15 downto 0) --flash
		);
	end component;
	
	signal flif_addr: std_logic_vector(22 downto 1);
	signal flif_data: std_logic_vector(15 downto 0);
	signal flif_read: std_logic;
	signal flif_clk: std_logic;
	signal flif_rst: std_logic;
	signal flash_counter: std_logic_vector(22 downto 1);
	signal flash_waiter: std_logic_vector(7 downto 0) := x"FF";
	

begin
	f : FLASH port map(
		address => flif_addr,
		dataout => flif_data,
		flash_read => flif_read,
		clk => flif_clk,
		reset => flif_rst,
		
		flash_byte => flash_byte,
		flash_vpen => flash_vpen,
		flash_ce => flash_ce,
		flash_oe => flash_oe,
		flash_we => flash_we,
		flash_rp => flash_rp,
		flash_addr => flash_addr,
		flash_data => flash_data
	);
	
	with status select flif_clk <= clk when S_FLASH, '0' when others;
	flif_rst <= '1';

--	lcd <= flash_counter(12 downto 1) & flash_waiter(3 downto 0);

	process(clk)
	begin
		if rising_edge(clk) then
			case status is
				when S_START =>
					ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
					wrn <= '1'; rdn <= '1';

					clk0 <= '0'; clk1 <= '0';

					flash_counter <= (others => '0');
					flash_waiter <= x"00";
					flif_addr <= (others => '0');
					flif_read <= '1';
					status <= S_FLASH;
				when S_FLASH =>
					case flash_waiter is
						when x"00" =>
							flif_read <= '0';
							flif_addr <= flash_counter;
							flash_waiter <= x"01";

							status <= S_FLASH_NOP0;
						when x"06" =>
							flif_read <= '1';
							
							ram_en <= '0'; ram_oe <= '1'; ram_we <= '0';
							
							ram_addr <= flash_counter(18 downto 1);
							ram_data <= flif_data;
							
							flash_waiter <= x"07";

							status <= S_FLASH_NOP0;
						when x"07" =>
							ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
							
							flash_counter <= flash_counter + 1;
							if flash_counter >= x"0FFF" then
							-- if flash_counter >= x"0007" then
								status <= S_IF_B;
							else
								status <= S_FLASH_NOP0;
							end if;
							
							flash_waiter <= x"00";
						when others =>
							status <= S_FLASH_NOP0;
							flash_waiter <= flash_waiter + 1;
					end case;
				when S_FLASH_NOP0 =>
					status <= S_FLASH_NOP1;
				when S_FLASH_NOP1 =>
					status <= S_FLASH;
				when S_IF_B =>
					ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
					wrn <= '1'; rdn <= '1';
					clk0 <= '1'; clk1 <= '0';
					
					status <= S_IF_E;
				when S_IF_E =>
					ram_en <= '0'; ram_oe <= '0'; ram_we <= '1';
					wrn <= '1'; rdn <= '1';
					clk0 <= '0'; clk1 <= '0';

					ram_addr <= "00" & pc;
					ram_data <= (others => 'Z');

					status <= S_MEM_B;
				when S_MEM_B =>
					ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
					wrn <= '1'; rdn <= '1';
					clk0 <= '0'; clk1 <= '1';

					status <= S_MEM_E;
				when S_MEM_E =>
					clk0 <= '0'; clk1 <= '0';
					
					if addr = x"BF00" then
						ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
						if w = '1' then
							ram_data <= idata;
							wrn <= '0'; rdn <= '1';
						elsif r = '1' then
							ram_data <= (others => 'Z');
							wrn <= '1'; rdn <= '0';
						end if;
					elsif addr = x"BF01" then
						ram_en <= '1'; ram_oe <= '1'; ram_we <= '1';
						wrn <= '1'; rdn <= '1';
					else
						ram_en <= '0';
						wrn <= '1'; rdn <= '1';

						ram_addr <= "00" & addr;
						if w = '1' then
							ram_oe <= '1'; ram_we <= '0';
							ram_data <= idata;
						elsif r = '1' then
							ram_oe <= '0'; ram_we <= '1';
							ram_data <= (others => 'Z');
						end if;
					end if;

					status <= S_IF_B;
			end case;
		end if;
	end process;

	process(clk)
	begin
		if falling_edge(clk) then
			if status = S_MEM_B then
				instr <= ram_data;
			elsif status = S_IF_B then
				if addr = x"BF00" then
					if r = '1' then
						odata <= ram_data;
					end if;
				elsif addr = x"BF01" then
					if r = '1' then
						odata <= (0 => tsre and tbre, 1 => data_ready, 2 => tbre, others => '0');
						--odata <= (0 => '1', 1 => data_ready, others => '0');
					end if;
				else
					if r = '1' then
						odata <= ram_data;
					end if;
				end if;
			end if;	
		end if;
	end process;
end memX;
