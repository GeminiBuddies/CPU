--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:50:27 12/02/2018
-- Design Name:   
-- Module Name:   E:/2018Fall/Computer Organization/CPU/CPU/TMTest.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopModule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TMTest IS
END TMTest;
 
ARCHITECTURE behavior OF TMTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopModule
    PORT(
         Reg00 : OUT  std_logic_vector(15 downto 0);
         Reg01 : OUT  std_logic_vector(15 downto 0);
         Reg02 : OUT  std_logic_vector(15 downto 0);
         Reg03 : OUT  std_logic_vector(15 downto 0);
         Reg04 : OUT  std_logic_vector(15 downto 0);
         Reg05 : OUT  std_logic_vector(15 downto 0);
         Reg06 : OUT  std_logic_vector(15 downto 0);
         Reg07 : OUT  std_logic_vector(15 downto 0);
         IH : OUT  std_logic_vector(15 downto 0);
         SP : OUT  std_logic_vector(15 downto 0);
         RA : OUT  std_logic_vector(15 downto 0);
         T : OUT  std_logic_vector(15 downto 0);
         RegPC : OUT  std_logic_vector(15 downto 0);
			clk0 : OUT STD_LOGIC;
			
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';

 	--Outputs
   signal Reg00 : std_logic_vector(15 downto 0);
   signal Reg01 : std_logic_vector(15 downto 0);
   signal Reg02 : std_logic_vector(15 downto 0);
   signal Reg03 : std_logic_vector(15 downto 0);
   signal Reg04 : std_logic_vector(15 downto 0);
   signal Reg05 : std_logic_vector(15 downto 0);
   signal Reg06 : std_logic_vector(15 downto 0);
   signal Reg07 : std_logic_vector(15 downto 0);
   signal IH : std_logic_vector(15 downto 0);
   signal SP : std_logic_vector(15 downto 0);
   signal RA : std_logic_vector(15 downto 0);
   signal T : std_logic_vector(15 downto 0);
   signal RegPC : std_logic_vector(15 downto 0);
	signal clk0 : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : time := 2000 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopModule PORT MAP (
          Reg00 => Reg00,
          Reg01 => Reg01,
          Reg02 => Reg02,
          Reg03 => Reg03,
          Reg04 => Reg04,
          Reg05 => Reg05,
          Reg06 => Reg06,
          Reg07 => Reg07,
          IH => IH,
          SP => SP,
          RA => RA,
          T => T,
          RegPC => RegPC,
			 clk0 => clk0,
          clk => clk,
          rst => rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
