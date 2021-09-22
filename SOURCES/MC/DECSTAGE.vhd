----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:15:14 04/09/2021 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
	 Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Reset : in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Structural of DECSTAGE is
signal data_AM : STD_LOGIC_VECTOR(31 downto 0);
signal read_reg2 : STD_LOGIC_VECTOR(4 downto 0);


component mux2rd is
    Port (  input1 : in STD_LOGIC_VECTOR(31 downto 0);
				input2 : in STD_LOGIC_VECTOR(31 downto 0);
            sel : in  STD_LOGIC;
            output : out  STD_LOGIC_VECTOR(31 downto 0)
			);
end component;

component Mux_2_rf is
    Port (  input1 : in STD_LOGIC_VECTOR(4 downto 0);
				input2 : in STD_LOGIC_VECTOR(4 downto 0);
            sel : in  STD_LOGIC;
            output : out  STD_LOGIC_VECTOR(4 downto 0)
			);
end component;

component registerFile32bit is
	Port (  clk : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_vector(4 downto 0);
           Ard2 : in  STD_LOGIC_vector(4 downto 0);
           WrEn : in  STD_LOGIC;
			  Reset : in std_logic;
           Awr : in  STD_LOGIC_vector(4 downto 0);
           Din : in  STD_LOGIC_vector(31 downto 0);
           Dout1 : out  STD_LOGIC_vector(31 downto 0);
           Dout2 : out  STD_LOGIC_vector(31 downto 0)
			 );
end component;

component ImmedModule is
	Port ( ImmInput : in  STD_LOGIC_VECTOR (15 downto 0);
           Imm_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           ImmOutput : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

begin

Mux1 : Mux_2_rf
		PORT MAP (input1 => Instr(15 downto 11), 
									input2 => Instr(20 downto 16), 
									sel => RF_B_sel, 
									output => read_reg2);
									
		Mux2 : mux2rd
		PORT MAP (input1 => MEM_out, 
									input2 => ALU_out, 
									sel => RF_WrData_sel, 
									output => data_AM);
									
			regFile : registerFile32bit
			PORT MAP (Ard1 => Instr(25 downto 21), 
										Ard2 => read_reg2, 
										Awr => Instr(20 downto 16), 
										Din=> data_AM,  
										WrEn => RF_WrEn,
                                Reset=>Reset	,								
										clk => Clk,
										Dout1 => RF_A,
										Dout2 => RF_B);

		ImmMod : ImmedModule
		PORT MAP (ImmInput => Instr(15 downto 0),
									Imm_Ext => ImmExt,
									ImmOutput => 		Immed);
		
end Structural;