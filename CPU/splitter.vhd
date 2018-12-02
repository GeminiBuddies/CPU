library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity splitter is
	port(
		clk, rst: in std_logic;
		clk0, clk1, clk2, clk3: out std_logic;
		nclk0, nclk1, nclk2, nclk3: out std_logic
	);
end splitter;

architecture splitterX of splitter is
	type state_type is (STATE_0, STATE_1, STATE_2, STATE_3);
	signal state: state_type := STATE_0;
	signal nstate: state_type := STATE_0;
	signal opt0: std_logic := '0';
	signal opt1: std_logic := '0';
	signal opt2: std_logic := '0';
	signal opt3: std_logic := '0';
	signal nopt0: std_logic := '0';
	signal nopt1: std_logic := '0';
	signal nopt2: std_logic := '0';
	signal nopt3: std_logic := '1';

begin
	clk0 <= opt0 and nopt3 and rst;
	nclk0 <= opt0 and nopt0 and rst;
	clk1 <= opt1 and nopt0 and rst;
	nclk1 <= opt1 and nopt1 and rst;
	clk2 <= opt2 and nopt1 and rst;
	nclk2 <= opt2 and nopt2 and rst;
	clk3 <= opt3 and nopt2 and rst;
	nclk3 <= opt3 and nopt3 and rst;

	process(rst, clk)
	begin
		if rst = '0' then
			opt0 <= '0';
			opt1 <= '0';
			opt2 <= '0';
			opt3 <= '0';
			state <= STATE_0;
		elsif rising_edge(clk) then
			case state is
				when STATE_0 =>
					opt0 <= '1';
					opt1 <= '0';
					opt2 <= '0';
					opt3 <= '0';
					state <= STATE_1;
				when STATE_1 =>
					opt0 <= '0';
					opt1 <= '1';
					opt2 <= '0';
					opt3 <= '0';
					state <= STATE_2;
				when STATE_2 =>
					opt0 <= '0';
					opt1 <= '0';
					opt2 <= '1';
					opt3 <= '0';
					state <= STATE_3;
				when STATE_3 =>
					opt0 <= '0';
					opt1 <= '0';
					opt2 <= '0';
					opt3 <= '1';
					state <= STATE_0;
			end case;
		end if;
	end process;

	process(rst, clk)
	begin
		if rst = '0' then
			nopt0 <= '0';
			nopt1 <= '0';
			nopt2 <= '0';
			nopt3 <= '1';
			nstate <= STATE_0;
		elsif falling_edge(clk) then
			case nstate is
				when STATE_0 =>
					nopt0 <= '1';
					nopt1 <= '0';
					nopt2 <= '0';
					nopt3 <= '0';
					nstate <= STATE_1;
				when STATE_1 =>
					nopt0 <= '0';
					nopt1 <= '1';
					nopt2 <= '0';
					nopt3 <= '0';
					nstate <= STATE_2;
				when STATE_2 =>
					nopt0 <= '0';
					nopt1 <= '0';
					nopt2 <= '1';
					nopt3 <= '0';
					nstate <= STATE_3;
				when STATE_3 =>
					nopt0 <= '0';
					nopt1 <= '0';
					nopt2 <= '0';
					nopt3 <= '1';
					nstate <= STATE_0;
			end case;
		end if;
	end process;
end splitterX;
