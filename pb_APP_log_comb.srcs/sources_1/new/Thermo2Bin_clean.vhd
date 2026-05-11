--------------------------------------------------------------------------
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

------ signaux ---------------
signal temp : std_logic_vector(3 downto 0);
signal is_erreur,Cout : std_logic;
signal nb1_1,nb1_2,nb1_3 : std_logic_vector (2 downto 0);
signal nb1_1_inter,nb1_2_inter,nb1_3_inter,nb1_12  : std_logic_vector (3 downto 0);

-------------- components ----------------------
component compteurDe1_4bit is
    Port ( Adcth : in STD_LOGIC_VECTOR (3 downto 0);
           nb1 : out STD_LOGIC_VECTOR (2 downto 0));
end component compteurDe1_4bit;

component Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC;
           Ci : in STD_LOGIC);
end component Add4bits;

------------begin--------------
begin
-------------------compteur de 1 total ------------------------
nb1_1_inter <= '0' & nb1_1;
nb1_2_inter <= '0' & nb1_2;
nb1_3_inter <= '0' & nb1_3;

inst_compteur_1 : compteurDe1_4bit
port map (
        Adcth => Adcth(3 downto 0) ,
        nb1 => nb1_1
);

inst_compteur_2 : compteurDe1_4bit
port map (
        Adcth => Adcth(7 downto 4) ,
        nb1 => nb1_2
);			

inst_compteur_3 : compteurDe1_4bit
port map (
        Adcth => Adcth(11 downto 8) ,
        nb1 => nb1_3
);

inst_Add4bits_1 : Add4bits
port map (
        X  => nb1_1_inter,
        Y  => nb1_2_inter,
        S  => nb1_12,
        Co => Cout,
        Ci => '0'
);

inst_Add4bits_2 : Add4bits
port map (
        X  => nb1_12,
        Y  => nb1_3_inter,
        S  => Adcbin,
        Co => open,
        Ci => Cout
);

-----------------erreur------------------------

is_erreur <= (not ADCth(0) and ADCth(1)) or
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

erreur <= is_erreur;


end Behavioral;