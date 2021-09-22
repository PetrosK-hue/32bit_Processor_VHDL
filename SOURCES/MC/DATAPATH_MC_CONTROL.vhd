----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:32 05/18/2021 
-- Design Name: 
-- Module Name:    DATAPATH_MC_CONTROL - Behavioral 
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

entity DATAPATH_MC_CONTROL is
port	(	  Clk : in  STD_LOGIC;
			  Reset : in  STD_LOGIC;
			 --RAM USED OUTPUTS
			  tpl_inst_addr2RAM : out std_logic_vector(10 downto 0);
			  tpl_inst_dout2RAM : in std_logic_vector(31 downto 0);
			  tpl_data_we2RAM   : out std_logic;
			  tpl_data_addr2RAM : out std_logic_vector(10 downto 0);
			  tpl_data_din2RAM  : out std_logic_vector(31 downto 0); 
			  tpl_data_dout2RAM : in std_logic_vector(31 downto 0)		  
			  );
end DATAPATH_MC_CONTROL;

architecture Behavioral of DATAPATH_MC_CONTROL is
component DATAPATH_MC is
Port (     PC_sel : in  STD_LOGIC;
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
			  Flag : out STD_LOGIC;
			  
			  --RAM USED OUTPUTS
			  inst_addr2RAM : out std_logic_vector(10 downto 0);
			  inst_dout2RAM : in std_logic_vector(31 downto 0);
			  data_we2RAM   : out std_logic;
			  data_addr2RAM : out std_logic_vector(10 downto 0);
			  data_din2RAM  : out std_logic_vector(31 downto 0); 
			  data_dout2RAM : in std_logic_vector(31 downto 0)
			  );
end component;

component CONTROL_MC is
Port (     PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  Imm_Ext : out STD_LOGIC_VECTOR(1 downto 0);
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           AB_WrEn : out STD_LOGIC;
			  ALU_WrEn : out STD_LOGIC;
			  ALU_Bin_sel : out  STD_LOGIC;
			  Instr_WrEn : out STD_LOGIC;
			  MemReg_WrEn : out std_logic;   
           Byteop: out std_logic;
			  Mem_WrEn :out STD_LOGIC;
			  control_Reset:in STD_LOGIC;
			  Clk : in  STD_LOGIC;
			  Reset : out  STD_LOGIC;
			  Zero : in  STD_LOGIC;
			  Flag  : in  STD_LOGIC;
			  opcode : in STD_LOGIC_VECTOR (5 downto 0)
			  );
			  
end component ;




         signal tpl_PC_sel :   STD_LOGIC;
			signal tpl_Imm_Ext :  STD_LOGIC_VECTOR(1 downto 0);
         signal tpl_PC_LdEn :   STD_LOGIC;
         signal tpl_RF_WrData_sel :   STD_LOGIC;
         signal tpl_RF_WrEn :  STD_LOGIC;
			signal tpl_AB_WrEn : STD_LOGIC;
			signal tpl_ALU_WrEn : STD_LOGIC;
			signal tpl_Instr_WrEn :  STD_LOGIC;
			signal tpl_MemReg_WrEn :  std_logic;   
         signal tpl_RF_B_sel :   STD_LOGIC;
         signal tpl_Reset :   STD_LOGIC;
			signal tpl_ALU_Bin_sel :   STD_LOGIC;
			signal tpl_Byteop:  std_logic;
			signal tpl_Mem_WrEn :  STD_LOGIC;
			signal tpl_Opcode :  STD_LOGIC_VECTOR (5 downto 0);
			signal tpl_Zero :  STD_LOGIC;
			signal tpl_FLag   :  STD_LOGIC;
begin

uni_CONTROL_MC :  CONTROL_MC port map( PC_sel =>tpl_PC_sel,
													PC_LdEn =>tpl_PC_LdEn,
													Imm_Ext =>tpl_Imm_Ext,
													RF_WrData_sel =>tpl_RF_WrData_sel,
													RF_WrEn =>tpl_RF_WrEn,
													RF_B_sel =>tpl_RF_B_sel,
													AB_WrEn =>tpl_AB_WrEn, 
													ALU_WrEn =>tpl_ALU_WrEn,
													ALU_Bin_sel =>tpl_ALU_Bin_sel,
													Instr_WrEn =>tpl_Instr_WrEn, 
													MemReg_WrEn =>  tpl_MemReg_WrEn,
													Byteop =>tpl_Byteop,
													Mem_WrEn =>tpl_Mem_WrEn,
												   control_Reset =>Reset,
													Clk =>Clk,
													Reset =>tpl_Reset,
													Zero =>tpl_Zero,
													Flag =>tpl_FLag ,
													opcode =>tpl_opcode
													);

uni_DATAPATH_MC : DATAPATH_MC port map (PC_sel =>tpl_PC_sel,
													PC_LdEn =>tpl_PC_LdEn,
													Imm_Ext =>tpl_Imm_Ext,
													RF_WrData_sel =>tpl_RF_WrData_sel,
													RF_WrEn =>tpl_RF_WrEn,
													RF_B_sel =>tpl_RF_B_sel,
													AB_WrEn =>tpl_AB_WrEn, 
													ALU_WrEn =>tpl_ALU_WrEn,
													ALU_Bin_sel =>tpl_ALU_Bin_sel,
													Instr_WrEn =>tpl_Instr_WrEn, 
													MemReg_WrEn =>  tpl_MemReg_WrEn,
													Byteop =>tpl_Byteop,
													Mem_WrEn =>tpl_Mem_WrEn,
													Clk =>Clk,
													Reset =>tpl_Reset,
													Zero =>tpl_Zero,
													Flag =>tpl_FLag,
			

			Op_Code =>tpl_opcode,

			  --RAM USED OUTPUTS
			  inst_addr2RAM =>tpl_inst_addr2RAM,
			  inst_dout2RAM =>tpl_inst_dout2RAM,
			  data_we2RAM   =>tpl_data_we2RAM, 
			  data_addr2RAM =>tpl_data_addr2RAM,
			  data_din2RAM  =>tpl_data_din2RAM,
			  data_dout2RAM =>tpl_data_dout2RAM
			  );


end Behavioral;