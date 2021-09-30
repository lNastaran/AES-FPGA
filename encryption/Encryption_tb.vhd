--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:43:21 01/31/2021
-- Design Name:   
-- Module Name:   C:/Users/sara/Desktop/fpga/final project/finalProject/Encryption_tb.vhd
-- Project Name:  finalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Encryption
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Encryption_tb IS
END Encryption_tb;
 
ARCHITECTURE behavior OF Encryption_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Encryption
    PORT(
         clk : IN  std_logic;
         plainText : IN  std_logic_vector(127 downto 0);
         cipherKey : IN  std_logic_vector(127 downto 0);
         encryptedText : OUT  std_logic_vector(127 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal plainText : std_logic_vector(127 downto 0) := (others => '0');
   signal cipherKey : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal encryptedText : std_logic_vector(127 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Encryption PORT MAP (
          clk => clk,
          plainText => plainText,
          cipherKey => cipherKey,
          encryptedText => encryptedText
        );
	clk <= NOT(clk) after 100 ns;
	
	plainText <= X"328831e0435a3137f6309807a88da234" after 100 ns;   
	cipherKey <= X"2b28ab097eaef7cf15d2154f16a6883c" after 100 ns;

END;