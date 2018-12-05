----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:26 12/05/2018 
-- Design Name: 
-- Module Name:    fucker - faker 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fucker is
	port(
		iclk: in std_logic;
		oclk: out std_logic := '0'
	);
end fucker;

architecture faker of fucker is
	signal s: integer := 0;
	signal clk: std_logic := '0';
begin
	oclk <= clk;
	
	process(iclk)
	begin
		if rising_edge(iclk) then
			if s = 1000000 then
				clk <= not clk;
				s <= 0;
			else
				s <= s + 1;
			end if;
		end if;
	end process;

end faker;
