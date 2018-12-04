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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterGroup is
    Port ( 
--		--Debug		
--				Reg00 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg01 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg02 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg03 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg04 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg05 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg06 : out STD_LOGIC_VECTOR(15 downto 0);
--				Reg07 : out STD_LOGIC_VECTOR(15 downto 0);
--				IH : out STD_LOGIC_VECTOR(15 downto 0);
--				SP : out STD_LOGIC_VECTOR(15 downto 0);
--				RA : out STD_LOGIC_VECTOR(15 downto 0);
--				T : out STD_LOGIC_VECTOR(15 downto 0);
--		--Debug
	 
	 
			  clk : in STD_LOGIC;
			  Reg1Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Data : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteReg : in  STD_LOGIC;
           WriteData : in  STD_LOGIC_VECTOR(15 downto 0);
           DstReg : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg1Index : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg2Index : in  STD_LOGIC_VECTOR (3 downto 0));
end RegisterGroup;

architecture Behavioral of RegisterGroup is
type REG_GROUP is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal RegGroup:REG_GROUP:=(x"0000",x"0001",x"0002",x"0003",x"0004",x"0005",x"0006",x"0007",
x"0008",x"0009",x"000A",x"000B",x"000C",x"000D",x"000E",x"000F");

begin

--Reg00 <= RegGroup(0);
--Reg01 <= RegGroup(1);
--Reg02 <= RegGroup(2);
--Reg03 <= RegGroup(3);
--Reg04 <= RegGroup(4);
--Reg05 <= RegGroup(5);
--Reg06 <= RegGroup(6);
--Reg07 <= RegGroup(7);
--IH <= RegGroup(9);
--SP <= RegGroup(8);
--T <= RegGroup(11);
--RA <= RegGroup(10);

process(WriteReg, WriteData, DstReg)
begin
	if WriteReg = '1' then
		RegGroup(CONV_INTEGER(DstReg)) <= WriteData;
	end if;
end process;

process(clk)
begin
	if falling_edge(clk) then
		Reg1Data <= RegGroup(CONV_INTEGER(Reg1Index));
		Reg2Data <= RegGroup(CONV_INTEGER(Reg2Index));
	end if;
end process;

end Behavioral;

