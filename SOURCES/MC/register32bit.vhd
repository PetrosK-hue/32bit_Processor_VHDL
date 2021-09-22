----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:10 04/05/2021 
-- Design Name: 
-- Module Name:    register32bit - Behavioral 
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

entity register32bit is
	Port ( clk: in  STD_LOGIC;
			 rst: in  STD_LOGIC;
          we : in  STD_LOGIC;
          datain : in  STD_LOGIC_vector(31 downto 0);
          dataout : out  STD_LOGIC_vector(31 downto 0)
			  );
end register32bit;

architecture Behavioral of register32bit is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";


begin
process
begin

Wait until( clk'EVENT and clk = '1' );     
If (we = '1') then  temp<=datain;     
elsif (rst='1') then temp<="00000000000000000000000000000000";
else temp<=temp;     
End if;   
End process ;
dataout<=temp; 



end Behavioral;

