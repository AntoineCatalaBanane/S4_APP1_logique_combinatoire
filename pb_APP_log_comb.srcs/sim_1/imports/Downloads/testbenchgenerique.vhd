----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2019 08:34:20 PM
-- Design Name: 
-- Module Name: testBench - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;

--> L'entity du test bench est vide et elle doit le demeurer
--> L'entity peut porter le nom que vous voulez mais il est de bonne pratique 
--> d'utiliser le nom du module � tester avec un suffixe par exemple.

ENTITY Top_tb IS          --> Remarquez que l'ENTITY est vide et doit le demeurer pour un test bench !!!  
END Top_tb;


ARCHITECTURE behavioral OF Top_tb IS 

--> Remplacer ce COMPONENT par celui de votre COMPONENT � tester 
    -- Note: vous pouvez copier la partie PORT ( .. ) de l'entity de votre code VHDL 
    -- et l'ins�rer dans la d�claration COMPONENT.
--> Si vous voulez comparer 2 modules VHDL, vous pouvez d�clarer 2 COMPONENTS 
    -- distincts avec leurs PORT MAP respectif. 

component AppCombi_top is
  port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0);  -- vers connecteur pmod 8 DELs
          
          i_ADC_th    : in    std_logic_vector (11 downto 0);-- Fait par deux imbéciles
          i_S1        : in    std_logic  ;  -- Fait par deux imbéciles
          i_S2        : in    std_logic  ;-- Fait par deux imbéciles
          o_DEL2      : out    std_logic  ;-- Fait par deux imbéciles  
          o_DEL3      : out    std_logic   -- Fait par deux imbéciles  
    
          
          );
end component AppCombi_top;
   
   signal   i_btn_sim   :   std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
   signal   i_sw_sim    :        std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
   signal   sysclk_sim  :     std_logic;                     -- horloge systeme
   signal   o_SSD_sim   :     std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
   signal   o_led_sim    :   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
   signal   o_led6_r_sim  :    std_logic;                     -- vers DEL rouge de la carte Zybo
   signal   o_pmodled_sim  :   std_logic_vector (7 downto 0);  -- vers connecteur pmod 8 DELs
      
   signal   i_ADC_th_sim  :  std_logic_vector (11 downto 0);-- Fait par deux imbéciles
   signal   i_S1_sim      :   std_logic  ;  -- Fait par deux imbéciles
   signal   i_S2_sim       :   std_logic  ;-- Fait par deux imbéciles
   signal   o_DEL2_sim      : std_logic  ;-- Fait par deux imbéciles  
   signal   o_DEL3_sim  : std_logic;


 signal vect_test_in : std_logic_vector (11 downto 0);
 
--> D�clarez la constante PERIOD qui est utilis�e pour la simulation

   CONSTANT PERIOD    : time := 10 ns;                  --  *** � ajouter avant le premier BEGIN




BEGIN
  -- Par le "port-map" suivant, cela revient � connecter le composant aux signaux internes du tests bench
  -- UUT Unit Under Test: ce nom est habituel mais non impos�.
  -- Si on simule deux composantes, on pourrait avoir UUT1, UUT2 par exemple
  
inst_AppCombi_top :  AppCombi_top is
  port ( 
          i_btn      
          i_sw        
          sysclk     
          o_SSD      
          o_led      
          o_led6_r        
          o_pmodled    
          
          i_ADC_th    
          i_S1      
          i_S2      
          o_DEL2     
          o_DEL3    
    
);

 --> on assigne les signaux du vecteur de test vers les signaux connect�s au port map. 
-- *** Test Bench - User Defined Section ***
-- l'int�r�t de cette structure de test bench est que l'on recopie la table de v�rit�.

-- cas valides
for i in 0 to 11 loop
    vect_test_in <= (i downto 0 => '1', others => '0');
    WAIT for period;
end loop;    

-- 1 mobile
for i in 0 to 11 loop
    vect_test_in <= (i => '1', others => '0');
    WAIT for period;
end loop;  

-- 0 mobile
for i in 0 to 11 loop
    vect_test_in <= (i => '0', others => '1');
    WAIT for period;
end loop;  
WAIT;
end process;
	
END;


