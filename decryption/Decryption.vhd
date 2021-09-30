----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:39 02/03/2021 
-- Design Name: 
-- Module Name:    Decryption - Behavioral 
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
use work.Keys2.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decryption is
	port(clk : in STD_LOGIC;
			cipherKey : in STD_LOGIC_VECTOR(127 downto 0);
			encryptedText : in STD_LOGIC_VECTOR(127 downto 0);
			plainText : out STD_LOGIC_VECTOR(127 downto 0));
end Decryption;

architecture Behavioral of Decryption is

                      ------------Add Round Key-------------
function addRoundKey (text_in, key_in : matrix_4_4) return matrix_4_4 is
variable mat_out : matrix_4_4;
begin 
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			mat_out(i,j) := text_in(i,j) xor key_in(i,j);
		end loop;
	end loop;
	return mat_out;
end addRoundKey;
                      ------------InvShift Rows------------
function invShiftRows (text_in : matrix_4_4) return matrix_4_4 is
variable mat_out : matrix_4_4 := text_in;
variable temp, temp2 : STD_LOGIC_VECTOR(7 downto 0);
begin
	temp := mat_out(3,0);
	mat_out(3,0) := mat_out(3,1); 
	mat_out(3,1) := mat_out(3,2);
	mat_out(3,2) := mat_out(3,3);
	mat_out(3,3) := temp;
	
	temp := mat_out(2,0);
	mat_out(2,0) := mat_out(2,2);
	temp2 := mat_out(2,1);
	mat_out(2,1) := mat_out(2,3);
	mat_out(2,2) := temp;
	mat_out(2,3) := temp2;
	
	temp := mat_out(1,0);
	mat_out(1,0) := mat_out(1,3);
	mat_out(1,3) := mat_out(1,2);
	mat_out(1,2) := mat_out(1,1);
	mat_out(1,1) := temp;
	
	return mat_out;
end invShiftRows;
		                      ------------Sub Bytes------------------
									 

function subBytesKey (text_in : array_4) return array_4 is
variable array_out : array_4;
begin
	for i in 0 to 3 loop
		array_out(i) := substitutionBox(conv_integer(text_in(i)(7 downto 4)), conv_integer(text_in(i)(3 downto 0)));
	end loop;
	return array_out;
end subBytesKey;

                      ------------InvSub Bytes------------------
							 
function invSubBytes (text_in : matrix_4_4) return matrix_4_4 is
variable mat_out : matrix_4_4;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			mat_out(i,j) := substitutionBox2(conv_integer(text_in(i,j)(7 downto 4)), conv_integer(text_in(i,j)(3 downto 0)));
		end loop;
	end loop;
	return mat_out;
end invSubBytes;
                      ------------InMix columns-------------
