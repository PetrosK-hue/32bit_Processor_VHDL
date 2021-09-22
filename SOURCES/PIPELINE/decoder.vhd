----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:09:16 04/05/2021 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
	 Port ( input : in  STD_LOGIC_vector(4 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0)
			  );
end decoder;

architecture Behavioral of decoder is
signal zeros: std_logic_vector(31 downto 0) := (others=>'0');

begin
process(input)


begin
	if (input = "00000") then
			  output <= zeros;
			  output(0) <= '1' after 10 ns;
	elsif (input = "00001") then
			  output <= zeros;
			  output(1) <= '1' after 10 ns;
	elsif (input = "00010") then
			 output <= zeros;
			 output(2) <= '1' after 10 ns;
	elsif (input = "00011") then
			  output <= zeros;
			  output(3) <= '1' after 10 ns;
	elsif (input = "00100") then
			  output <= zeros;
			  output(4) <= '1'after 10 ns;
	elsif (input = "00101") then
			  output <= zeros;
			  output(5) <= '1' after 10 ns;
	elsif (input = "00110") then
			  output <= zeros;
			  output(6) <= '1' after 10 ns;
	elsif (input = "00111") then
			  output <= zeros;
			  output(7) <= '1' after 10 ns;
	elsif (input = "01000") then
			  output <= zeros;
			  output(8) <= '1' after 10 ns;
	elsif (input = "01001") then
			  output <= zeros;
			  output(9) <= '1' after 10 ns;
	elsif (input = "01010") then
			  output <= zeros;
			  output(10) <= '1' after 10 ns;
	elsif (input = "01011") then
			  output <= zeros;
			  output(11) <= '1' after 10 ns;
	elsif (input = "01100") then
			  output <= zeros;
			  output(12) <= '1' after 10 ns;
	elsif (input = "01101") then
			  output <= zeros;
			  output(13) <= '1' after 10 ns;
	elsif (input = "01110") then
			  output <= zeros;
			  output(14) <= '1' after 10 ns;
	elsif (input = "01111") then
			  output <= zeros;
			  output(15) <= '1' after 10 ns;
	elsif (input = "10000") then
			  output <= zeros;
			  output(16) <= '1' after 10 ns;
	elsif (input = "10001") then
			  output <= zeros;
			  output(17) <= '1' after 10 ns;
	elsif (input = "10010") then
			  output <= zeros;
			  output(18) <= '1' after 10 ns;
	elsif (input = "10011") then
			  output <= zeros;
			  output(19) <= '1' after 10 ns;
	elsif (input = "10100") then
			  output <= zeros;
			  output(20) <= '1' after 10 ns;
	elsif (input = "10101") then
			  output <= zeros;
			  output(21) <= '1' after 10 ns;
	elsif (input = "10110") then
			  output <= zeros;
			  output(22) <= '1' after 10 ns;
	elsif (input = "10111") then
			  output <= zeros;
			  output(23) <= '1' after 10 ns;
	elsif (input = "11000") then
			  output <= zeros;
			  output(24) <= '1' after 10 ns;
	elsif (input = "11001") then
			  output <= zeros;
			  output(25) <= '1' after 10 ns;
	elsif (input = "11010") then
			  output <= zeros;
			  output(26) <= '1' after 10 ns;
	elsif (input = "11011") then
			  output <= zeros;
			  output(27) <= '1' after 10 ns;
	elsif (input = "11100") then
			  output <= zeros;
			  output(28) <= '1' after 10 ns;
	elsif (input = "11101") then
			  output <= zeros;
			  output(29) <= '1' after 10 ns;
	elsif (input = "11110") then
			  output <= zeros;
			  output(30) <= '1' after 10 ns;
	elsif (input = "11111") then
			  output <= zeros;
			  output(31) <= '1' after 10 ns;
			  else
				  output <= zeros after 10 ns;
	end if;
	end process;
end Behavioral;

