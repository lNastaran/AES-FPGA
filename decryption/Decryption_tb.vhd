--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:03:38 02/03/2021
-- Design Name:   
-- Module Name:   E:/fpga/decryption/Decryption_tb.vhd
-- Project Name:  decryption
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decryption
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
 
ENTITY Decryption_tb IS
END Decryption_tb;
 
ARCHITECTURE behavior OF Decryption_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decryption
    PORT(
         clk : IN  std_logic;
         cipherKey : IN  std_logic_vector(127 downto 0);
         encryptedText : IN  std_logic_vector(127 downto 0);
         plainText : OUT  std_logic_vector(127 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal cipherKey : std_logic_vector(127 downto 0) := (others => '0');
   signal encryptedText : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal plainText : std_logic_vector(127 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decryption PORT MAP (
          clk => clk,
          cipherKey => cipherKey,
          encryptedText => encryptedText,
          plainText => plainText
        );

   clk <= NOT(clk) after 100 ns;
	encryptedText <= X"3902dc1925dc116a8409850b1dfb9732" after 100 ns;   
	cipherKey <= X"2b28ab097eaef7cf15d2154f16a6883c" after 100 ns;

END;
