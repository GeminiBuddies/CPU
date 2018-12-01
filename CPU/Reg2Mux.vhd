----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:09:20 11/29/2018 
-- Design Name: 
-- Module Name:    Reg2Mux - Behavioral 
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

entity Reg2Mux is
    Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Choose : in  STD_LOGIC_VECTOR(1 downto 0);
           Reg2Index : out  STD_LOGIC_VECTOR (3 downto 0));
end Reg2Mux;

architecture Behavioral of Reg2Mux is
begin
process(Instruction, Reg2Choose)
begin
	case Reg2Choose is
		when "00" =>	--rx
			Reg2Index(3) <= '0';
			Reg2Index(2 downto 0) <= Instruction(10 downto 8);
		when "01" =>	--ry
			Reg2Index(3) <= '0';
			Reg2Index(2 downto 0) <= Instruction(7 downto 5);
		when others =>
			Reg2Index <= "1111";
	end case;
end process;
end Behavioral;

