----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:42 04/07/2021 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
		Port ( input1 : in  std_logic_vector(31 downto 0);
           input2 : in  std_logic_vector(31 downto 0);
           sel : in  STD_LOGIC;
           output : out  std_logic_vector(31 downto 0)
			  );
end mux2to1;

architecture Behavioral of mux2to1 is

begin
 process(input1,input2,sel)
	begin
			if sel = '0' then
				output<=input1;
			elsif sel = '1' then
				output<=input2;
			end if;
		end process;
	end Behavioral;


