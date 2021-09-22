----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:57 05/20/2021 
-- Design Name: 
-- Module Name:    stallsUnit - Behavioral 
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

entity stallsUnit is
	Port (  opCode : in  STD_LOGIC_VECTOR (5 downto 0);
           ifRS : in  STD_LOGIC_VECTOR (4 downto 0);
           ifRT : in  STD_LOGIC_VECTOR (4 downto 0);
           idRD : in  STD_LOGIC_VECTOR (4 downto 0);
			  pcld : in std_logic;
			  pcldout : out std_logic;
			  rfwritein : in std_logic;
			  rfwriteout : out std_logic;
			  instrwren : in std_logic;
			  instrwrenout : out std_logic
			  );
end stallsUnit;

architecture Behavioral of stallsUnit is

begin
	process(opCode, ifRT, ifRS, idRD, pcld, instrwren)
		begin
			if ( opCode = "001111" and (ifRT = idRD or ifRS = idRD)) then
				pcldout <= '0';
				instrwrenout <= '0';
				rfwriteout <= '0';
			else
				pcldout <= pcld;
				instrwrenout <= instrwren;
				rfwriteout <= rfwritein;
			end if;
	end process;	

end Behavioral;
