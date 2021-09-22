----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:27:29 04/09/2021 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
	Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
            Immed : in  STD_LOGIC_VECTOR (31 downto 0);
            ALU_Bin_sel : in  STD_LOGIC;
            Opcode : in STD_LOGIC_VECTOR (5 downto 0);
            ALU_func: in  STD_LOGIC_vector(3 downto 0);
            ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
				ALU_zero : out STD_LOGIC
			    );
end EXSTAGE;

architecture Behavioral of EXSTAGE is
	
		component ALU
		 Port ( A : in  STD_LOGIC_vector(31 downto 0);
				  B : in  STD_LOGIC_vector(31 downto 0);
              Opcode : in STD_LOGIC_VECTOR (5 downto 0);
              alu_func: in  STD_LOGIC_vector(3 downto 0);
				  Outt : out  STD_LOGIC_vector(31 downto 0);
              Zero : out  STD_LOGIC;
              Cout : out  STD_LOGIC;
              Ovf : out  STD_LOGIC);
end component;
	
		component mux2rd is
      Port (  input1 : in STD_LOGIC_VECTOR(31 downto 0);
				     input2 : in STD_LOGIC_VECTOR(31 downto 0);
                 sel : in  STD_LOGIC;
                 output : out  STD_LOGIC_VECTOR(31 downto 0)
			);
end component;
    
		signal mux2alu: std_logic_vector(31 downto 0);
		signal ex_Cout: std_logic;   --not connected with module
		signal ex_Ovf: std_logic;		 --not connected with module
		--signal c: std_logic_vector(1 downto 0);
begin
			mux : mux2rd
					     port map(input1=> RF_B,
												 input2 => Immed,
												 sel  => ALU_Bin_sel,
												 output => mux2alu);
												 
			ALU_module :  ALU 
						  port map(A => RF_A,
												  B => 	mux2alu,
												  alu_func =>ALU_func,
                                      Outt =>ALU_out,
												  Opcode =>Opcode,
                                      Zero =>ALU_zero,
                                      Cout => ex_Cout,
                                      Ovf =>	ex_Ovf);					 
						  

end Behavioral;

