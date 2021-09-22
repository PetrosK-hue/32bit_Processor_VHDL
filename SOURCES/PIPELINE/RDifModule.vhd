----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:50:22 05/20/2021 
-- Design Name: 
-- Module Name:    RDifModule - Behavioral 
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

entity RDifModule is
	Port (  input1 : in  STD_LOGIC_Vector(4 downto 0);
           input2 : in  STD_LOGIC_Vector(4 downto 0);
           opsel : in  STD_LOGIC_Vector(5 downto 0);
           output : out STD_LOGIC_Vector(4 downto 0)
			  );
end RDifModule;

architecture Behavioral of RDifModule is

begin

process(input1,input2,opsel)
		begin
			if opsel = "001111" then
				output<=input2;
			elsif opsel = "011111" then
				output<=input2;
			else 
				output<=input1;
			end if;
		end process;

end Behavioral;

