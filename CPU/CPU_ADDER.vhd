----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:44:15 11/26/2018 
-- Design Name: 
-- Module Name:    CPU_ADDER - Behavioral 
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

entity CPU_ADDER is
	port(
		PC			: in STD_LOGIC_VECTOR(15 downto 0);
		Imm		: in STD_LOGIC_VECTOR(15 downto 0);
		result	: out STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"
	);
end CPU_ADDER;

architecture Behavioral of CPU_ADDER is
begin
	process(PC, Imm)
	begin
		result <= PC + Imm;
	end process;
end Behavioral;

