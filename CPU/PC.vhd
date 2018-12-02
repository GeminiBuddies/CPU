----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:41 12/01/2018 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
	port(
		clk : in STD_LOGIC;
		PCKeep : in STD_LOGIC;
		PCIn : in STD_LOGIC_VECTOR(15 downto 0);
		PCOut : out STD_LOGIC_VECTOR(15 downto 0) :=x"0000"
	);
end PC;

architecture Behavioral of PC is

begin

process(clk)
begin
	if falling_edge(clk) then
		if PCKeep = '0' then
			PCOut <= PCIn;
		end if;
	end if;

end process;

end Behavioral;

