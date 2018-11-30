----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:46:58 11/30/2018 
-- Design Name: 
-- Module Name:    EXE_MEM_PILLAR - Behavioral 
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

entity EXE_MEM_PILLAR is
	port(
		clk : in STD_LOGIC;
		MemReadIn : in STD_LOGIC;
		MemReadOut : out STD_LOGIC;
		MemWriteIn : in STD_LOGIC;
		MemWriteOut : out STD_LOGIC;
		AluResultIn : in STD_LOGIC_VECTOR(15 downto 0);
		AluResultOut : out STD_LOGIC_VECTOR(15 downto 0);
		WriteDataIn : in STD_LOGIC_VECTOR(15 downto 0);
		WriteDataOut : out STD_LOGIC_VECTOR(15 downto 0);
		DstIndexIn : in STD_LOGIC_VECTOR(3 downto 0);
		DstIndexOut : out STD_LOGIC_VECTOR(3 downto 0);
		MemOrAluIn : in STD_LOGIC;
		MemOrAluOut : out STD_LOGIC;
		WriteRegIn: in STD_LOGIC;
		WriteRegOut : out STD_LOGIC
	);
end EXE_MEM_PILLAR;

architecture Behavioral of EXE_MEM_PILLAR is

begin

process(clk)
begin
	if rising_edge(clk) then
		MemReadOut <= MemReadIn;
		MemWriteOut <= MemWriteIn;
		AluResultOut <= AluResultIn;
		WriteDataOut <= WriteDataIn;
		DstIndexOut <= DstIndexIn;
		MemOrAluOut <= MemOrAluIn;
		WriteRegOut <= WriteRegIn;
	end if;
end process;

end Behavioral;

