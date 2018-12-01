----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:26 11/29/2018 
-- Design Name: 
-- Module Name:    ImmediateMux - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ImmediateMux is
    Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExtend : in  STD_LOGIC;
			  ImmChoose : in STD_LOGIC_VECTOR(2 downto 0);
           ExtendedImm : out  STD_LOGIC_VECTOR (15 downto 0));
end ImmediateMux;

architecture Behavioral of ImmediateMux is

begin

process(Instruction, SignExtend, ImmChoose)
begin
case ImmChoose is
	when "000" =>
		if SignExtend = '1' then
	       ExtendedImm <= SXT(Instruction(10 downto 0), ExtendedImm'LENGTH); 
		else
		    ExtendedImm <= EXT(Instruction(10 downto 0), ExtendedImm'LENGTH); 
		end if;
	when "001" =>
		if SignExtend = '1' then
	       ExtendedImm <= SXT(Instruction(7 downto 0), ExtendedImm'LENGTH); 
		else
		    ExtendedImm <= EXT(Instruction(7 downto 0), ExtendedImm'LENGTH); 
		end if;
	when "010" =>
		if SignExtend = '1' then
	       ExtendedImm <= SXT(Instruction(4 downto 0), ExtendedImm'LENGTH); 
		else
		    ExtendedImm <= EXT(Instruction(4 downto 0), ExtendedImm'LENGTH); 
		end if;	
	when "011" =>
		if SignExtend = '1' then
	       ExtendedImm <= SXT(Instruction(4 downto 2), ExtendedImm'LENGTH); 
		else
		    ExtendedImm <= EXT(Instruction(4 downto 2), ExtendedImm'LENGTH); 
		end if;
	when "100" =>
		if SignExtend = '1' then
	       ExtendedImm <= SXT(Instruction(3 downto 0), ExtendedImm'LENGTH); 
		else
		    ExtendedImm <= EXT(Instruction(3 downto 0), ExtendedImm'LENGTH); 
		end if;
	when others =>
		ExtendedImm <= x"ffff";
end case;
end process;


end Behavioral;

