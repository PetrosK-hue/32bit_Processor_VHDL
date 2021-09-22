----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:49 05/18/2021 
-- Design Name: 
-- Module Name:    EX_DEC_Module - Behavioral 
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

entity EX_DEC_Module is
Port (   
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  
			  AB_WrEn : in STD_LOGIC;
			  ALU_WrEn : in STD_LOGIC;
			  Instr_WrEn : in STD_LOGIC;
			  
			 RF_WrData_sel : in  STD_LOGIC;
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
			 ALU_Bin_sel : in STD_LOGIC;
           Imm_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Reset : in std_logic;
			  ALU_MEM_ADDR : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_Bb : out std_logic_vector(31 downto 0);
			  Immed_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Zero_out : out std_logic
			 -- flag: out std_logic
			  
			  );

end EX_DEC_Module;

architecture Behavioral of EX_DEC_Module is

 component EXSTAGE is
	Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
            RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
            Immed : in  STD_LOGIC_VECTOR (31 downto 0);
            ALU_Bin_sel : in  STD_LOGIC;
            Opcode : in STD_LOGIC_VECTOR (5 downto 0);
            ALU_func: in  STD_LOGIC_vector(3 downto 0);
            ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
				ALU_zero : out STD_LOGIC
			    );
end component;

component  DECSTAGE is
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
end component;

component register32bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           datain : in  STD_LOGIC_vector(31 downto 0);
           dataout : out  STD_LOGIC_vector(31 downto 0)
			  );
end component;



signal ALU_out_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_out_sig : STD_LOGIC_VECTOR(31 downto 0);
--signal MEM_ou_sig : STD_LOGIC_VECTOR(31 downto 0);
signal Immed_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal Instr_sig : STD_LOGIC_VECTOR(31 downto 0);

begin

Immed_out<=Immed_sig;
ALU_MEM_ADDR <= ALU_out_sig_reg;
RF_Bb <=RF_B_sig_reg;

Toplevel_DECSTAGE : DECSTAGE  port map(Instr =>Instr_sig,
													RF_WrEn =>RF_WrEn,
													ALU_out =>ALU_out_sig_reg,
													MEM_out =>MEM_out,
													RF_WrData_sel =>RF_WrData_sel,
													RF_B_sel =>RF_B_sel,
													ImmExt => Imm_Ext,
													Clk =>Clk,
													Reset =>Reset,
													Immed =>Immed_sig,
													RF_A =>RF_A_sig,
													RF_B =>RF_B_sig
													);
												

Toplevel_EXSTAGE : EXSTAGE port map (	RF_A =>RF_A_sig_reg,
													RF_B =>RF_B_sig_reg,
													Immed =>Immed_sig,
													ALU_Bin_sel =>ALU_Bin_sel,
													Opcode => Instr(31 downto 26),
													ALU_func =>Instr(3 downto 0),
													ALU_out =>ALU_out_sig,
													ALU_zero =>Zero_out
														  	);

-----------------------------------------------registers-------------------

REG_A : register32bit port map(  clk =>Clk,
											we =>AB_WrEn,
											rst =>Reset,
											datain =>RF_A_sig,
											dataout =>RF_A_sig_reg
											);

REG_B : register32bit port map(  clk =>Clk,
											we =>AB_WrEn,
											rst =>Reset,
											datain =>RF_B_sig,
											dataout =>RF_B_sig_reg
											);
	
	
reg_ALU: register32bit port map(  clk =>Clk,
											we =>ALU_WrEn,
											rst =>Reset,
											datain =>ALU_out_sig,
											dataout =>ALU_out_sig_reg
									    	); 	
											
reg_Instr: register32bit port map( clk =>Clk,
											we =>Instr_WrEn,
											rst =>Reset,
											datain =>Instr,
											dataout =>Instr_sig
									    	);		
											



end Behavioral;

