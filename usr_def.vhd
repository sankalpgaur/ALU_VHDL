LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

PACKAGE usr_def IS

   COMPONENT full_add 

      PORT(

          a      : IN STD_LOGIC;

          b      : IN STD_LOGIC;

          c_in   : IN STD_LOGIC;

          sum    : OUT STD_LOGIC;

          c_out  : OUT STD_LOGIC);

   END COMPONENT;

END usr_def;