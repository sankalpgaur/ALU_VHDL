library ieee;
use ieee.std_logic_1164.all;
entity partial_full_add is
Port (a: in STD_LOGIC;
b : in STD_LOGIC;
c_in : in STD_LOGIC;
s : out STD_LOGIC;
p : out STD_LOGIC;
g : out STD_LOGIC);
end partial_full_add;

architecture behv of partial_full_add is

begin

s <= a xor b xor c_in;
p <= a xor b;
g <= a and b;

end behv;