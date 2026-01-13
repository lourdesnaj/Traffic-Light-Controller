LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm_controller IS
	PORT(
		i_CE, i_SSCS, i_clk, i_resetBar			: IN	STD_LOGIC;
		o_y1, o_y0, o_Ny1, o_Ny0		: OUT	STD_LOGIC;
		o_MSTL, o_SSTL : OUT STD_LOGIC_VECTOR(2 downto 0));
END fsm_controller;

ARCHITECTURE rtl OF fsm_controller IS
	SIGNAL int_y1, int_Ny1, int_y0, int_Ny0 : STD_LOGIC;
	SIGNAL int_A1, int_A2, int_A3 : STD_LOGIC;
	SIGNAL int_B1, int_B2, int_B3 : STD_LOGIC;

	COMPONENT enARdFF_2
			PORT(
				i_resetBar	: IN	STD_LOGIC;
				i_d		: IN	STD_LOGIC;
				i_enable	: IN	STD_LOGIC;
				i_clock		: IN	STD_LOGIC;
				o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
	BEGIN
	
	int_A1 <= NOT(i_CE) and int_y1;
	int_A2 <= int_y1 and int_Ny0;
	int_A3 <= int_Ny1 and int_y0 and i_CE;
	
	int_B1 <= int_y0 and NOT(i_CE);
	int_B2 <= int_Ny0 and i_CE and i_SSCS;
	int_B3 <= int_y1 and int_Ny0 and i_CE;
	
	
	dFF1: enARdFF_2 PORT MAP (
				i_resetBar => i_resetBar,
				i_d => int_A1 OR int_A2 OR int_A3,
				i_enable	=> '1',
				i_clock => i_clk,
				o_q => int_y1,
				o_qBar => int_Ny1);
				
	dFF2: enARdFF_2 PORT MAP (
				i_resetBar => i_resetBar,
				i_d => int_B1 OR int_B2 OR int_B3,
				i_enable	=> '1',
				i_clock => i_clk,
				o_q => int_y0,
				o_qBar => int_Ny0);
				
	o_MSTL(2) <= int_y1;
	o_MSTL(1) <= int_Ny1 and int_y0;
	o_MSTL(0) <= int_Ny1 and int_Ny0;
	
	
	o_SSTL(2) <= int_Ny1;
	o_SSTL(1) <= int_y1 and int_y0;
	o_SSTL(0) <= int_y1 and int_Ny0;
	
	
	o_y1 <= int_y1;
	o_y0 <= int_y0;
	o_Ny1 <= int_Ny1;
	o_Ny0 <= int_Ny0;
	
END rtl;