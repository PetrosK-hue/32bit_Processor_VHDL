--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:31:19 05/18/2021
-- Design Name:   
-- Module Name:   D:/Documents/COURSES/orga/Lab_2021/PROC_MC_test.vhd
-- Project Name:  Lab_2021
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROC_MC
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
 
ENTITY PROC_MC_test IS
END PROC_MC_test;
 
ARCHITECTURE behavior OF PROC_MC_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_MC
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_MC PORT MAP (
          Clk => Clk,
          Reset => Reset
        );

   -- Clock process definitions
   Clk_process :process
    begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset <='1';
      wait for 100 ns;	
       Reset <='0';
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
