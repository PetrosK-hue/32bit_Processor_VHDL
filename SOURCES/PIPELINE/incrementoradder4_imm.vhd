----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:17:53 04/07/2021 
-- Design Name: 
-- Module Name:    incrementoradder4_imm - Behavioral 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity incrementoradder4_imm is
		Port ( input : in  STD_LOGIC_vector(31 downto 0);
             imme : in  STD_LOGIC_vector(31 downto 0);
			    output : out  STD_LOGIC_vector(31 downto 0)
            );
end incrementoradder4_imm;

architecture Behavioral of incrementoradder4_imm is
signal inter_out : signed(31 downto 0);

begin

	inter_out <= signed(input) + signed(imme);
	output <= std_logic_vector(inter_out);

end Behavioral;

