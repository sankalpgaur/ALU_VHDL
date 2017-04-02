LIBRARY altera;

USE altera.maxplus2.carry;



library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



LIBRARY WORK;

USE WORK.usr_def.ALL;

entity cl_addr_4bit is
Port ( x_in : INOUT signed (3 downto 0);
y_in : INOUT signed (3 downto 0);
temp_in :    IN signed(3 DOWNTO 0);
c_in : in STD_LOGIC;
s : out signed (3 downto 0);
c_out : out STD_LOGIC;
key0 : IN std_logic;
key1 : IN std_logic);
end cl_addr_4bit;

architecture struct of cl_addr_4bit is

component partial_full_add
Port ( a : in STD_LOGIC;
b : in STD_LOGIC;
c_in : in STD_LOGIC;
s : out STD_LOGIC;
p : out STD_LOGIC;
g : out STD_LOGIC);
end component;

TYPE State_type IS (A, B);  

SIGNAL State : State_Type := B;
SIGNAL    c:    STD_LOGIC_VECTOR(3 DOWNTO 1);
signal p,g: STD_LOGIC_VECTOR(3 downto 0);

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
	 
	 
PFA1: partial_full_add port map( a(0), b(0), c_in, s(0), p(0), g(0));
PFA2: partial_full_add port map( a(1), b(1), c(1), s(1), p(1), g(1));
PFA3: partial_full_add port map( a(2), b(2), c(2), s(2), p(2), g(2));
PFA4: partial_full_add port map( a(3), b(3), c(3), s(3), p(3), g(3));

c(1) <= g(0) OR (p(0) AND c_in);
c(2) <= g(1) OR (P(1) AND g(0)) OR (p(1) AND p(0) AND c_in);
c(3) <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND c_in);
c_out <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) AND p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) AND c_in);
END struct;