----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:51 12/01/2018 
-- Design Name: 
-- Module Name:    PCMux - Behavioral 
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

entity PCMux is
	port(
		PCChoose: in STD_LOGIC_VECTOR(1 downto 0);
		AddedPC : in STD_LOGIC_VECTOR(15 downto 0);
		RegJump : in STD_LOGIC_VECTOR(15 downto 0);
		ConditionalJump : in STD_LOGIC_VECTOR(15 downto 0);
		NextPC : out STD_LOGIC_VECTOR(15 downto 0)
	);
end PCMux;

architecture Behavioral of PCMux is

begin

process(PCChoose, AddedPC, RegJump, ConditionalJump)
begin

case PCChoose is
	when "00" =>
		NextPC <= AddedPC;
	when "01" =>
		NextPC <= ConditionalJump;
	when "10" =>
		NextPC <= RegJump;
	when others =>
end case;

end process;

end Behavioral;

