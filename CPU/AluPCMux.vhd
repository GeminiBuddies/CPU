----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:59:31 12/03/2018 
-- Design Name: 
-- Module Name:    AluPCMux - Behavioral 
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

entity AluPCMux is
	port(
	UsePC : in STD_LOGIC;
	PC : in STD_LOGIC_VECTOR(15 downto 0);
	ForwardAData : in STD_LOGIC_VECTOR(15 downto 0);
	AluSrc1 : out STD_LOGIC_VECTOR(15 downto 0)
	);
end AluPCMux;

architecture Behavioral of AluPCMux is

begin
	process(UsePC, PC, ForwardAData)
	begin
		if UsePC = '1' then
			AluSrc1 <= PC;
		else
			AluSrc1 <= ForwardAData;
		end if;
	end process;

end Behavioral;

