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
    signal opt0, opt1, opt2, opt3: std_logic;
begin
    clk0 <= opt0 and clk;
	 nclk0 <= opt0 and not clk;
    clk1 <= opt1 and clk;
	 nclk1 <= opt1 and not clk;
    clk2 <= opt2 and clk;
	 nclk2 <= opt2 and not clk;
    clk3 <= opt3 and clk;
	 nclk3 <= opt3 and not clk;

    process(rst, clk)
    begin
        if rst = '0' then
            opt0 <= '0';
            opt1 <= '0';
            opt2 <= '0';
            opt3 <= '0';
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
end splitterX;
