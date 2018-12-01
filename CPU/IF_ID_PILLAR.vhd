----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:32:30 11/30/2018 
-- Design Name: 
-- Module Name:    IF_ID_PILLAR - Behavioral 
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

entity IF_ID_PILLAR is
	port(
		clk : in STD_LOGIC;
		IFIDKeep : in STD_LOGIC;
		IFIDFlush : in STD_LOGIC;
		PCIn : in STD_LOGIC_VECTOR(15 downto 0);
		PCOut : out STD_LOGIC_VECTOR(15 downto 0);
		InstructionOut : out STD_LOGIC_VECTOR(15 downto 0);
		InstructionIn	: in STD_LOGIC_VECTOR(15 downto 0)
	);

end IF_ID_PILLAR;

architecture Behavioral of IF_ID_PILLAR is
	
begin

process(clk)
begin
	if rising_edge(clk) then
		if IFIDFlush = '1' then
			InstructionOut <= x"0800";
		elsif IFIDKeep = '0' then
			InstructionOut <= InstructionIn;
			PCOut <= PCIn;
		end if;
	end if;
end process;

end Behavioral;

