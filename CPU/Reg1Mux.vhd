----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:18 11/29/2018 
-- Design Name: 
-- Module Name:    Reg1Mux - Behavioral 
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

entity Reg1Mux is
    Port ( Reg1Choose : in  STD_LOGIC_VECTOR (2 downto 0);	--control生成的选择哪个寄存器的控制信号
           Instruction : in  STD_LOGIC_VECTOR (15 downto 0); --指令
           Reg1Index : out  STD_LOGIC_VECTOR (3 downto 0)); --四位寄存器编号
end Reg1Mux;

architecture Behavioral of Reg1Mux is
begin
process(Reg1Choose, Instruction)
begin
	case Reg1Choose is 
		when "110" => --选择rx
			Reg1Index(3) <= '0';
			Reg1Index(2 downto 0) <= Instruction(10 downto 8);
      when "101" => --选择ry
			Reg1Index(3) <= '0';
			Reg1Index(2 downto 0) <= Instruction(7 downto 5);
		when "100" => --选择rz
			Reg1Index(3) <= '0';
			Reg1Index(2 downto 0) <= Instruction(4 downto 2);
		when others => --特殊寄存器
			Reg1Index(3) <= '1';
			Reg1Index(2 downto 0) <= Reg1Choose;
	end case;
end process;
end Behavioral;

