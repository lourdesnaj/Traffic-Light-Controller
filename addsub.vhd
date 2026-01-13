LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY addsub IS
	PORT(
		i_Ai, i_Bi	:IN STD_LOGIC_VECTOR(3 downto 0);
		AddSub	:IN STD_LOGIC;
		o_Sum :OUT STD_LOGIC_VECTOR(3 downto 0)	
		);
END addsub;

ARCHITECTURE struct of addsub IS
	SIGNAL int_Sum, int_CarryOut: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL b_invert :STD_LOGIC_VECTOR( 3 downto 0); 
	


	COMPONENT oneBitadder
		PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC
		
		);
	END COMPONENT;


BEGIN

b_invert <= i_Bi xor (AddSub & AddSub & AddSub & AddSub); 

add0: oneBitadder
	PORT MAP(
		i_CarryIn => AddSub,
		i_Ai => i_Ai(0),
		i_Bi => b_invert(0),
		o_Sum => int_Sum(0),
		o_CarryOut => int_CarryOut(0));
add1: oneBitadder
	PORT MAP(
		i_CarryIn => int_CarryOut(0),
		i_Ai => i_Ai(1),
		i_Bi => b_invert(1),
		o_Sum => int_Sum(1),
		o_CarryOut => int_CarryOut(1));
add2: oneBitadder
	PORT MAP(
		i_CarryIn => int_CarryOut(1),
		i_Ai => i_Ai(2),
		i_Bi => b_invert(2),
		o_Sum => int_Sum(2),
		o_CarryOut => int_CarryOut(2));
add3: oneBitadder
	PORT MAP(
		i_CarryIn => int_CarryOut(2),
		i_Ai => i_Ai(3),
		i_Bi => b_invert(3),
		o_Sum => int_Sum(3),
		o_CarryOut => int_CarryOut(3));
		
	o_Sum <= int_Sum;
	

END struct;