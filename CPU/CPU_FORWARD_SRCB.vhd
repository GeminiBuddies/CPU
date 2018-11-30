----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:57 11/25/2018 
-- Design Name: 
-- Module Name:    CPU_FORWARD_SRCB - Behavioral 
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

entity CPU_FORWARD_SRCB is
	port(
		imm				: in STD_LOGIC_VECTOR(15 downto 0);
		origin_r_data	: in STD_LOGIC_VECTOR(15 downto 0);
		imm_or_r			: in std_logic;
		r_src				: in STD_LOGIC_VECTOR(3 downto 0);
		exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
		exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
		mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
		mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
		result			: out STD_LOGIC_VECTOR(15 downto 0)
	);
end CPU_FORWARD_SRCB;

architecture Behavioral of CPU_FORWARD_SRCB is
begin
	process(imm, origin_r_data, imm_or_r, r_src, exe_mem_data, exe_mem_r_dst, mem_wb_data, mem_wb_r_dst)
	begin
		if (imm_or_r = '1') then
			result <= imm;
		else
			if (exe_mem_r_dst = r_src) then
				result <= exe_mem_data;
			else
				if (mem_wb_r_dst = r_src) then
					result <= mem_wb_data;
				else
					result <= origin_r_data;
				end if;
			end if;
		end if;
	end process;
end Behavioral;

