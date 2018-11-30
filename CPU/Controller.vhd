----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:34:48 11/19/2018 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is
    Port ( AluOp : out  STD_LOGIC_VECTOR (3 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExtend : out  STD_LOGIC;
           ImmOrReg2 : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           WriteReg : out  STD_LOGIC;
			  UsePc : out STD_LOGIC;
			  Reg1Choose : out STD_LOGIC_VECTOR (2 downto 0);
			  ImmChoose : out STD_LOGIC_VECTOR (2 downto 0);
			  RegDstChoose : out STD_LOGIC_VECTOR (2 downto 0);
			  HazardKind : out STD_LOGIC_VECTOR(1 downto 0);
           MemOrAlu : out  STD_LOGIC);
			  
end Controller;

architecture Behavioral of Controller is

begin
process(Instruction)
begin
	case Instruction(15 downto 11) is
		when "01001" =>	--ADDIU
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "001";
			RegDstChoose <= "110";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "01000" =>	--ADDIU3
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "100";
			RegDstChoose <= "101";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "01100" =>
			case Instruction(10 downto 8) is
				when "011" =>	--ADDSP
					SignExtend <= '1';
					Reg1Choose <= "000";
					ImmChoose <= "001";
					RegDstChoose <= "000";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "000" =>	--BTEQZ
					SignExtend <= '1';
					Reg1Choose <= "011";
					ImmChoose <= "001";
					RegDstChoose <= "111";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '0';
					MemOrAlu <= '0';	
					HazardKind <= "01";
					UsePc <= '0';
				when "100" =>	--MTSP
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "000";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when others =>
			end case;
		when "11100" =>
			case Instruction(1 downto 0) is
				when "01" =>	--ADDU
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "100";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "11" =>	--SUBU
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "000";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when others =>
			end case;
		when "11101" =>
			case Instruction(4 downto 0) is
				when "01100" =>	--AND
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "110";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "01010" =>	--CMP
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "011";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "00000" =>
					case Instruction(7 downto 5) is
						when "000" =>	--JR
							SignExtend <= '1';
							Reg1Choose <= "110";
							ImmChoose <= "111";
							RegDstChoose <= "111";
							ImmOrReg2 <= '1';
							AluOp <= "0000";
							MemRead <= '0';
							MemWrite <= '0';
							WriteReg <= '0';
							MemOrAlu <= '0';
							HazardKind <= "10";
							UsePc <= '0';
						when "010" =>	--MFPC
							SignExtend <= '1';
							Reg1Choose <= "111";
							ImmChoose <= "111";
							RegDstChoose <= "110";
							ImmOrReg2 <= '1';
							AluOp <= "0000";
							MemRead <= '0';
							MemWrite <= '0';
							WriteReg <= '1';
							MemOrAlu <= '0';
							HazardKind <= "11";
							UsePc <= '1';
						when "110" =>	--JALR
							SignExtend <= '1';
							Reg1Choose <= "111";
							ImmChoose <= "111";
							RegDstChoose <= "010";
							ImmOrReg2 <= '1';
							AluOp <= "0000";
							MemRead <= '0';
							MemWrite <= '0';
							WriteReg <= '0';
							MemOrAlu <= '0';
							HazardKind <= "10";
							UsePc <= '1';
						when "001" =>	--JRRA
							SignExtend <= '1';
							Reg1Choose <= "010";
							ImmChoose <= "111";
							RegDstChoose <= "111";
							ImmOrReg2 <= '1';
							AluOp <= "0000";
							MemRead <= '0';
							MemWrite <= '0';
							WriteReg <= '0';
							MemOrAlu <= '0';
							HazardKind <= "10";
							UsePc <= '0';
						when others =>
					end case;
				when "01101" =>	--OR
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "110";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "00011" => 	--SLTU
					SignExtend <= '1';
					Reg1Choose <= "110";
					ImmChoose <= "111";
					RegDstChoose <= "011";
					ImmOrReg2 <= '0';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when others =>
			end case;
		when "00010" =>	--B
			SignExtend <= '1';
			Reg1Choose <= "111";
			ImmChoose <= "000";
			RegDstChoose <= "111";
			ImmOrReg2 <= '0';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "01";
			UsePc <= '0';
		when "00100" =>	--BEQZ
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "001";
			RegDstChoose <= "111";
			ImmOrReg2 <= '0';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "01";
			UsePc <= '0';
		when "00101" =>	--BNEZ
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "001";
			RegDstChoose <= "111";
			ImmOrReg2 <= '0';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "01";
			UsePc <= '0';
		when "01101" => 	--LI
			SignExtend <= '0';
			Reg1Choose <= "111";
			ImmChoose <= "001";
			RegDstChoose <= "110";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "10011" =>	--LW
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "010";
			RegDstChoose <= "101";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '1';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '1';
			HazardKind <= "00";
			UsePc <= '0';
		when "10010" =>	--LW_SP
			SignExtend <= '1';
			Reg1Choose <= "000";
			ImmChoose <= "001";
			RegDstChoose <= "110";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '1';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '1';
			HazardKind <= "00";
			UsePc <= '0';
		when "11110" =>
			if Instruction(0)='0' then	--MFIH
				SignExtend <= '1';
				Reg1Choose <= "001";
				ImmChoose <= "111";
				RegDstChoose <= "110";
				ImmOrReg2 <= '0';
				AluOp <= "0000";
				MemRead <= '0';
				MemWrite <= '0';
				WriteReg <= '1';
				MemOrAlu <= '0';
				HazardKind <= "11";	
				UsePc <= '0';
			else	--MTIH
				SignExtend <= '1';
				Reg1Choose <= "110";
				ImmChoose <= "111";
				RegDstChoose <= "001";
				ImmOrReg2 <= '0';
				AluOp <= "0000";
				MemRead <= '0';
				MemWrite <= '0';
				WriteReg <= '1';
				MemOrAlu <= '0';	
				HazardKind <= "11";
				UsePc <= '0';
			end if;
		when "00001" =>	--NOP
			SignExtend <= '1';
			Reg1Choose <= "111";
			ImmChoose <= "111";
			RegDstChoose <= "111";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "00110" =>
			case Instruction(1 downto 0) is
				when "00" =>	--SLL
					SignExtend <= '0';
					Reg1Choose <= "101";
					ImmChoose <= "011";
					RegDstChoose <= "110";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";	
					UsePc <= '0';		
				when "11" =>	--SRA
					SignExtend <= '0';
					Reg1Choose <= "101";
					ImmChoose <= "011";
					RegDstChoose <= "110";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when "10" =>	--SRL
					SignExtend <= '0';
					Reg1Choose <= "101";
					ImmChoose <= "011";
					RegDstChoose <= "110";
					ImmOrReg2 <= '1';
					AluOp <= "0000";
					MemRead <= '0';
					MemWrite <= '0';
					WriteReg <= '1';
					MemOrAlu <= '0';
					HazardKind <= "11";
					UsePc <= '0';
				when others =>
			end case;
		when "11011" =>	--SW
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "010";
			RegDstChoose <= "111";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '1';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "11010" =>	--SW_SP
			SignExtend <= '1';
			Reg1Choose <= "000";
			ImmChoose <= "001";
			RegDstChoose <= "111";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '1';
			WriteReg <= '0';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when "01010" => 	--SLTI
			SignExtend <= '1';
			Reg1Choose <= "110";
			ImmChoose <= "001";
			RegDstChoose <= "011";
			ImmOrReg2 <= '1';
			AluOp <= "0000";
			MemRead <= '0';
			MemWrite <= '0';
			WriteReg <= '1';
			MemOrAlu <= '0';
			HazardKind <= "11";
			UsePc <= '0';
		when others =>
	end case;
end process;
end Behavioral;

