LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBitCounter IS
    PORT(
        i_resetBar, i_inc  : IN  STD_LOGIC;
        i_clock            : IN  STD_LOGIC;
        o_Value            : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END fourBitCounter;

ARCHITECTURE rtl OF fourBitCounter IS
    SIGNAL int_a, int_b, int_c, int_d : STD_LOGIC;               
    SIGNAL int_na, int_nb, int_nc, int_nd : STD_LOGIC;           
    SIGNAL int_notA, int_notB, int_notC, int_notD : STD_LOGIC;  

    COMPONENT enARdFF_2
        PORT(
            i_resetBar : IN  STD_LOGIC;
            i_d        : IN  STD_LOGIC;
            i_enable   : IN  STD_LOGIC;
            i_clock    : IN  STD_LOGIC;
            o_q, o_qBar: OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    int_nd <= NOT(int_d);                                 
    int_nc <= int_c XOR int_d;                             
    int_nb <= int_b XOR (int_c AND int_d);                 
    int_na <= int_a XOR (int_b AND int_c AND int_d);       

   
    dff3: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_na,
            i_enable   => i_inc,
            i_clock    => i_clock,
            o_q        => int_a,
            o_qBar     => int_notA
        );

    dff2: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_nb,
            i_enable   => i_inc,
            i_clock    => i_clock,
            o_q        => int_b,
            o_qBar     => int_notB
        );

    dff1: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_nc,
            i_enable   => i_inc,
            i_clock    => i_clock,
            o_q        => int_c,
            o_qBar     => int_notC
        );

    dff0: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_nd,
            i_enable   => i_inc,
            i_clock    => i_clock,
            o_q        => int_d,
            o_qBar     => int_notD
        );

    o_Value <= int_a & int_b & int_c & int_d;

END rtl;