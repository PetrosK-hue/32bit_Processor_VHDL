----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:39 05/18/2021 
-- Design Name: 
-- Module Name:    DATAPATH_MC - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH_MC is
Port ( PC_sel : in  STD_LOGIC;
			  Imm_Ext : in STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  AB_WrEn : in STD_LOGIC;
			  ALU_WrEn : in STD_LOGIC;
			  Instr_WrEn : in STD_LOGIC;
			  MemReg_WrEn : in std_logic;   
           RF_B_sel : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			 ALU_Bin_sel : in  STD_LOGIC;
				Byteop: in std_logic;
			  Mem_WrEn : in STD_LOGIC;
			  Op_Code : out STD_LOGIC_VECTOR (5 downto 0);
			  Zero : out STD_LOGIC;
			  Flag: out std_logic;
			  
			  --RAM USED OUTPUTS
			  inst_addr2RAM : out std_logic_vector(10 downto 0);
			  inst_dout2RAM : in std_logic_vector(31 downto 0);
			  data_we2RAM   : out std_logic;
			  data_addr2RAM : out std_logic_vector(10 downto 0);
			  data_din2RAM  : out std_logic_vector(31 downto 0); 
			  data_dout2RAM : in std_logic_vector(31 downto 0)
			  );



end DATAPATH_MC;

architecture Behavioral of DATAPATH_MC is

component EX_DEC_Module is
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
			 -- Flag: out std_logic;
			  Zero_out : out std_logic
			        );
 end component;

component IFSTAGE is
    Port ( PC_Immed : in  std_logic_vector(31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_Lden : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Pc : out  std_logic_vector(31 downto 0)
			   );

end component;

component register32bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           datain : in  STD_LOGIC_vector(31 downto 0);
           dataout : out  STD_LOGIC_vector(31 downto 0)
			  );
end component;

	component mux_1to1 is
    Port ( input : in  STD_LOGIC_vector(31 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC);

end component;
component Valid_Instr is
    Port ( Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           AddressFlag : out  STD_LOGIC);
end component;

signal dp_MEM_out: STD_LOGIC_vector(31 downto 0);
signal dp_MEM_out_mod: STD_LOGIC_vector(31 downto 0);
signal dp_RF_Bb: STD_LOGIC_vector(31 downto 0);
signal dp_RF_Bb_mod: STD_LOGIC_vector(31 downto 0);
signal dp_immed: STD_LOGIC_vector(31 downto 0);
signal dp_zero:STD_LOGIC;
signal dp_PC_sel:STD_LOGIC;
signal PC_to_RAM: STD_LOGIC_vector(31 downto 0);
signal dp_ALU_MEM_ADDR : STD_LOGIC_VECTOR (31 downto 0);
signal alu_mem : unsigned (10 downto 0);
signal temp : STD_LOGIC_vector (10 downto 0);


begin
Zero <= dp_zero;
temp <= dp_ALU_MEM_ADDR(12 downto 2);
	alu_mem <= unsigned(temp) + 1024;
	Op_Code <= inst_dout2RAM(31 downto 26);
	dp_PC_sel <= PC_Sel AND (NOT dp_zero);
	
	
DATAPATH_EX_DEC_Module : EX_DEC_Module  port map (Instr =>inst_dout2RAM,
														  RF_B_sel =>RF_B_sel,
														  RF_WrEn => RF_WrEn ,
															AB_WrEn =>AB_WrEn ,
															ALU_WrEn =>ALU_WrEn,
															Instr_WrEn =>Instr_WrEn ,
															RF_WrData_sel =>RF_WrData_sel,
															MEM_out =>dp_MEM_out_mod,
															 ALU_Bin_sel => ALU_Bin_sel,
															Imm_Ext =>Imm_Ext,
															Clk =>Clk,
															Reset =>Reset,
															ALU_MEM_ADDR =>dp_ALU_MEM_ADDR,
															RF_Bb =>dp_RF_Bb,
															Immed_out =>dp_immed,
															Zero_out =>dp_zero
														--	flag =>Flag
															
																);
																
DATAPATH_IFSTAGE : IFSTAGE port map ( PC_Immed =>dp_immed,
												PC_sel =>dp_PC_sel,------
												PC_Lden =>PC_Lden,
												Reset =>Reset,
												Clk =>Clk,
												Pc =>PC_to_RAM
												);																
																



storeselector: mux_1to1	
				port map( input =>dp_RF_Bb,
							output =>dp_RF_Bb_mod,
							sel => Byteop
								);
		
loadselector: mux_1to1	
				port map( input =>data_dout2RAM,
							output =>dp_MEM_out,
								sel => Byteop
									);		



reg_MEM : register32bit 
    Port map( clk =>Clk,
           we =>MemReg_WrEn ,
			  rst =>Reset,
           datain =>dp_MEM_out,
           dataout =>dp_MEM_out_mod
			  );

ValidInstr_MC : Valid_Instr port map (Addr =>inst_dout2RAM ,
                                           AddressFlag =>Flag);

	inst_addr2RAM <= PC_to_Ram(12 downto 2); 
	data_we2RAM <= Mem_WrEn;
   data_addr2RAM <= STD_LOGIC_VECTOR(alu_mem);
	--data_addr2RAM <=STD_LOGIC_VECTOR(temp);
	data_din2RAM <= dp_RF_Bb_mod;


end Behavioral;