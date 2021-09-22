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
			  pcld : in std_logic;
			  pcldout : out std_logic;
			  
			  AB_WrEn : in STD_LOGIC;
			  RT_WrEn : in STD_LOGIC;
			  RS_WrEn : in STD_LOGIC;
			  RD_WrEn : in STD_LOGIC;
			  WRA_WrEn : in STD_LOGIC;
			  BAfter_WrEn : in STD_LOGIC;
			  Imm_WrEn : in STD_LOGIC;
			  ALU_WrEn : in STD_LOGIC;
			  ALUAfter_WrEn : in STD_LOGIC;
			  Instr_WrEn : in STD_LOGIC;
			  PC_sig : in std_logic_vector(31 downto 0);
			  RFWr1_WrEn : in std_logic;
			  RFWr2_WrEn : in std_logic;
			  RFWr3_WrEn : in std_logic;
			  RFWr4_WrEn : in std_logic;
			  RS2_WrEn : in std_logic;
			  RT2_WrEn : in std_logic;
			  toMem_WrEn : in std_logic;
			  OP_WrEn : in std_logic;
			  OP2_WrEn : in std_logic;
			  ALUBin_WrEn : in std_logic;
			  Dest_WrEn : in std_logic;
			  RFWrSel_WrEn : in std_logic;
			  RFWrSel2_WrEn : in std_logic;
			  RFWrSel3_WrEn : in std_logic;
			  WRA2_WrEn : in std_logic;
			  ImmExt_WrEn : in std_logic; 
           RF_WrData_sel : in  STD_LOGIC;
			  memforw : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
           Imm_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Reset : in std_logic;
			  ALU_MEM_ADDR : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_Bb : out std_logic_vector(31 downto 0);
			  Immed_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Zero_out : out std_logic 
			  
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
			  WriteAfter_1: in  STD_LOGIC_VECTOR (4 downto 0);
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			   Reset : in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  Mux_out : out  STD_LOGIC_VECTOR (31 downto 0));

end component;

component register32bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           datain : in  STD_LOGIC_vector(31 downto 0);
           dataout : out  STD_LOGIC_vector(31 downto 0)
			  );
end component;

component register1bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           datain : in  STD_LOGIC;
           dataout : out  STD_LOGIC
			  );
end component;

component register2bit is
  	port ( clk     : in std_logic;
			 we      : in std_logic;
			 reset   : in std_logic;
			 datain  : in std_logic_vector(1 downto 0);
			 dataout : out std_logic_vector(1 downto 0)
			  );
end component;

component register5bit is
 	port ( clk     : in std_logic;
			 we      : in std_logic;
			 reset   : in std_logic;
			 datain  : in std_logic_vector(4 downto 0);
			 dataout : out std_logic_vector(4 downto 0)
			  );
end component;

component register6bit is
 	port ( clk     : in std_logic;
			 we      : in std_logic;
			 reset   : in std_logic;
			 datain  : in std_logic_vector(5 downto 0);
			 dataout : out std_logic_vector(5 downto 0)
			  );
end component;


