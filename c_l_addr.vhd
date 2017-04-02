

library ieee;

use ieee.std_logic_1164.all;

use ieee.numeric_std.all;



ENTITY c_l_addr IS

    PORT

        (

         x_in      :  INOUT   STD_LOGIC_VECTOR(3 DOWNTO 0);

         y_in      :  INOUT   STD_LOGIC_VECTOR(3 DOWNTO 0);

			temp_in :    IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);

         carry_in  :  IN   STD_LOGIC;

         sum       :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);

         carry_out :  OUT  STD_LOGIC;

			clk		 :  IN   std_logic;

			key0 : IN std_logic

        );

END c_l_addr;



ARCHITECTURE behavioral OF c_l_addr IS



SIGNAL    h_sum              :    STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL    carry_generate     :    STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL    carry_propagate    :    STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(3 DOWNTO 1);



TYPE State_type IS (A, B);  

SIGNAL State : State_Type := B;

--constant CLK_FREQ    : integer := 50000000;

--constant BLINK_FREQ  : integer := 1;

--constant CNT_MAX     : integer := CLK_FREQ/BLINK_FREQ/2-1;

--

--signal   cnt         : unsigned(24 downto 0);

--signal   blink       : std_logic;



BEGIN

    h_sum <= x_in XOR y_in;

    carry_generate <= x_in AND y_in;

    carry_propagate <= x_in OR y_in;

	 

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

	 

    --adding : PROCESS (carry_generate,carry_propagate,carry_in_internal)

    --BEGIN

    carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND carry_in);

        inst: FOR i IN 1 TO 2 Generate

              carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));

              END Generate;

    carry_out <= carry_generate(3) OR (carry_propagate(3) AND carry_in_internal(3));

    --END PROCESS;

	 

--	 timing: process(clk)

--	 begin

--	 

--		if rising_edge(clk) then

--

--       if cnt=CNT_MAX then

--          cnt   <= (others => '0');

--          blink <= not blink;

--       else

--         cnt  <= cnt + 1;

--       end if;

--

--		end if;

--	 

--	 end process;

	

    sum(0) <= h_sum(0) XOR carry_in;

    sum(3 DOWNTO 1) <= h_sum(3 DOWNTO 1) XOR carry_in_internal(3 DOWNTO 1);

END behavioral;