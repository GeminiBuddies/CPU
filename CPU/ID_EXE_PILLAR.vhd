----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:58:20 11/30/2018 
-- Design Name: 
-- Module Name:    ID_EXE_PILLAR - Behavioral 
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

entity ID_EXE_PILLAR is
	port(
		clk : in STD_LOGIC;
		PCIn : in STD_LOGIC_VECTOR(15 downto 0);
		PCOut : out STD_LOGIC_VECTOR(15 downto 0);
		AluOpIn : in STD_LOGIC_VECTOR(3 downto 0);
		AluOpOut : out STD_LOGIC_VECTOR(3 downto 0);
		ImmOrReg2In : in STD_LOGIC;
		ImmOrReg2Out : out STD_LOGIC;
		UsePcIn : in STD_LOGIC;
		UsePcOut : out STD_LOGIC;
		Reg1DataIn : in STD_LOGIC_VECTOR(15 downto 0);
		Reg1DataOut : out STD_LOGIC_VECTOR(15 downto 0);
		Reg2DataIn : in STD_LOGIC_VECTOR(15 downto 0);
		Reg2DataOut : out STD_LOGIC_VECTOR(15 downto 0);
		ImmIn : in STD_LOGIC_VECTOR(15 downto 0);
		ImmOut : out STD_LOGIC_VECTOR(15 downto 0);
		Reg1IndexIn : in STD_LOGIC_VECTOR(3 downto 0);
		Reg1IndexOut : out STD_LOGIC_VECTOR(3 downto 0);
		Reg2IndexIn : in STD_LOGIC_VECTOR(3 downto 0);
		Reg2IndexOut : out STD_LOGIC_VECTOR(3 downto 0);
		DstIndexIn : in STD_LOGIC_VECTOR(3 downto 0);
		DstIndexOut : out STD_LOGIC_VECTOR(3 downto 0);
		HazardKindIn : in STD_LOGIC_VECTOR(1 downto 0);
		HazardKindOut : out STD_LOGIC_VECTOR(1 downto 0);
		MemReadIn : in STD_LOGIC;
		MemReadOut : out STD_LOGIC;
		MemWriteIn : in STD_LOGIC;
		MemWriteOut : out STD_LOGIC;
		WriteRegIn : in STD_LOGIC;
		WriteRegOut : out STD_LOGIC;
		MemOrAluIn : in STD_LOGIC;
		MemOrAluOut : out STD_LOGIC;
		
		IDEXEFlush : in STD_LOGIC
	);
end ID_EXE_PILLAR;

architecture Behavioral of ID_EXE_PILLAR is

begin

process(clk)
begin
	if rising_edge(clk) then
		if IDEXEFlush = '1' then
			AluOpOut <= "0000";
			ImmOrReg2Out <= '1';
			UsePcOut <= '0';
			Reg1DataOut <= x"0000";
			Reg2DataOut <= x"0000";
			ImmOut <= x"0000";
			Reg1IndexOut <= "1111";
			Reg2IndexOut <= "1111";
			DstIndexOut <= "1111";
			HazardKindOut <= "11";
			MemReadOut <= '0';
			MemWriteOut <= '0';
			WriteRegOut <= '0';
			MemOrAluOut <= '0';
		else
			PCOut <= PCIn;
			AluOpOut <= AluOpIn;
			ImmOrReg2Out <= ImmOrReg2In;
			UsePcOut <= UsePcIn;
			Reg1DataOut <= Reg1DataIn;
			Reg2DataOut <= Reg2DataIn;
			ImmOut <= ImmIn;
			Reg1IndexOut <= Reg1IndexIn;
			Reg2IndexOut <= Reg2IndexIn;
			DstIndexOut <= DstIndexIn;
			HazardKindOut <= HazardKindIn;
			MemReadOut <= MemReadIn;
			MemWriteOut <= MemWriteIn;
			WriteRegOut <= WriteRegIn;
			MemOrAluOut <= MemOrAluIn;
		end if;
	end if;
	

end process;

end Behavioral;

