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

ENTITY parite_tb IS          --> Remarquez que l'ENTITY est vide et doit le demeurer pour un test bench !!!  
END parite_tb;


ARCHITECTURE behavioral OF parite_tb IS 

--> Remplacer ce COMPONENT par celui de votre COMPONENT � tester 
    -- Note: vous pouvez copier la partie PORT ( .. ) de l'entity de votre code VHDL 
    -- et l'ins�rer dans la d�claration COMPONENT.
--> Si vous voulez comparer 2 modules VHDL, vous pouvez d�clarer 2 COMPONENTS 
    -- distincts avec leurs PORT MAP respectif. 

    component parite_calculateur is
        Port (
            ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
            S1 : in std_logic;
            parite : out STD_LOGIC
            );
    end component;
       
--> G�n�rez des signaux internes au test bench avec des noms associ�s et les m�me types que dans le port
    -- Note: les noms peuvent �tre identiques, dans l'exemple on a ajout� un suffixe pour
    -- identifier clairement le signal qui appartient au test bench

   SIGNAL ADCbin_sim    : std_logic_vector(3 downto 0);
   signal S1_sim : std_logic;
   signal parite_sim : std_logic;
   
   
   

--> S'il y a plusieurs bits en entr�e pour lesquels il faut d�finir des valeurs de test, 
    -- par exemple a, b, c dans l'exemple pr�sent, on recommande de cr�er un vecteur de test,
    -- ce qui facilitera l'�criture du test et la lisibilit� du code,
    -- notamment en faisant appara�tre clairement une structure de table de v�rit�

   SIGNAL vect_test : STD_LOGIC_VECTOR (3 downto 0);  -- Cr�ation d'un signal interne ( bits)
   
--> D�clarez la constante PERIOD qui est utilis�e pour la simulation

   CONSTANT PERIOD    : time := 10 ns;                  --  *** � ajouter avant le premier BEGIN

--> Il faut faire un port map entre vos signaux internes et le component � tester
--> NOTE: Si vous voulez comparer 2 modules VHDL, vous devez g�nr�er 2 port maps 


BEGIN
  -- Par le "port-map" suivant, cela revient � connecter le composant aux signaux internes du tests bench
  -- UUT Unit Under Test: ce nom est habituel mais non impos�.
  -- Si on simule deux composantes, on pourrait avoir UUT1, UUT2 par exemple
  
  UUT: parite_calculateur PORT MAP(
      ADCbin => ADCbin_sim,
      S1 => S1_sim,
      parite => parite_sim
      
   );

 --> on assigne les signaux du vecteur de test vers les signaux connect�s au port map. 
ADCbin_sim <= vect_test;
-- *** Test Bench - User Defined Section ***

   parite_tb : PROCESS
   
   begin
    S1_sim <= '1';
    
        
    for i in 0 to 15 loop
        vect_test <= std_logic_vector(TO_UNSIGNED(i, 4));
        WAIT FOR PERIOD;
    end loop;
    S1_sim  <= '0';

    for i in 0 to 15 loop
        vect_test <= std_logic_vector(TO_UNSIGNED(i, 4));
        WAIT FOR PERIOD;
    end loop;
        
            
        

                  
         WAIT; -- will wait forever
   END PROCESS;
END;
