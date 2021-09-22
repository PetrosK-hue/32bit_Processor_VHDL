----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:12 05/20/2021 
-- Design Name: 
-- Module Name:    MUX4to1 - Behavioral 
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

entity MUX4to1 is
		Port ( input1 : in  STD_LOGIC_Vector(31 downto 0);
           input2 : in  STD_LOGIC_Vector(31 downto 0);
           input3 : in  STD_LOGIC_Vector(31 downto 0);
           input4 : in  STD_LOGIC_Vector(31 downto 0);
           sel : in  STD_LOGIC_Vector(1 downto 0);
           output :out  STD_LOGIC_Vector(31 downto 0));
end MUX4to1;

architecture Behavioral of MUX4to1 is

begin
	process(input1,input2,input3,input4,sel)
		begin
			if sel = "00" then
				output<=input1;
			elsif sel = "01" then
				output<=input2;
			elsif sel = "10" then
				output<=input3;
			elsif sel = "11" then
				output<=input4;
			end if;
		end process;
		
end Behavioral;

