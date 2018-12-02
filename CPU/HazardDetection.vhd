----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:11:48 11/29/2018 
-- Design Name: 
-- Module Name:    HazardDetection - Behavioral 
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

entity HazardDetection is
    Port ( LoadDst : in STD_LOGIC_VECTOR(3 downto 0);
			  RegSrc1 : in STD_LOGIC_VECTOR(3 downto 0);	
			  RegSrc2 : in STD_LOGIC_VECTOR(3 downto 0);
			  HazardKind : in STD_LOGIC_VECTOR(1 downto 0);
			  AluRes : in STD_LOGIC_VECTOR(15 downto 0);
			  PCKeep : out  STD_LOGIC := '0';
			  IFIDKeep : out STD_LOGIC := '0';
			  IFIDFlush : out STD_LOGIC := '0';
			  IDEXEFlush : out STD_LOGIC :='0';
           PCChoose : out STD_LOGIC_VECTOR(1 downto 0):= "00");
end HazardDetection;

architecture Behavioral of HazardDetection is

begin

process(LoadDst, RegSrc1, RegSrc2, AluRes, HazardKind)
begin

case HazardKind is 
	when "00" => --load
		if LoadDst = RegSrc1 or LoadDst = RegSrc2 then
			PCKeep <= '1';
			IFIDKeep <= '1';
			IDEXEFlush <= '1';
			IFIDFlush <= '0';
			PCChoose <= "00";
		else
			PCKeep <= '0';
			IFIDKeep <= '0';
			IDEXEFlush <= '0';
			IFIDFlush <= '0';
			PCChoose <= "00";
		end if;
	when "01" => --condition jump
		if AluRes(0) = '1' then
		   PCKeep <= '0';
			IFIDKeep <= '0';
			IDEXEFlush <= '0';
			IFIDFlush <= '1';
			PCChoose <= "01";
		else
			PCKeep <= '0';
			IFIDKeep <= '0';
			IDEXEFlush <= '0';
			IFIDFlush <= '0';
			PCChoose <= "00";	
		end if;
	when "10" => --register jump
		PCKeep <= '0';
		IFIDKeep <= '0';
		IDEXEFlush <= '0';
		IFIDFlush <= '1';
		PCChoose <= "10";
	when "11" => --no hazard
	   PCKeep <= '0';
		IFIDKeep <= '0';
		IDEXEFlush <= '0';
		IFIDFlush <= '0';
		PCChoose <= "00";	
	when others =>
end case;

end process;

end Behavioral;