function invMixColumns (text_in : matrix_4_4) return matrix_4_4 is
variable mat_out : matrix_4_4;
begin
	mat_out(0,0) := (mult_14(conv_integer(text_in(0,0))) xor mult_11(conv_integer(text_in(1,0)))) xor (mult_13(conv_integer(text_in(2,0))) xor 			mult_9(conv_integer(text_in(3,0))));
	mat_out(1,0) := (mult_14(conv_integer(text_in(1,0))) xor mult_11(conv_integer(text_in(2,0)))) xor (mult_13(conv_integer(text_in(3,0))) xor 			mult_9(conv_integer(text_in(0,0))));
	mat_out(2,0) := (mult_14(conv_integer(text_in(2,0))) xor mult_11(conv_integer(text_in(3,0)))) xor (mult_13(conv_integer(text_in(0,0))) xor 			mult_9(conv_integer(text_in(1,0))));
	mat_out(3,0) := (mult_14(conv_integer(text_in(3,0))) xor mult_11(conv_integer(text_in(0,0)))) xor (mult_13(conv_integer(text_in(1,0))) xor 			mult_9(conv_integer(text_in(2,0))));
	
		mat_out(0,1) := (mult_14(conv_integer(text_in(0,1))) xor mult_11(conv_integer(text_in(1,1)))) xor (mult_13(conv_integer(text_in(2,1))) xor 			mult_9(conv_integer(text_in(3,1))));
	mat_out(1,1) := (mult_14(conv_integer(text_in(1,1))) xor mult_11(conv_integer(text_in(2,1)))) xor (mult_13(conv_integer(text_in(3,1))) xor 			mult_9(conv_integer(text_in(0,1))));
	mat_out(2,1) := (mult_14(conv_integer(text_in(2,1))) xor mult_11(conv_integer(text_in(3,1)))) xor (mult_13(conv_integer(text_in(0,1))) xor 			mult_9(conv_integer(text_in(1,1))));
	mat_out(3,1) := (mult_14(conv_integer(text_in(3,1))) xor mult_11(conv_integer(text_in(0,1)))) xor (mult_13(conv_integer(text_in(1,1))) xor 			mult_9(conv_integer(text_in(2,1))));
	
	mat_out(0,2) := (mult_14(conv_integer(text_in(0,2))) xor mult_11(conv_integer(text_in(1,2)))) xor (mult_13(conv_integer(text_in(2,2))) xor 			mult_9(conv_integer(text_in(3,2))));
	mat_out(1,2) := (mult_14(conv_integer(text_in(1,2))) xor mult_11(conv_integer(text_in(2,2)))) xor (mult_13(conv_integer(text_in(3,2))) xor 			mult_9(conv_integer(text_in(0,2))));
	mat_out(2,2) := (mult_14(conv_integer(text_in(2,2))) xor mult_11(conv_integer(text_in(3,2)))) xor (mult_13(conv_integer(text_in(0,2))) xor 			mult_9(conv_integer(text_in(1,2))));
	mat_out(3,2) := (mult_14(conv_integer(text_in(3,2))) xor mult_11(conv_integer(text_in(0,2)))) xor (mult_13(conv_integer(text_in(1,2))) xor 			mult_9(conv_integer(text_in(2,2))));
	
	mat_out(0,3) := (mult_14(conv_integer(text_in(0,3))) xor mult_11(conv_integer(text_in(1,3)))) xor (mult_13(conv_integer(text_in(2,3))) xor 			mult_9(conv_integer(text_in(3,3))));
	mat_out(1,3) := (mult_14(conv_integer(text_in(1,3))) xor mult_11(conv_integer(text_in(2,3)))) xor (mult_13(conv_integer(text_in(3,3))) xor 			mult_9(conv_integer(text_in(0,3))));
	mat_out(2,3) := (mult_14(conv_integer(text_in(2,3))) xor mult_11(conv_integer(text_in(3,3)))) xor (mult_13(conv_integer(text_in(0,3))) xor 			mult_9(conv_integer(text_in(1,3))));
	mat_out(3,3) := (mult_14(conv_integer(text_in(3,3))) xor mult_11(conv_integer(text_in(0,3)))) xor (mult_13(conv_integer(text_in(1,3))) xor 			mult_9(conv_integer(text_in(2,3))));
	
	return mat_out;
end invMixColumns;
                       ---------ArrayToMatrix----------
function arrayToMatrix (input_text : STD_LOGIC_VECTOR(127 downto 0)) return matrix_4_4 is 
variable mat_out : matrix_4_4;
variable counter : integer range 0 to 255 := 0;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			mat_out(i,j) := input_text((127 - (counter *8)) downto 128 - ((counter + 1 ) *8));
			counter := counter + 1;
		end loop;
	end loop;
	return mat_out;
end arrayToMatrix;


                      ------------MatrixToArray------------------
							 
function matrixToArray (text_in : matrix_4_4) return STD_LOGIC_VECTOR is
variable array_out : STD_LOGIC_VECTOR(127 downto 0);
variable counter : integer range 0 to 255 := 0;
begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			array_out((127 - (counter *8)) downto 128 - ((counter + 1 ) *8)) := text_in(i,j);
			counter := counter + 1;
		end loop;
	end loop;
	return array_out;
end matrixToArray;


                      ------------KeyGenerator------------------
							 
