----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:27:58 01/31/2021 
-- Design Name: 
-- Module Name:    Encryption - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_arith.ALL;
library work;
use work.Keys.all;

entity Encryption is
	port(
			clk : in STD_LOGIC;
			plainText : in STD_LOGIC_VECTOR(127 downto 0);
			cipherKey : in STD_LOGIC_VECTOR(127 downto 0);
			encryptedText : out STD_LOGIC_VECTOR(127 downto 0)
	);
end Encryption;

architecture Behavioral of Encryption is


----------------------------------functions-------------------------------------


                      ------------Sub Bytes------------------
							 
function subBytes (text : matrix_4_4) return matrix_4_4 is
variable matrix : matrix_4_4;
variable row: integer range 0 to 16;
variable col: integer range 0 to 16;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
		   row:=conv_integer(text(i,j)(7 downto 4));
			col:=conv_integer(text(i,j)(3 downto 0));
			matrix(i,j) := substitutionBox(row,col);
		end loop;
	end loop;
	return matrix;
end subBytes;


                      ------------Sub Array Key------------------
function KeySubBytes (text : array_4) return array_4 is
variable array_out : array_4;
variable row: integer range 0 to 16;
variable col: integer range 0 to 16;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
		   row:=conv_integer(text(i)(7 downto 4));
			col:=conv_integer(text(i)(3 downto 0));
		   array_out(i) := substitutionBox(row,col);
		end loop;
	end loop;
	return array_out;
end KeySubBytes;

                      ------------Add Round Key-------------
							 
function addRoundKey (textMatrix, keyMatrix : matrix_4_4) return matrix_4_4 is
variable matrix : matrix_4_4;
begin 
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			matrix(i,j) := textMatrix(i,j) xor keyMatrix(i,j);
		end loop;
	end loop;
	return matrix;
end addRoundKey;

                      ------------Shift Rows------------
							 
function shiftRows (text : matrix_4_4) return matrix_4_4 is
variable matrix : matrix_4_4 := text;
variable temp, temp2 : STD_LOGIC_VECTOR(7 downto 0);
begin
   --shift first row--
	temp := matrix(1,0);
	matrix(1,0) := matrix(1,1); 
	matrix(1,1) := matrix(1,2);
	matrix(1,2) := matrix(1,3);
	matrix(1,3) := temp;
	
	--shift second row--
	temp := matrix(2,0);
	temp2 := matrix(2,1);
	matrix(2,0) := matrix(2,2);
	matrix(2,1) := matrix(2,3);
	matrix(2,2) := temp;
	matrix(2,3) := temp2;
	
	--shift third row--
	temp := matrix(3,0);
	matrix(3,0) := matrix(3,3);
	matrix(3,3) := matrix(3,2);
	matrix(3,2) := matrix(3,1);
	matrix(3,1) := temp;
	
	return matrix;
end shiftRows;

                      ------------mix columns-------------
							 
function mixColumns (text: matrix_4_4) return matrix_4_4 is
variable matrix : matrix_4_4;


begin
	matrix(0,0) := (mult_2(conv_integer(text(0,0))) xor mult_3(conv_integer(text(1,0)))) xor (text(2,0) xor text(3,0));
	matrix(1,0) := (mult_2(conv_integer(text(1,0))) xor mult_3(conv_integer(text(2,0)))) xor (text(0,0) xor text(3,0));
	matrix(2,0) := (mult_2(conv_integer(text(2,0))) xor mult_3(conv_integer(text(3,0)))) xor (text(0,0) xor text(1,0));
	matrix(3,0) := (mult_2(conv_integer(text(3,0))) xor mult_3(conv_integer(text(0,0)))) xor (text(1,0) xor text(2,0));
	
	matrix(0,1) := (mult_2(conv_integer(text(0,1))) xor mult_3(conv_integer(text(1,1)))) xor (text(2,1) xor text(3,1));
	matrix(1,1) := (mult_2(conv_integer(text(1,1))) xor mult_3(conv_integer(text(2,1)))) xor (text(0,1) xor text(3,1));
	matrix(2,1) := (mult_2(conv_integer(text(2,1))) xor mult_3(conv_integer(text(3,1)))) xor (text(0,1) xor text(1,1));
	matrix(3,1) := (mult_2(conv_integer(text(3,1))) xor mult_3(conv_integer(text(0,1)))) xor (text(1,1) xor text(2,1));
	
	matrix(0,2) := (mult_2(conv_integer(text(0,2))) xor mult_3(conv_integer(text(1,2)))) xor (text(2,2) xor text(3,2));
	matrix(1,2) := (mult_2(conv_integer(text(1,2))) xor mult_3(conv_integer(text(2,2)))) xor (text(0,2) xor text(3,2));
	matrix(2,2) := (mult_2(conv_integer(text(2,2))) xor mult_3(conv_integer(text(3,2)))) xor (text(0,2) xor text(1,2));
	matrix(3,2) := (mult_2(conv_integer(text(3,2))) xor mult_3(conv_integer(text(0,2)))) xor (text(1,2) xor text(2,2));
	
	matrix(0,3) := (mult_2(conv_integer(text(0,3))) xor mult_3(conv_integer(text(1,3)))) xor (text(2,3) xor text(3,3));
	matrix(1,3) := (mult_2(conv_integer(text(1,3))) xor mult_3(conv_integer(text(2,3)))) xor (text(0,3) xor text(3,3));
	matrix(2,3) := (mult_2(conv_integer(text(2,3))) xor mult_3(conv_integer(text(3,3)))) xor (text(0,3) xor text(1,3));
	matrix(3,3) := (mult_2(conv_integer(text(3,3))) xor mult_3(conv_integer(text(0,3)))) xor (text(1,3) xor text(2,3));

	
	return matrix;
