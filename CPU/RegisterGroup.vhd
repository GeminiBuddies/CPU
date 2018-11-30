----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:18:54 11/29/2018 
-- Design Name: 
-- Module Name:    RegisterGroup - Behavioral 
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

entity RegisterGroup is
    Port ( Reg1Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Data : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteReg : in  STD_LOGIC;
           WriteData : in  STD_LOGIC;
           DstReg : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg1Index : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg2Index : in  STD_LOGIC_VECTOR (3 downto 0));
end RegisterGroup;

architecture Behavioral of RegisterGroup is
type REG_GROUP is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_group:REG_GROUP;

begin
process(clk, WriteReg, WriteData, DstReg)
begin
	if WriteReg = '1' then
		reg_group(CONV_INTEGER(DstReg)) <= WriteData;
	elsif falling_edge(clk) then
	   Reg1Data <= reg_group(CONV_INTEGER(Reg1Index));
		Reg2Data <= reg_group(CONV_INTEGER(Reg2Index));
	end if;
end process;

end Behavioral;

