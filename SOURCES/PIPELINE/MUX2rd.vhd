----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:21:17 04/09/2021 
-- Design Name: 
-- Module Name:    MUX2rd - Behavioral 
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

entity MUX2rd is
	port ( input1 : in std_logic_vector(31 downto 0);
		    input2 : in std_logic_vector(31 downto 0);
		    sel    : in std_logic;
			 output : out std_logic_vector(31 downto 0)
		   	);
end MUX2rd;

architecture Behavioral of MUX2rd is
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

