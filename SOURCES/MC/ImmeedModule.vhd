----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:23:01 04/09/2021 
-- Design Name: 
-- Module Name:    ImmeedModule - Behavioral 
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ImmedModule is
				Port ( ImmInput : in  STD_LOGIC_VECTOR (15 downto 0);
                   Imm_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
                   ImmOutput : out  STD_LOGIC_VECTOR (31 downto 0)
			                );
end ImmedModule;

architecture Behavioral of ImmedModule is

begin

	process(Imm_Ext, ImmInput)

	begin

case Imm_Ext is

		when "00" =>
			ImmOutput <= STD_LOGIC_VECTOR(resize(unsigned(ImmInput),32));
		when "01" =>
			ImmOutput <= STD_LOGIC_VECTOR(resize(signed(ImmInput),32));
		when "11" =>
			ImmOutput <= STD_LOGIC_VECTOR(resize(SHIFT_LEFT(signed(ImmInput),2),32));
		when "10" =>
			ImmOutput <= STD_LOGIC_VECTOR(SHIFT_LEFT(resize(signed(ImmInput),32),16));
		when others =>
			ImmOutput <= STD_LOGIC_VECTOR(resize(unsigned(ImmInput),32));
			
			
	end case;
end process;


end Behavioral;

