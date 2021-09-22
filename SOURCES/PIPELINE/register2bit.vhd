----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:12:40 05/20/2021 
-- Design Name: 
-- Module Name:    register2bit - Behavioral 
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

entity register2bit is
	port ( clk     : in std_logic;
			 we      : in std_logic;
			 reset   : in std_logic;
			 datain  : in std_logic_vector(1 downto 0);
			 dataout : out std_logic_vector(1 downto 0)
			 );
end register2bit;

architecture Behavioral of register2bit is
	

begin

	process(clk, we, datain, reset)
		begin
			if reset = '1' then
				dataout <= (others=>'0');
			elsif we = '1' then
				if rising_edge(clk) then
					dataout <= datain;
				end if;
			end if;
	end process;

end Behavioral;