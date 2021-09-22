----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:48 04/05/2021 
-- Design Name: 
-- Module Name:    mux32bit - Behavioral 
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

entity mux32bit is
Port ( input0 : in  STD_LOGIC_VECTOR(31 downto 0);
           input1 : in  STD_LOGIC_VECTOR(31 downto 0);
           input2 : in  STD_LOGIC_VECTOR(31 downto 0);
           input3 : in  STD_LOGIC_VECTOR(31 downto 0);
           input4 : in  STD_LOGIC_VECTOR(31 downto 0);
           input5 : in  STD_LOGIC_VECTOR(31 downto 0);
           input6 : in  STD_LOGIC_VECTOR(31 downto 0);
           input7 : in  STD_LOGIC_VECTOR(31 downto 0);
           input8 : in  STD_LOGIC_VECTOR(31 downto 0);
           input9 : in  STD_LOGIC_VECTOR(31 downto 0);
           input10 : in  STD_LOGIC_VECTOR(31 downto 0);
           input11 : in  STD_LOGIC_VECTOR(31 downto 0);
           input12 : in STD_LOGIC_VECTOR(31 downto 0);
           input13 : in  STD_LOGIC_VECTOR(31 downto 0);
           input14 : in  STD_LOGIC_VECTOR(31 downto 0);
           input15 : in  STD_LOGIC_VECTOR(31 downto 0);
           input16 : in  STD_LOGIC_VECTOR(31 downto 0);
           input17 : in  STD_LOGIC_VECTOR(31 downto 0);
           input18 : in  STD_LOGIC_VECTOR(31 downto 0);
           input19 : in  STD_LOGIC_VECTOR(31 downto 0);
           input20 : in  STD_LOGIC_VECTOR(31 downto 0);
           input21 : in  STD_LOGIC_VECTOR(31 downto 0);
           input22 : in  STD_LOGIC_VECTOR(31 downto 0);
           input23 : in  STD_LOGIC_VECTOR(31 downto 0);
           input24 : in  STD_LOGIC_VECTOR(31 downto 0);
           input25 : in  STD_LOGIC_VECTOR(31 downto 0);
           input26 : in  STD_LOGIC_VECTOR(31 downto 0);
           input27 : in  STD_LOGIC_VECTOR(31 downto 0);
           input28 : in  STD_LOGIC_VECTOR(31 downto 0);
           input29 : in  STD_LOGIC_VECTOR(31 downto 0);
           input30 : in  STD_LOGIC_VECTOR(31 downto 0);
           input31 : in  STD_LOGIC_VECTOR(31 downto 0);
           sel : in  STD_LOGIC_VECTOR(4 downto 0);
           muxout : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end mux32bit;

architecture Behavioral of mux32bit is
signal zeros : std_logic_vector(31 downto 0) := (others=>'0');
begin

process(sel,input0,input1,input2,input3,input4,input5,input6,input7,input8,
input9,input10,input11,input12,input13,input14,input15,input16,input17,input18,
input19,input20,input21,input22,input23,input24,input25,input26,input27,input28,
input29,input30,input31)

begin
		if (sel = "00000") then
				  muxout <= input0;
		elsif (sel = "00001") then
				  muxout <= input1 after 10 ns;
		elsif (sel = "00010") then
				  muxout <= input2 after 10 ns;
		elsif (sel = "00011") then
				  muxout <= input3 after 10 ns;
		elsif (sel = "00100") then
				  muxout <= input4 after 10 ns;
		elsif (sel = "00101") then
				  muxout <= input5 after 10 ns;
		elsif (sel = "00110") then
				  muxout <= input6 after 10 ns;
		elsif (sel = "00111") then
				  muxout <= input7 after 10 ns;
		elsif (sel = "01000") then
				  muxout <= input8 after 10 ns;
		elsif (sel = "01001") then
				  muxout <= input9 after 10 ns;
		elsif (sel = "01010") then
				  muxout <= input10 after 10 ns;
		elsif (sel = "01011") then
				  muxout <= input11 after 10 ns;
		elsif (sel = "01100") then
				  muxout <= input12 after 10 ns;
		elsif (sel = "01101") then
				  muxout <= input13 after 10 ns;
		elsif (sel = "01110") then
				  muxout <= input14 after 10 ns;
		elsif (sel = "01111") then
				  muxout <= input15 after 10 ns;
		elsif (sel = "10000") then
				  muxout <= input16 after 10 ns;
		elsif (sel = "10001") then
				  muxout <= input17 after 10 ns;
		elsif (sel = "10010") then
				  muxout <= input18 after 10 ns;
		elsif (sel = "10011") then
				  muxout <= input19 after 10 ns;
		elsif (sel = "10100") then
				  muxout <= input20 after 10 ns;
		elsif (sel = "10101") then
				  muxout <= input21 after 10 ns;
		elsif (sel = "10110") then
				  muxout <= input22 after 10 ns;
		elsif (sel = "10111") then
				  muxout <= input23 after 10 ns;
		elsif (sel = "11000") then
				  muxout <= input24 after 10 ns;
		elsif (sel = "11001") then
				  muxout <= input25 after 10 ns;
		elsif (sel = "11010") then
				  muxout <= input26 after 10 ns;
		elsif (sel = "11011") then
				  muxout <= input27 after 10 ns;
		elsif (sel = "11100") then
				  muxout <= input28 after 10 ns;
		elsif (sel = "11101") then
				  muxout <= input29 after 10 ns;
		elsif (sel = "11110") then
				  muxout <= input30 after 10 ns;
		elsif (sel = "11111") then
				  muxout <= input31 after 10 ns;
		else
				  muxout <= zeros after 10 ns;
		end if;
end process;

end Behavioral;

