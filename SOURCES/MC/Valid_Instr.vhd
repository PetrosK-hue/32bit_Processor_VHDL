----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:08:31 05/18/2021 
-- Design Name: 
-- Module Name:    Valid_Instr - Behavioral 
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

entity Valid_Instr is
	 Port ( Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           AddressFlag : out  STD_LOGIC);
end Valid_Instr;

architecture Behavioral of Valid_Instr is

begin
	process(Addr)
		begin			 
			if  Addr <="00000000000000000000000000000000" then
				AddressFlag <= '1';
			else
				AddressFlag <= '0';
			end if;
		end process;

end Behavioral;

