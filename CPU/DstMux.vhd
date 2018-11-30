----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:22:10 11/29/2018 
-- Design Name: 
-- Module Name:    DstMux - Behavioral 
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

entity DstMux is
    Port ( DstIndex : out  STD_LOGIC_VECTOR (3 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           RegDstChoose : in  STD_LOGIC_VECTOR (2 downto 0));
end DstMux;

architecture Behavioral of DstMux is

begin


end Behavioral;

