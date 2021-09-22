----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:31 04/07/2021 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  std_logic_vector(31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_Lden : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Pc : out  std_logic_vector(31 downto 0)
			  
			  );
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component register32bit is
 Port (    clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datain : in  std_logic_vector(31 downto 0);
           dataout : out  std_logic_vector(31 downto 0)
			  );
			  
end component;

component adder_plus4_incrementor is
	Port ( input : in  std_logic_vector(31 downto 0);
           output : out  std_logic_vector(31 downto 0)
			  );
end component;
component incrementoradder4_imm is
	port ( input  : in std_logic_vector(31 downto 0);
			 imme   : in std_logic_vector(31 downto 0);
			 output : out std_logic_vector(31 downto 0)
			);
end component;
component mux2to1 is
	port ( input1 : in std_logic_vector(31 downto 0);
			 input2 : in std_logic_vector(31 downto 0);
			 sel    : in std_logic;
			 output : out std_logic_vector(31 downto 0)
			);
end component;

       signal addet2mux :   STD_LOGIC_VECTOR (31 downto 0);
       signal incrementor2mux :  STD_LOGIC_VECTOR (31 downto 0);
       signal mux2Pc_reg :   STD_LOGIC_VECTOR (31 downto 0);
       signal Pc_out :   STD_LOGIC_VECTOR (31 downto 0);
      
       
begin 
mux : mux2to1 port map(input1=>addet2mux ,input2=>incrementor2mux, sel=>PC_sel,output=>mux2Pc_reg);


adder4 : adder_plus4_incrementor port map( input=>Pc_out ,output=>addet2mux );


adder4_imm : incrementoradder4_imm port map( input=>addet2mux , imme=>PC_Immed , output=>incrementor2mux );

pc_reg : register32bit port map( clk => Clk , we=>PC_Lden ,rst=>Reset , datain=>mux2Pc_reg , dataout=> Pc_out);

Pc<=Pc_out;

end Behavioral;

