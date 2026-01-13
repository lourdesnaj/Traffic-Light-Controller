LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_41_4 IS
	PORT(
		d0, d1, d2, d3	: IN	STD_LOGIC_VECTOR(3 downto 0);
		sel_1			: IN	STD_LOGIC;
		sel_0			: IN	STD_LOGIC;
		output			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END MUX_41_4;

ARCHITECTURE STRUCT OF MUX_41_4 IS
BEGIN

output <=
			d0 when (sel_1='0' and sel_0 = '0') else
			d1 when (sel_1='0' and sel_0 = '1') else
			d2 when (sel_1='1' and sel_0 = '0') else
			d3;

END STRUCT;

