--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;


package Keys2 is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

Type matrix_4_4 is array (0 to 3,0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
Type matrix_16_16 is array (0 to 15, 0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
Type array_256 is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
Type array_4 is array (0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
type array_10 is array (0 to 9) of STD_LOGIC_VECTOR(7 downto 0);
type matrix_4_4_Ram is array (0 to 10) of matrix_4_4;

constant substitutionBox: matrix_16_16 := ((X"63", X"7C", X"77", X"7B", X"F2", X"6b", X"6F", X"C5", X"30", X"01", X"67", X"2B", X"FE", X"D7", X"AB", X"76"),
												  (X"CA", X"82", X"C9", X"7D", X"FA", X"59", X"47", X"F0", X"AD", X"D4", X"A2", X"AF", X"9C", X"A4", X"72", X"C0"),
												  (X"B7", X"FD", X"93", X"26", X"36", X"3F", X"F7", X"CC", X"34", X"A5", X"E5", X"F1", X"71", X"D8", X"31", X"15"),
												  (X"04", X"C7", X"23", X"C3", X"18", X"96", X"05", X"9A", X"07", X"12", X"80", X"E2", X"EB", X"27", X"B2", X"75"),
												  (X"09", X"83", X"2C", X"1A", X"1B", X"6E", X"5A", X"A0", X"52", X"3B", X"D6", X"B3", X"29", X"E3", X"2F", X"84"),
												  (X"53", X"D1", X"00", X"ED", X"20", X"FC", X"B1", X"5B", X"6A", X"CB", X"BE", X"39", X"4A", X"4C", X"58", X"CF"),
												  (X"D0", X"EF", X"AA", X"FB", X"43", X"4D", X"33", X"85", X"45", X"F9", X"02", X"7F", X"50", X"3C", X"9F", X"A8"),
												  (X"51", X"A3", X"40", X"8F", X"92", X"9D", X"38", X"F5", X"BC", X"B6", X"DA", X"21", X"10", X"FF", X"F3", X"D2"),
												  (X"CD", X"0C", X"13", X"EC", X"5F", X"97", X"44", X"17", X"C4", X"A7", X"7E", X"3D", X"64", X"5D", X"19", X"73"),
												  (X"60", X"81", X"4F", X"DC", X"22", X"2A", X"90", X"88", X"46", X"EE", X"B8", X"14", X"DE", X"5E", X"0B", X"DB"),
												  (X"E0", X"32", X"3A", X"0A", X"49", X"06", X"24", X"5C", X"C2", X"D3", X"AC", X"62", X"91", X"95", X"E4", X"79"),
												  (X"E7", X"C8", X"37", X"6D", X"8D", X"D5", X"4E", X"A9", X"6C", X"56", X"F4", X"EA", X"65", X"7A", X"AE", X"08"),
												  (X"BA", X"78", X"25", X"2E", X"1C", X"A6", X"B4", X"C6", X"E8", X"DD", X"74", X"1F", X"4B", X"BD", X"8B", X"8A"),
												  (X"70", X"3E", X"B5", X"66", X"48", X"03", X"F6", X"0E", X"61", X"35", X"57", X"B9", X"86", X"C1", X"1D", X"9E"),
												  (X"E1", X"F8", X"98", X"11", X"69", X"D9", X"8E", X"94", X"9B", X"1E", X"87", X"E9", X"CE", X"55", X"28", X"DF"),
												  (X"8C", X"A1", X"89", X"0D", X"BF", X"E6", X"42", X"68", X"41", X"99", X"2D", X"0F", X"B0", X"54", X"BB", X"16"));
												  
												  
												  
constant substitutionBox2:matrix_16_16 := ((X"52", X"09", X"6a", X"d5", X"30", X"36", X"a5", X"38", X"bf", X"40", X"a3", X"9e", X"81", X"f3", X"d7", X"fb"),
												  (X"7c", X"e3", X"39", X"82", X"9b", X"2f", X"ff", X"87", X"34", X"8e", X"43", X"44", X"c4", X"de", X"e9", X"cb"),
												  (X"54", X"7b", X"94", X"32", X"a6", X"c2", X"23", X"3d", X"ee", X"4c", X"95", X"0b", X"42", X"fa", X"c3", X"4e"),
												  (X"08", X"2e", X"a1", X"66", X"28", X"d9", X"24", X"b2", X"76", X"5b", X"a2", X"49", X"6d", X"8b", X"d1", X"25"),
												  (X"72", X"f8", X"f6", X"64", X"86", X"68", X"98", X"16", X"d4", X"a4", X"5c", X"cc", X"5d", X"65", X"b6", X"92"),
												  (X"6c", X"70", X"48", X"50", X"fd", X"ed", X"b9", X"da", X"5e", X"15", X"46", X"57", X"a7", X"8d", X"9d", X"84"),
												  (X"90", X"d8", X"ab", X"00", X"8c", X"bc", X"d3", X"0a", X"f7", X"e4", X"58", X"05", X"b8", X"b3", X"45", X"06"),
												  (X"d0", X"2c", X"1e", X"8f", X"ca", X"3f", X"0f", X"02", X"c1", X"af", X"bd", X"03", X"01", X"13", X"8a", X"6b"),
												  (X"3a", X"91", X"11", X"41", X"4f", X"67", X"dc", X"ea", X"97", X"f2", X"cf", X"ce", X"f0", X"b4", X"e6", X"73"),
												  (X"96", X"ac", X"74", X"22", X"e7", X"ad", X"35", X"85", X"e2", X"f9", X"37", X"e8", X"1c", X"75", X"df", X"6e"),
												  (X"47", X"f1", X"1a", X"71", X"1d", X"29", X"c5", X"89", X"6f", X"b7", X"62", X"0e", X"aa", X"18", X"be", X"1b"),
												  (X"fc", X"56", X"3e", X"4b", X"c6", X"d2", X"79", X"20", X"9a", X"db", X"c0", X"fe", X"78", X"cd", X"5a", X"f4"),
												  (X"1f", X"dd", X"a8", X"33", X"88", X"07", X"c7", X"31", X"b1", X"12", X"10", X"59", X"27", X"80", X"ec", X"5f"),
												  (X"60", X"51", X"7f", X"a9", X"19", X"b5", X"4a", X"0d", X"2d", X"e5", X"7a", X"9f", X"93", X"c9", X"9c", X"ef"),
												  (X"a0", X"e0", X"3b", X"4d", X"ae", X"2a", X"f5", X"b0", X"c8", X"eb", X"bb", X"3c", X"83", X"53", X"99", X"61"),
												  (X"17", X"2b", X"04", X"7e", X"ba", X"77", X"d6", X"26", X"e1", X"69", X"14", X"63", X"55", X"21", X"0c", X"7d"));
												  
constant mult_9 : array_256 := (X"00",X"09",X"12",X"1b",X"24",X"2d",X"36",X"3f",X"48",X"41",X"5a",X"53",X"6c",X"65",X"7e",X"77",
											X"90",X"99",X"82",X"8b",X"b4",X"bd",X"a6",X"af",X"d8",X"d1",X"ca",X"c3",X"fc",X"f5",X"ee",X"e7",
											X"3b",X"32",X"29",X"20",X"1f",X"16",X"0d",X"04",X"73",X"7a",X"61",X"68",X"57",X"5e",X"45",X"4c",
											X"ab",X"a2",X"b9",X"b0",X"8f",X"86",X"9d",X"94",X"e3",X"ea",X"f1",X"f8",X"c7",X"ce",X"d5",X"dc",
											X"76",X"7f",X"64",X"6d",X"52",X"5b",X"40",X"49",X"3e",X"37",X"2c",X"25",X"1a",X"13",X"08",X"01",
											X"e6",X"ef",X"f4",X"fd",X"c2",X"cb",X"d0",X"d9",X"ae",X"a7",X"bc",X"b5",X"8a",X"83",X"98",X"91",
											X"4d",X"44",X"5f",X"56",X"69",X"60",X"7b",X"72",X"05",X"0c",X"17",X"1e",X"21",X"28",X"33",X"3a",
											X"dd",X"d4",X"cf",X"c6",X"f9",X"f0",X"eb",X"e2",X"95",X"9c",X"87",X"8e",X"b1",X"b8",X"a3",X"aa",
											X"ec",X"e5",X"fe",X"f7",X"c8",X"c1",X"da",X"d3",X"a4",X"ad",X"b6",X"bf",X"80",X"89",X"92",X"9b",
											X"7c",X"75",X"6e",X"67",X"58",X"51",X"4a",X"43",X"34",X"3d",X"26",X"2f",X"10",X"19",X"02",X"0b",
											X"d7",X"de",X"c5",X"cc",X"f3",X"fa",X"e1",X"e8",X"9f",X"96",X"8d",X"84",X"bb",X"b2",X"a9",X"a0",
											X"47",X"4e",X"55",X"5c",X"63",X"6a",X"71",X"78",X"0f",X"06",X"1d",X"14",X"2b",X"22",X"39",X"30",
											X"9a",X"93",X"88",X"81",X"be",X"b7",X"ac",X"a5",X"d2",X"db",X"c0",X"c9",X"f6",X"ff",X"e4",X"ed",
											X"0a",X"03",X"18",X"11",X"2e",X"27",X"3c",X"35",X"42",X"4b",X"50",X"59",X"66",X"6f",X"74",X"7d",
											X"a1",X"a8",X"b3",X"ba",X"85",X"8c",X"97",X"9e",X"e9",X"e0",X"fb",X"f2",X"cd",X"c4",X"df",X"d6",
											X"31",X"38",X"23",X"2a",X"15",X"1c",X"07",X"0e",X"79",X"70",X"6b",X"62",X"5d",X"54",X"4f",X"46");

constant mult_11 : array_256 := (X"00",X"0b",X"16",X"1d",X"2c",X"27",X"3a",X"31",X"58",X"53",X"4e",X"45",X"74",X"7f",X"62",X"69",
											X"b0",X"bb",X"a6",X"ad",X"9c",X"97",X"8a",X"81",X"e8",X"e3",X"fe",X"f5",X"c4",X"cf",X"d2",X"d9",
											X"7b",X"70",X"6d",X"66",X"57",X"5c",X"41",X"4a",X"23",X"28",X"35",X"3e",X"0f",X"04",X"19",X"12",
											X"cb",X"c0",X"dd",X"d6",X"e7",X"ec",X"f1",X"fa",X"93",X"98",X"85",X"8e",X"bf",X"b4",X"a9",X"a2",
											X"f6",X"fd",X"e0",X"eb",X"da",X"d1",X"cc",X"c7",X"ae",X"a5",X"b8",X"b3",X"82",X"89",X"94",X"9f",
											X"46",X"4d",X"50",X"5b",X"6a",X"61",X"7c",X"77",X"1e",X"15",X"08",X"03",X"32",X"39",X"24",X"2f",
											X"8d",X"86",X"9b",X"90",X"a1",X"aa",X"b7",X"bc",X"d5",X"de",X"c3",X"c8",X"f9",X"f2",X"ef",X"e4",
											X"3d",X"36",X"2b",X"20",X"11",X"1a",X"07",X"0c",X"65",X"6e",X"73",X"78",X"49",X"42",X"5f",X"54",
											X"f7",X"fc",X"e1",X"ea",X"db",X"d0",X"cd",X"c6",X"af",X"a4",X"b9",X"b2",X"83",X"88",X"95",X"9e",
											X"47",X"4c",X"51",X"5a",X"6b",X"60",X"7d",X"76",X"1f",X"14",X"09",X"02",X"33",X"38",X"25",X"2e",
											X"8c",X"87",X"9a",X"91",X"a0",X"ab",X"b6",X"bd",X"d4",X"df",X"c2",X"c9",X"f8",X"f3",X"ee",X"e5",
											X"3c",X"37",X"2a",X"21",X"10",X"1b",X"06",X"0d",X"64",X"6f",X"72",X"79",X"48",X"43",X"5e",X"55",
											X"01",X"0a",X"17",X"1c",X"2d",X"26",X"3b",X"30",X"59",X"52",X"4f",X"44",X"75",X"7e",X"63",X"68",
											X"b1",X"ba",X"a7",X"ac",X"9d",X"96",X"8b",X"80",X"e9",X"e2",X"ff",X"f4",X"c5",X"ce",X"d3",X"d8",
											X"7a",X"71",X"6c",X"67",X"56",X"5d",X"40",X"4b",X"22",X"29",X"34",X"3f",X"0e",X"05",X"18",X"13",
											X"ca",X"c1",X"dc",X"d7",X"e6",X"ed",X"f0",X"fb",X"92",X"99",X"84",X"8f",X"be",X"b5",X"a8",X"a3");
											
constant mult_13 : array_256 := (X"00",X"0d",X"1a",X"17",X"34",X"39",X"2e",X"23",X"68",X"65",X"72",X"7f",X"5c",X"51",X"46",X"4b",
											X"d0",X"dd",X"ca",X"c7",X"e4",X"e9",X"fe",X"f3",X"b8",X"b5",X"a2",X"af",X"8c",X"81",X"96",X"9b",
											X"bb",X"b6",X"a1",X"ac",X"8f",X"82",X"95",X"98",X"d3",X"de",X"c9",X"c4",X"e7",X"ea",X"fd",X"f0",
											X"6b",X"66",X"71",X"7c",X"5f",X"52",X"45",X"48",X"03",X"0e",X"19",X"14",X"37",X"3a",X"2d",X"20",
											X"6d",X"60",X"77",X"7a",X"59",X"54",X"43",X"4e",X"05",X"08",X"1f",X"12",X"31",X"3c",X"2b",X"26",
											X"bd",X"b0",X"a7",X"aa",X"89",X"84",X"93",X"9e",X"d5",X"d8",X"cf",X"c2",X"e1",X"ec",X"fb",X"f6",
											X"d6",X"db",X"cc",X"c1",X"e2",X"ef",X"f8",X"f5",X"be",X"b3",X"a4",X"a9",X"8a",X"87",X"90",X"9d",
											X"06",X"0b",X"1c",X"11",X"32",X"3f",X"28",X"25",X"6e",X"63",X"74",X"79",X"5a",X"57",X"40",X"4d",
											X"da",X"d7",X"c0",X"cd",X"ee",X"e3",X"f4",X"f9",X"b2",X"bf",X"a8",X"a5",X"86",X"8b",X"9c",X"91",
											X"0a",X"07",X"10",X"1d",X"3e",X"33",X"24",X"29",X"62",X"6f",X"78",X"75",X"56",X"5b",X"4c",X"41",
											X"61",X"6c",X"7b",X"76",X"55",X"58",X"4f",X"42",X"09",X"04",X"13",X"1e",X"3d",X"30",X"27",X"2a",
											X"b1",X"bc",X"ab",X"a6",X"85",X"88",X"9f",X"92",X"d9",X"d4",X"c3",X"ce",X"ed",X"e0",X"f7",X"fa",
											X"b7",X"ba",X"ad",X"a0",X"83",X"8e",X"99",X"94",X"df",X"d2",X"c5",X"c8",X"eb",X"e6",X"f1",X"fc",
											X"67",X"6a",X"7d",X"70",X"53",X"5e",X"49",X"44",X"0f",X"02",X"15",X"18",X"3b",X"36",X"21",X"2c",
											X"0c",X"01",X"16",X"1b",X"38",X"35",X"22",X"2f",X"64",X"69",X"7e",X"73",X"50",X"5d",X"4a",X"47",
											X"dc",X"d1",X"c6",X"cb",X"e8",X"e5",X"f2",X"ff",X"b4",X"b9",X"ae",X"a3",X"80",X"8d",X"9a",X"97");
											
constant mult_14 : array_256 := (X"00",X"0e",X"1c",X"12",X"38",X"36",X"24",X"2a",X"70",X"7e",X"6c",X"62",X"48",X"46",X"54",X"5a",
											X"e0",X"ee",X"fc",X"f2",X"d8",X"d6",X"c4",X"ca",X"90",X"9e",X"8c",X"82",X"a8",X"a6",X"b4",X"ba",
											X"db",X"d5",X"c7",X"c9",X"e3",X"ed",X"ff",X"f1",X"ab",X"a5",X"b7",X"b9",X"93",X"9d",X"8f",X"81",
											X"3b",X"35",X"27",X"29",X"03",X"0d",X"1f",X"11",X"4b",X"45",X"57",X"59",X"73",X"7d",X"6f",X"61",
											X"ad",X"a3",X"b1",X"bf",X"95",X"9b",X"89",X"87",X"dd",X"d3",X"c1",X"cf",X"e5",X"eb",X"f9",X"f7",
											X"4d",X"43",X"51",X"5f",X"75",X"7b",X"69",X"67",X"3d",X"33",X"21",X"2f",X"05",X"0b",X"19",X"17",
											X"76",X"78",X"6a",X"64",X"4e",X"40",X"52",X"5c",X"06",X"08",X"1a",X"14",X"3e",X"30",X"22",X"2c",
											X"96",X"98",X"8a",X"84",X"ae",X"a0",X"b2",X"bc",X"e6",X"e8",X"fa",X"f4",X"de",X"d0",X"c2",X"cc",
											X"41",X"4f",X"5d",X"53",X"79",X"77",X"65",X"6b",X"31",X"3f",X"2d",X"23",X"09",X"07",X"15",X"1b",
											X"a1",X"af",X"bd",X"b3",X"99",X"97",X"85",X"8b",X"d1",X"df",X"cd",X"c3",X"e9",X"e7",X"f5",X"fb",
											X"9a",X"94",X"86",X"88",X"a2",X"ac",X"be",X"b0",X"ea",X"e4",X"f6",X"f8",X"d2",X"dc",X"ce",X"c0",
											X"7a",X"74",X"66",X"68",X"42",X"4c",X"5e",X"50",X"0a",X"04",X"16",X"18",X"32",X"3c",X"2e",X"20",
											X"ec",X"e2",X"f0",X"fe",X"d4",X"da",X"c8",X"c6",X"9c",X"92",X"80",X"8e",X"a4",X"aa",X"b8",X"b6",
											X"0c",X"02",X"10",X"1e",X"34",X"3a",X"28",X"26",X"7c",X"72",X"60",X"6e",X"44",X"4a",X"58",X"56",
											X"37",X"39",X"2b",X"25",X"0f",X"01",X"13",X"1d",X"47",X"49",X"5b",X"55",X"7f",X"71",X"63",X"6d",
											X"d7",X"d9",X"cb",X"c5",X"ef",X"e1",X"f3",X"fd",X"a7",X"a9",X"bb",X"b5",X"9f",X"91",X"83",X"8d");



end Keys2;

package body Keys2 is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end Keys2;
