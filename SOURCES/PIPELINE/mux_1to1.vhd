----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:34 04/13/2021 
-- Design Name: 
-- Module Name:    mux_1to1 - Behavioral 
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

entity mux_1to1 is
    Port ( input : in  STD_LOGIC_vector(31 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC);
end mux_1to1;

architecture Behavioral of mux_1to1 is
signal zeros : std_logic_vector(23 downto 0) := (others => '0');
begin
process (input, sel) is
begin
case sel is
		when '0' =>
		output <= input;
		when others => 
		output <= std_logic_vector(resize(signed(input(7 downto 0)),32));
	end case;
end process;


end Behavioral;
