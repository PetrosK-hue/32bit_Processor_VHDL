----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:08 05/20/2021 
-- Design Name: 
-- Module Name:    forwardingUnit - Behavioral 
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

entity forwardingUnit is
	Port (  RsIn : in  STD_LOGIC_VECTOR (4 downto 0);
           RtIn : in  STD_LOGIC_VECTOR (4 downto 0);
			  RdIn : in  STD_LOGIC_VECTOR (4 downto 0);
			  RegWriteS1 : in STD_LOGIC;
			  RegWriteS2 : in STD_LOGIC;
			  toMem_WrEn : in std_logic;
			  opCode : in  STD_LOGIC_VECTOR (5 downto 0);
           RdEx : in  STD_LOGIC_VECTOR (4 downto 0);
           RdMem : in  STD_LOGIC_VECTOR (4 downto 0);
           Aout : out  STD_LOGIC_VECTOR (1 downto 0);
			  Bout : out  STD_LOGIC_VECTOR (1 downto 0));
end forwardingUnit;

architecture Behavioral of forwardingUnit is

signal rd0 : std_logic_vector(4 downto 0) := (others => '0');

begin
process(RsIn,RtIn,RegWriteS1,RegWriteS2,RdEx,RdMem)
	begin
		if (opCode = "001111" and (RdEx /= rd0) and (RdEx = RtIn)) then
			Aout <= "00";
			Bout <= "11";
			elsif (opCode = "001111" and (RdEx /= rd0) and (RdEx = RdIn)) then
			Aout <= "00";
			Bout <= "10";
	   elsif (opCode = "001111" and (RdEx /= rd0) and (RdEx = RsIn)) then
			Aout <= "11";
			Bout <= "00";
		elsif ((RegWriteS1 = '1') and (RdEx /= rd0) and (RdEx = RsIn)) then
			Aout <= "10";
			Bout <= "00";
		elsif ((toMem_WrEn = '1') and (RdEx /= rd0) and (RdIn = RdMem)) then
			Aout <= "00";
			Bout <= "01";
		elsif ((RegWriteS1 = '1') and (RdEx /= rd0) and (RdEx = RtIn)) then
			Aout <= "00";
			Bout <= "10";
		elsif ((RegWriteS2 = '1') and (RdMem /= rd0) and (RdMem = RsIn))then
			Aout <= "01";
			Bout <= "00";
		elsif ((RegWriteS2 = '1') and (RdMem /= rd0) and (RdMem = RtIn)) then
			Aout <= "00";
			Bout <= "01";
		else 
			Aout <= "00";
			Bout <= "00";
		end if;
end process;

end Behavioral;


