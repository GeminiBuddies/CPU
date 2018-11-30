----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:27:35 11/18/2018 
-- Design Name: 
-- Module Name:    CPU_ALU - Behavioral 
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

entity CPU_ALU is
	port(
		srcA		: in STD_LOGIC_VECTOR(15 downto 0);
		srcB		: in STD_LOGIC_VECTOR(15 downto 0);
		op			: in STD_LOGIC_VECTOR(3 downto 0);
		result	: out STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"
	);
end CPU_ALU;

architecture Behavioral of CPU_ALU is
	shared variable tmp : std_logic_vector(15 downto 0);
	shared variable flag : std_logic;
begin
	process(srcA, srcB, op)
	begin
		case op is
			when "0000" =>	--ADD
				result <= srcA + srcB;
			when "0001" => --SUB
				result <= srcA - srcB;
			when "0010" => --CMP
				if (srcA = srcB) then 
					result <= "0000000000000000";
				else 
					result <= "0000000000000001";
				end if;
			when "0011" => --AND
				result <= srcA and srcB;
			when "0100" => --OR
				result <= srcA or srcB;
			when "0101" => --SLL
				tmp := srcA(15 downto 0);
				if (srcB = "0000000000000000") then 
					result(15 downto 0) <= to_stdlogicvector(to_bitvector(tmp) sll 8);
				else
					result <= to_stdlogicvector(to_bitvector(srcA) sll conv_integer(srcB));
				end if;
			when "0110" => --SRA
				tmp := srcA(15 downto 0);
				if (srcB = "0000000000000000") then 
					result(15 downto 0) <= to_stdlogicvector(to_bitvector(tmp) sra 8);
				else 
					result <= to_stdlogicvector(to_bitvector(srcA) sra conv_integer(srcB));
				end if;
			when "0111" => --SRL
				tmp := srcA(15 downto 0);
				if (srcB = "0000000000000000") then 
					result(15 downto 0) <= to_stdlogicvector(to_bitvector(tmp) srl 8);
				else 
					result <= to_stdlogicvector(to_bitvector(srcA) srl conv_integer(srcB));
				end if;
			when "1000" => --OUTA
				result <= srcA;
			when "1001" => --OUTB
				result <= srcB;
			when "1010" => --SLTU (UNSIGNED)
				if (srcA < srcB) then
					result <= "0000000000000001";
				else 
					result <= (others => '0');
				end if;
			when "1011" => --SLTI (SIGNED)
				if srcA(15) = '1' then
					if srcB(15) = '1' then
						if (srcA < srcB) then
							flag := '1';
						else
							flag := '0';
						end if;
					else
						flag := '1';
					end if;
				else
					if srcB(15) = '0' then
						if (srcA < srcB) then
							flag := '1';
						else
							flag := '0';
						end if;
					else
						flag := '0';
					end if;
				end if;
				if (flag = '1') then
					result <= "0000000000000001";
				else 
					result <= (others => '0');
				end if;
			when "1100" => --BTEQZ
				if (srcA = "000000000000000") then
					result <= "0000000000000001";
				else
					result <= (others => '0');
				end if;
			when "1101" => --BNEZ
				if (srcA = "000000000000000") then
					result <= (others => '0');
				else
					result <= "0000000000000001";
				end if;
			when "1110" => --B
				result <= "0000000000000001";
			when others=>
				result <= (others => '0');
		end case;
	end process;
end Behavioral;