component Mux_2_rf is
   Port (  input1 : in STD_LOGIC_VECTOR(4 downto 0);
				input2 : in STD_LOGIC_VECTOR(4 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(4 downto 0)
			);
end component;

component MUX4to1 is
    Port ( input1 : in  STD_LOGIC_Vector(31 downto 0);
           input2 : in  STD_LOGIC_Vector(31 downto 0);
           input3 : in  STD_LOGIC_Vector(31 downto 0);
           input4 : in  STD_LOGIC_Vector(31 downto 0);
           sel : in  STD_LOGIC_Vector(1 downto 0);
           output :out  STD_LOGIC_Vector(31 downto 0));
end component;

component forwardingUnit is
    Port ( RsIn : in  STD_LOGIC_VECTOR (4 downto 0);
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
			  end component;
			  
component stallsUnit is
 Port ( opCode : in  STD_LOGIC_VECTOR (5 downto 0);
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
			  
			   end component;



------------------------------------------------------------
signal ALU_out_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_out_sig : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_out_sig_regafter: STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_sig_reg : STD_LOGIC_VECTOR(31 downto 0);
signal Instr_sig : STD_LOGIC_VECTOR(31 downto 0);
signal sig_RF_WrEnOut1 : std_logic;
signal sig_RF_WrEnOut2 : std_logic;
signal sig_RF_WrEnOut3 : std_logic;
signal sig_RF_WrEnOut4 : std_logic;
signal RF_WrData_selAfter1 : STD_LOGIC;
signal RF_WrData_selAfter2 : STD_LOGIC;
signal RF_WrData_selAfter3 : STD_LOGIC;
signal sig_Immed_out_after : STD_LOGIC_VECTOR(31 downto 0);
signal sig_Immed_out : STD_LOGIC_VECTOR(31 downto 0);
signal sig_Imm_Ext: STD_LOGIC_VECTOR(1 downto 0); 
signal sig_OpCode2 : STD_LOGIC_VECTOR(5 downto 0); 
signal sig_OpCode1 : STD_LOGIC_VECTOR(5 downto 0); 
signal sig_ALU_Bin_sel: STD_LOGIC;
signal sig_RF_B_sel : STD_LOGIC;
signal SigWriteAfter: STD_LOGIC_VECTOR(4 downto 0); 
signal SigWriteAfter1: STD_LOGIC_VECTOR(4 downto 0); 
signal SigWriteAfter2: STD_LOGIC_VECTOR(4 downto 0); 
signal Mux_out_sig : STD_LOGIC_VECTOR(31 downto 0);
signal RF_A_mux : STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_mux: STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_muxafter: STD_LOGIC_VECTOR(31 downto 0);
signal Asel : STD_LOGIC_VECTOR(1 downto 0); 
signal Bsel : STD_LOGIC_VECTOR(1 downto 0); 
signal pcldtemp : STD_LOGIC;
signal rf_real: STD_LOGIC;
signal Instr_WrEnA : std_logic; 
----------------------------------------------------
signal  rfreal : std_logic;
 signal SigRTAfter : std_logic_vector(4 downto 0);
 signal SigRDAfter : STD_LOGIC_VECTOR(4 downto 0);
 signal SigRSAfter : STD_LOGIC_VECTOR(4 downto 0);


begin
pcldout <= pcldtemp;
 RF_Bb <= RF_B_muxafter;
Immed_out<=sig_Immed_out_after;
ALU_MEM_ADDR <= ALU_out_sig_reg;

--------------------------------------------------

Toplevel_DECSTAGE : DECSTAGE  port map(Instr =>Instr_sig,
													RF_WrEn =>sig_RF_WrEnOut4,
													ALU_out =>ALU_out_sig_regafter,
													MEM_out =>MEM_out,
													RF_WrData_sel =>RF_WrData_selAfter3,
													WriteAfter_1 =>SigWriteAfter2, ---
													Mux_out =>Mux_out_sig,
													ImmExt => sig_Imm_Ext,
													Clk =>Clk,
													Reset =>Reset,
													Immed =>sig_Immed_out,
													RF_A =>RF_A_sig,
													RF_B =>RF_B_sig
													);
												

Toplevel_EXSTAGE : EXSTAGE port map (	RF_A =>RF_A_mux,
													RF_B =>RF_B_mux,
													Immed =>sig_Immed_out_after,
													ALU_Bin_sel =>sig_ALU_Bin_sel,
													Opcode => sig_OpCode1 ,
													ALU_func =>sig_Immed_out_after(3 downto 0),
													ALU_out =>ALU_out_sig,
													ALU_zero =>Zero_out
														  	);



--------------------------RF_WrData REG------------------------------------
--RfWriteDataSel 3 delay stages
REG_RFWrSel1 : register1bit PORT MAP (clk => clk, we => RFWrSel_WrEn, reset => Reset, datain => RF_WrData_sel, dataout => RF_WrData_selAfter1);

REG_RFWrSel2 : register1bit PORT MAP (clk => clk, we => RFWrSel2_WrEn, reset => Reset, datain => RF_WrData_selAfter1, dataout => RF_WrData_selAfter2);

REG_RFWrSel3 : register1bit PORT MAP (clk => clk, we => RFWrSel3_WrEn, reset => Reset, datain => RF_WrData_selAfter2, dataout => RF_WrData_selAfter3);

------------------ RF_WrEN ReG---------------------------------------------
--RfWriteDataSel 4 delay stages
REG_rfWrite1 : register1bit PORT MAP (clk => clk, we => RFWr1_WrEn, reset => Reset, datain => rf_real, dataout => sig_RF_WrEnOut1); 

REG_rfWrite2 : register1bit PORT MAP (clk => clk, we => RFWr2_WrEn, reset => Reset, datain => sig_RF_WrEnOut1, dataout => sig_RF_WrEnOut2);

REG_rfWrite3 : register1bit PORT MAP (clk => clk, we => RFWr3_WrEn, reset => Reset, datain => sig_RF_WrEnOut2, dataout => sig_RF_WrEnOut3);

REG_rfWrite4 : register1bit PORT MAP (clk => clk, we => RFWr4_WrEn, reset => Reset, datain => sig_RF_WrEnOut3, dataout => sig_RF_WrEnOut4);

-----------------------------------------------registers-------------------
REG_OP : register6bit PORT MAP (clk => clk, we => OP_WrEn, reset => Reset, datain => Instr_sig(31 downto 26), dataout =>sig_OpCode1); 

REG_OP2 : register6bit PORT MAP (clk => clk, we => OP2_WrEn, reset => Reset, datain => sig_OpCode1, dataout => sig_OpCode2);

REG_Instr: register32bit port map( clk =>Clk,we =>Instr_WrEnA,rst =>Reset,datain =>Instr,dataout =>Instr_sig);
--------------------------------------------------------------------------------------------------------
REG_Dest : register1bit PORT MAP (clk => clk, we => Dest_WrEn, reset => Reset, dataIn => RF_B_sel, dataOut => sig_RF_B_sel);


REG_ImmExtSel : register2bit PORT MAP (clk => clk, we => ImmExt_WrEn, reset => Reset, datain => Imm_Ext, dataout => sig_Imm_Ext);

REG_Imm : register32bit PORT MAP (clk => clk, we => Imm_WrEn, rst => Reset, datain => sig_Immed_out, dataout => sig_Immed_out_after);
---------------------------------------------------------------------------------------------------------------------
REG_RT : register5bit PORT MAP (clk => clk, we => RT_WrEn, reset => Reset, datain => Instr_sig(15 downto 11), dataout => SigRTAfter);

REG_RS : register5bit PORT MAP (clk => clk, we => RS_WrEn, reset => Reset, datain => Instr_sig(25 downto 21), dataout => SigRSAfter);

REG_RD : register5bit PORT MAP (clk => clk, we => RD_WrEn, reset => Reset, datain => Instr_sig(20 downto 16), dataout => SigRDAfter);


-------------------------------------------------------------------ALU_REG-----------------------------------------------------------
	
REG_ALU: register32bit port map(  clk =>Clk,we =>ALU_WrEn,rst =>Reset,datain =>ALU_out_sig,dataout =>ALU_out_sig_reg); 	

REG_ALUAfter : register32bit PORT MAP (clk => clk, we => ALUAfter_WrEn, rst => Reset, datain => ALU_out_sig_reg, dataout => ALU_out_sig_regafter);
										
REG_A : register32bit port map(  clk =>Clk,we =>AB_WrEn,rst =>Reset,datain =>RF_A_sig,dataout =>RF_A_sig_reg);

REG_B : register32bit port map(  clk =>Clk,we =>AB_WrEn,rst =>Reset,datain =>RF_B_sig,dataout =>RF_B_sig_reg);											

REG_ALUBinSel : register1bit PORT MAP (clk => clk, we => ALUBin_WrEn, reset => Reset, datain => ALU_Bin_sel, dataout => sig_ALU_Bin_sel);

REG_Bafter : register32bit PORT MAP (clk => clk, we => BAfter_WrEn, rst => Reset, dataIn => RF_B_mux, dataOut => RF_B_muxafter);
----------------------------------------------------------------------------

REG_WriteA1 : register5bit PORT MAP (clk => clk, we => WRA_WrEn, reset => Reset, dataIn => SigWriteAfter, dataOut => SigWriteAfter1);

REG_WriteA2 : register5bit PORT MAP (clk => clk, we => WRA2_WrEn, reset => Reset, dataIn => SigWriteAfter1, dataOut => SigWriteAfter2);



MUX_A : MUX4to1 PORT MAP ( input1 => RF_A_sig_reg,
								   input2 => Mux_out_sig,
									input3 => ALU_out_sig_reg,
									input4 => memforw,
									sel => Asel,
									output => RF_A_mux
											  );
											  
MUX_B : MUX4to1 PORT MAP ( input1 =>RF_B_sig_reg ,
									input2 => Mux_out_sig,
									input3 => ALU_out_sig_reg,
									input4 => memforw,
									sel => Bsel,
									output => RF_B_mux
											  );

forwUnit : forwardingUnit PORT MAP( RsIn => SigRSAfter,
												RtIn => SigRTAfter,
												RdIn => SigRDAfter,
												RegWriteS1 => sig_RF_WrEnOut2,
											   RegWriteS2 => sig_RF_WrEnOut3,
												toMem_WrEn => toMem_WrEn,
												RdEx => SigWriteAfter1,
												RdMem => SigWriteAfter2,
												opCode => sig_OpCode2,
												Aout => Asel,
												Bout => Bsel
											  );
											  

stallUnit : stallsUnit PORT MAP ( opCode => sig_OpCode1,
											 ifRS => Instr_sig(25 downto 21),
											 ifRT => Instr_sig(15 downto 11),
											 idRD => SigRDAfter,
											 pcld => pcld,
											 pcldout => pcldtemp,
										    rfwritein => RF_WrEn,
											 rfwriteout => rf_real,
											 instrwren => Instr_WrEn,
											 instrwrenout => Instr_WrEnA
											 );
											  								  

MUX_Write : Mux_2_rf PORT MAP (input1 => SigRDAfter, input2 => SigRTAfter,
	
								sel => sig_RF_B_sel, output => SigWriteAfter);

end Behavioral;
