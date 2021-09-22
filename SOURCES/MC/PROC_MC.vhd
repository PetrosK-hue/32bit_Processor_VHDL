----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:14 05/18/2021 
-- Design Name: 
-- Module Name:    PROC_MC - Behavioral 
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

entity PROC_MC is
			Port ( Clk : in  STD_LOGIC;
         Reset : in  STD_LOGIC);
end PROC_MC;

architecture Behavioral of PROC_MC is

component DATAPATH_MC_CONTROL is
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
end component;

component RAM is
    Port ( Clk : in  STD_LOGIC;
           inst_addr : in  STD_LOGIC_vector(10 downto 0);
           inst_dout  : out  STD_LOGIC_vector(31 downto 0);
           data_we  : in  STD_LOGIC;
           data_addr : in  STD_LOGIC_vector(10 downto 0);
           data_din : in  STD_LOGIC_vector(31 downto 0);
           data_dout : out STD_LOGIC_vector(31 downto 0)
			  );
end component;

 			  signal p_inst_addr2RAM :  std_logic_vector(10 downto 0);
			  signal p_inst_dout2RAM :  std_logic_vector(31 downto 0);
			  signal p_data_we2RAM   :  std_logic;
			  signal p_data_addr2RAM :  std_logic_vector(10 downto 0);
			  signal p_data_din2RAM  :  std_logic_vector(31 downto 0); 
			  signal p_data_dout2RAM :  std_logic_vector(31 downto 0);
begin


proc_DATAPATH_MC_CONTROL : DATAPATH_MC_CONTROL port map	(	 Clk => Clk,
																		Reset => Reset,
																		tpl_inst_addr2RAM =>p_inst_addr2RAM ,
																		tpl_inst_dout2RAM =>p_inst_dout2RAM,
																		tpl_data_we2RAM   =>p_data_we2RAM ,
																		tpl_data_addr2RAM =>p_data_addr2RAM,
																		tpl_data_din2RAM  =>p_data_din2RAM ,
																		tpl_data_dout2RAM =>p_data_dout2RAM		  
			  );

proc_RAM : RAM port map (Clk =>Clk,
								inst_addr =>p_inst_addr2RAM ,
								inst_dout =>p_inst_dout2RAM,
								data_we  =>p_data_we2RAM ,
								data_addr =>p_data_addr2RAM,
								data_din =>p_data_din2RAM ,
								data_dout =>p_data_dout2RAM
			  );


end Behavioral;

