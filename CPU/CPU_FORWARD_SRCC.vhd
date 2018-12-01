----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:00:57 12/01/2018 
-- Design Name: 
-- Module Name:    CPU_FORWARD_SRCC - Behavioral 
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

entity CPU_FORWARD_SRCC is
port(
		origin_data		: in STD_LOGIC_VECTOR(15 downto 0);
		r_src				: in STD_LOGIC_VECTOR(3 downto 0);
		exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
		exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
		mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
		mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
		result			: out STD_LOGIC_VECTOR(15 downto 0)
	);
end CPU_FORWARD_SRCC;

architecture Behavioral of CPU_FORWARD_SRCC is
begin
	process(origin_data, r_src, exe_mem_data, exe_mem_r_dst, mem_wb_data, mem_wb_r_dst)
	begin
		if (exe_mem_r_dst = r_src) then
			result <= exe_mem_data;
		else
			if (mem_wb_r_dst = r_src) then
				result <= mem_wb_data;
			else
				result <= origin_data;
			end if;
		end if;
	end process;
end Behavioral;

