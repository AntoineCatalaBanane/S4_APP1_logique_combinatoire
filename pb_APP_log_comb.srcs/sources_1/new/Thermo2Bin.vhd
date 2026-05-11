----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2026 11:39:21 AM
-- Design Name: 
-- Module Name: Thermo2Bin - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Thermo2Bin is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end Thermo2Bin;

architecture Behavioral of Thermo2Bin is
signal temp : std_logic_vector(3 downto 0);


begin

temp(0) <= (ADCth(0) and not ADCth(1)) or
           (ADCth(2) and not ADCth(3)) or
           (ADCth(4) and not ADCth(5)) or
           (ADCth(6) and not ADCth(7)) or
           (ADCth(8) and not ADCth(9)) or
           (ADCth(10) and not ADCth(11));
           
temp(1) <= (ADCth(1) and not ADCth(3)) or
           (ADCth(5) and not ADCth(7)) or
           (ADCth(9) and not ADCth(11));

temp(2) <= (ADCth(3) and not ADCth(7)) or
           (ADCth(11));
 
temp(3) <= ADCth(7);

ADCbin <= temp; 

erreur <= (not ADCth(0) and ADCth(1)) or
         (not ADCth(1) and ADCth(2)) or
         (not ADCth(2) and ADCth(3)) or
         (not ADCth(3) and ADCth(4)) or
         (not ADCth(4) and ADCth(5)) or
         (not ADCth(5) and ADCth(6)) or
         (not ADCth(6) and ADCth(7)) or
         (not ADCth(7) and ADCth(8)) or
         (not ADCth(8) and ADCth(9)) or
         (not ADCth(9) and ADCth(10)) or
         (not ADCth(10) and ADCth(11));          



    process(ADCth)
    
    begin   
        
   end process;


end Behavioral;
