library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

 

entity ALU is

 Port ( 

 

 inp_a : INOUT signed(3 downto 0);

 inp_b : INOUT signed(3 downto 0);

 disp : OUT signed(3 downto 0);

 inp_c : IN signed(3 downto 0);

 

 sel : INOUT  signed(2 downto 0);

 out_ALU : INOUT signed(3 downto 0);

 key0 : IN std_logic;

 key1 : IN std_logic);

end ALU;

 

architecture Behavioral of ALU is



	TYPE State_type IS (A, B);  

	SIGNAL State : State_Type := B;

	

begin

	  

	input: process(key0)



	  BEGIN 

			IF rising_edge(key0) THEN    

			CASE State IS	

				WHEN A => 		 

						inp_a<=inp_c;

						disp<=inp_c;

						State <= B;

						

				WHEN B=> 

						inp_b<=inp_c;

						disp<=inp_c;

						State <= A; 

					

			END CASE; 

			END IF; 

  END PROCESS;



	arithmetic: process

	begin

		wait until (key1 = '1');

		sel <= inp_c(2 downto 0);

		case sel is

		 when "000" => 

		 out_ALU<= inp_a + inp_b; --addition 

		 when "001" => 

		 out_ALU<= inp_a - inp_b; --subtraction 

		 when "010" => 

		 out_ALU<= inp_a - 1; --sub 1 

		 when "011" => 

		 out_ALU<= inp_a + 1; --add 1 

		 when "100" => 

		 out_ALU<= inp_a and inp_b; --AND gate 

		 when "101" => 

		 out_ALU<= inp_a or inp_b; --OR gate 

		 when "110" => 

		 out_ALU<= not inp_a ; --NOT gate 

		 when "111" => 

		 out_ALU<= inp_a xor inp_b; --XOR gate 

		 when others =>

		 NULL;

		end case; 

	end process; 

 

end Behavioral;