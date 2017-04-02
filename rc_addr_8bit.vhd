LIBRARY altera;

USE altera.maxplus2.carry;



library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



LIBRARY WORK;

USE WORK.usr_def.ALL;



ENTITY rc_addr_8bit IS    

    PORT(

        x_in    :    INOUT signed(7 DOWNTO 0);

        y_in    :    INOUT signed(7 DOWNTO 0);

		  temp_in :    IN signed(7 DOWNTO 0);

        --disp 	 :		OUT signed(7 DOWNTO 0);

		  c_in    :    IN STD_LOGIC;

        sum     :    OUT signed(7 DOWNTO 0);

        c_out   :    OUT STD_LOGIC;

		  key0 : IN std_logic;

		  key1 : IN std_logic);

END rc_addr_8bit;



ARCHITECTURE struct OF rc_addr_8bit IS

SIGNAL im  :    unsigned(6 DOWNTO 0);

SIGNAL imi :    unsigned(6 DOWNTO 0);



TYPE State_type IS (A, B);  

SIGNAL State : State_Type := B;





BEGIN

	 input : process

	 begin

			

			if State = A then

				x_in <= temp_in;

				State <= B;

			else 

				y_in <= temp_in;

				State <= A;

			end if;

			wait on key0 until key0 = '1';

	 end process;

    c0   : full_add 

            PORT MAP (x_in(0),y_in(0),c_in,sum(0),im(0));

    c01  : carry 

           PORT MAP (im(0),imi(0));

    c    : FOR i IN 1 TO 6 GENERATE

            c1to6:  full_add PORT MAP (x_in(i),y_in(i),

            imi(i-1),sum(i),im(i));

            c11to12: carry PORT MAP (im(i),imi(i));

           END GENERATE;

    c3   : full_add PORT MAP (x_in(7),y_in(7),

           imi(6),sum(7),c_out);

END struct;