function generate_keys (key_inp : matrix_4_4) return matrix_4_4_Ram is 
variable temp_key, matrix_temp : matrix_4_4;
variable array_temp : array_4;
variable ram : matrix_4_4_Ram;
variable rcon : array_10 := (X"01",X"02",X"04",X"08",X"10",X"20",X"40",X"80",X"1b",X"36");
begin
	ram(0) := key_inp;
	temp_key := key_inp;
	for h in 0 to 9 loop
		matrix_temp(0,0) := temp_key(1,3);
		matrix_temp(1,0) := temp_key(2,3);
		matrix_temp(2,0) := temp_key(3,3);
		matrix_temp(3,0) := temp_key(0,3);
		
		array_temp := (matrix_temp(0,0), matrix_temp(1,0), matrix_temp(2,0),matrix_temp(3,0));
		array_temp := subBytesKey(array_temp);
						
		matrix_temp(0,0) := array_temp(0);
		matrix_temp(1,0) := array_temp(1);
		matrix_temp(2,0) := array_temp(2);
		matrix_temp(3,0) := array_temp(3);
		
		matrix_temp(0,0) := (temp_key(0,0) xor matrix_temp(0,0))xor rcon(h);
		matrix_temp(1,0) := temp_key(1,0) xor matrix_temp(1,0);
		matrix_temp(2,0) := temp_key(2,0) xor matrix_temp(2,0);
		matrix_temp(3,0) := temp_key(3,0) xor matrix_temp(3,0);
	
		for i in 0 to 3 loop
			for j in 1 to 3 loop
				matrix_temp(i,j) := matrix_temp(i,j-1) xor temp_key(i,j);
			end loop;
		end loop;
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				temp_key(i,j) := matrix_temp(i,j);
			end loop;
		end loop;
		ram(h+1) := matrix_temp;
	end loop;
	return ram;
end generate_keys;

--------------------------------------------------------------------------							 
type state is (load_ciphers, round0, add_round_key, inv_shift_rows, inv_sub_bytes, inv_mix_columns,
add_round_key_0, add_round_key_1, add_round_key_2, add_round_key_3, add_round_key_4, add_round_key_5, add_round_key_6, add_round_key_7, add_round_key_8, add_round_key_9, ready_state);
signal cur_state : state := load_ciphers;
signal cipher_mat, key_mat : matrix_4_4;
signal key_holder: matrix_4_4_Ram ;

begin

	process(clk)
	variable counter : integer range 0 to 11 := 0;
	variable key_mat_temp : matrix_4_4;
	begin
		if(clk'event and clk = '1') then
			case cur_state is
				when load_ciphers =>
					
					cipher_mat <= arrayToMatrix(encryptedText);
					key_mat <= arrayToMatrix(cipherKey);
					cur_state <= round0;
					
				when round0 =>
						key_holder <= generate_keys (key_mat);
						cur_state <= add_round_key;
					
				when add_round_key =>
					
					cipher_mat <= addRoundKey(cipher_mat,key_holder(10));
					cur_state <= inv_shift_rows;
					
				when inv_shift_rows =>
					cipher_mat <= invShiftRows(cipher_mat);
					cur_state <= inv_sub_bytes;
					
				when inv_sub_bytes =>
					cipher_mat <= invSubBytes(cipher_mat);
					counter:= counter+1;
					if(counter=1) then
						cur_state <= add_round_key_9;
					elsif (counter=2) then
						cur_state <= add_round_key_8;
					elsif (counter=3) then
						cur_state <= add_round_key_7;
					elsif (counter=4) then
						cur_state <= add_round_key_6;
					elsif (counter=5) then
						cur_state <= add_round_key_5;
					elsif (counter=6) then
						cur_state <= add_round_key_4;
					elsif (counter=7) then
						cur_state <= add_round_key_3;
					elsif (counter=8) then
						cur_state <= add_round_key_2;
					elsif (counter=9) then
						cur_state <= add_round_key_1;
					elsif (counter=10) then
						cur_state <= add_round_key_0;
					end if;
				when add_round_key_9 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(9));
					cur_state <= inv_mix_columns;
				when add_round_key_8 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(8));
					cur_state <= inv_mix_columns;
				when add_round_key_7 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(7));
					cur_state <= inv_mix_columns;
				when add_round_key_6 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(6));
					cur_state <= inv_mix_columns;
				when add_round_key_5 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(5));
					cur_state <= inv_mix_columns;
				when add_round_key_4 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(4));
					cur_state <= inv_mix_columns;
				when add_round_key_3 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(3));
					cur_state <= inv_mix_columns;
				when add_round_key_2 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(2));
					cur_state <= inv_mix_columns;
				when add_round_key_1 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(1));
					cur_state <= inv_mix_columns;
				when add_round_key_0 =>
					cipher_mat <= addRoundKey(cipher_mat,key_holder(0));
					cur_state <= ready_state;
				when inv_mix_columns =>
					cipher_mat <= invMixColumns(cipher_mat);
					cur_state <= inv_shift_rows;
				when ready_state =>
					plainText <= matrixToArray(cipher_mat);
					cur_state <= load_ciphers;
				
			end case;
		end if;
	end process;
end Behavioral;