end mixColumns;

                       ---------arrayToMatrix----------
function arrayToMatrix (text : STD_LOGIC_VECTOR(127 downto 0)) return matrix_4_4 is 
variable matrix : matrix_4_4;
variable index : integer range 0 to 255 := 127;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			matrix(i,j) := text(index downto (index-7));
			index := index - 8;
		end loop;
	end loop;
	return matrix;
end arrayToMatrix;

                      ------------MatrixToArray------------------
							 
function arrayToMatrix (text : matrix_4_4) return STD_LOGIC_VECTOR is
variable array_out : STD_LOGIC_VECTOR(127 downto 0);
variable index : integer range 0 to 255 := 127;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			array_out( index downto (index-7)) := text(i,j);
			index := index -8;
		end loop;
	end loop;
	return array_out;
end arrayToMatrix;


-------------------------------------------------------------------------------------

type state is (prepareInputs, round0, text_sub_bytes, text_shift_rows, text_mix_columns, key_schedule, add_round_key, round10_sub_bytes, round10_shift_rows, round10_key_schedule, round10_add_round_key, to_array);
signal cur_state : state := prepareInputs;
signal textMatrix, keyMatrix : matrix_4_4;
begin

	process(clk)
	variable counter : integer range 0 to 10 := 1;
	variable rcon : integer range 0 to 3000 := 1;
	variable rotWord : array_4;
	variable matrix_temp: matrix_4_4;
	begin
		if(clk'event and clk = '1')then
			case cur_state is
			
				when prepareInputs =>
					textMatrix <= arrayToMatrix(plainText);
					keyMatrix <= arrayToMatrix(cipherKey);
					cur_state <= round0;
				
				when round0 =>
					
					rcon := 1;
					textMatrix <= addRoundKey(textMatrix, keyMatrix);
					cur_state <= text_sub_bytes;
					
					
				when text_sub_bytes =>
					textMatrix <= subBytes(textMatrix);
					cur_state <= text_shift_rows;
					
				when text_shift_rows =>
					textMatrix <= shiftRows(textMatrix);
					cur_state <= text_mix_columns;
				
				when text_mix_columns =>
					textMatrix <= mixColumns(textMatrix);
					cur_state <= key_schedule;

				when key_schedule =>
				
					rotWord := (keyMatrix(1,3), keyMatrix(2,3), keyMatrix(3,3),keyMatrix(0,3));
					rotWord := KeySubBytes(rotWord);
					
					if(counter = 9) then
						rcon := 27;
					elsif (counter = 10)then
						rcon := 54;
					end if;
					
					matrix_temp(0,0) := (keyMatrix(0,0) xor rotWord(0)) xor conv_std_logic_vector(rcon, 8);
					matrix_temp(1,0) := keyMatrix(1,0) xor rotWord(1);
					matrix_temp(2,0) := keyMatrix(2,0) xor rotWord(2);
					matrix_temp(3,0) := keyMatrix(3,0) xor rotWord(3);
				
					for i in 0 to 3 loop
						for j in 1 to 3 loop
							matrix_temp(i,j) := matrix_temp(i,j-1) xor keyMatrix(i,j);
						end loop;
					end loop;
					
					rcon := rcon *2;
					
					for i in 0 to 3 loop
						for j in 0 to 3 loop
							keyMatrix(i,j) <= matrix_temp(i,j);
						end loop;
					end loop;
					
					cur_state <= add_round_key;
					
				when add_round_key =>	 		
					textMatrix <= addRoundKey(textMatrix, keyMatrix);
					counter := counter + 1;
					if(counter = 10)then
						cur_state <= round10_sub_bytes;
						counter := 0;
					else
						cur_state <= text_sub_bytes;
					end if;
					
				when round10_sub_bytes =>
					textMatrix <= subBytes(textMatrix);
					cur_state <= round10_shift_rows;
					
				when round10_shift_rows =>
					textMatrix <= shiftRows(textMatrix);
					cur_state <= round10_key_schedule;
				
				when round10_key_schedule =>
				
					rotWord := (keyMatrix(1,3), keyMatrix(2,3), keyMatrix(3,3),keyMatrix(0,3));
					rotWord := KeySubBytes(rotWord);
					
					if(counter = 9) then
						rcon := 27;
					elsif (counter = 10)then
						rcon := 54;
					end if;
					
					matrix_temp(0,0) := (keyMatrix(0,0) xor rotWord(0)) xor conv_std_logic_vector(rcon, 8);
					matrix_temp(1,0) := keyMatrix(1,0) xor rotWord(1);
					matrix_temp(2,0) := keyMatrix(2,0) xor rotWord(2);
					matrix_temp(3,0) := keyMatrix(3,0) xor rotWord(3);
				
					for i in 0 to 3 loop
						for j in 1 to 3 loop
							matrix_temp(i,j) := matrix_temp(i,j-1) xor keyMatrix(i,j);
						end loop;
					end loop;
					
					rcon := rcon *2;
					
					for i in 0 to 3 loop
						for j in 0 to 3 loop
							keyMatrix(i,j) <= matrix_temp(i,j);
						end loop;
					end loop;
					
					cur_state <= round10_add_round_key;

				when round10_add_round_key =>
					textMatrix <= addRoundKey(textMatrix, keyMatrix);
					cur_state <= to_array;
					
				when others =>
					encryptedText <= arrayToMatrix(textMatrix);
					cur_state <= prepareInputs;
					
				
				end case;
			
		end if;
	end process;
	
end Behavioral;

