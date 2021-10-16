-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe_rom is 
    generic(
             DWIDTH     : integer := 15; 
             AWIDTH     : integer := 9; 
             MEM_SIZE    : integer := 512
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "000101000111101", 1 => "000101000111110", 2 => "000101001000001", 
    3 => "000101001000111", 4 => "000101001001111", 5 => "000101001011001", 
    6 => "000101001100110", 7 => "000101001110101", 8 => "000101010000110", 
    9 => "000101010011001", 10 => "000101010101110", 11 => "000101011000110", 
    12 => "000101011100000", 13 => "000101011111100", 14 => "000101100011011", 
    15 => "000101100111100", 16 => "000101101011111", 17 => "000101110000100", 
    18 => "000101110101011", 19 => "000101111010101", 20 => "000110000000001", 
    21 => "000110000101111", 22 => "000110001011111", 23 => "000110010010001", 
    24 => "000110011000110", 25 => "000110011111101", 26 => "000110100110110", 
    27 => "000110101110001", 28 => "000110110101110", 29 => "000110111101101", 
    30 => "000111000101111", 31 => "000111001110011", 32 => "000111010111000", 
    33 => "000111100000000", 34 => "000111101001010", 35 => "000111110010110", 
    36 => "000111111100100", 37 => "001000000110100", 38 => "001000010000110", 
    39 => "001000011011011", 40 => "001000100110001", 41 => "001000110001001", 
    42 => "001000111100011", 43 => "001001000111111", 44 => "001001010011101", 
    45 => "001001011111110", 46 => "001001101100000", 47 => "001001111000011", 
    48 => "001010000101001", 49 => "001010010010001", 50 => "001010011111011", 
    51 => "001010101100110", 52 => "001010111010011", 53 => "001011001000010", 
    54 => "001011010110011", 55 => "001011100100110", 56 => "001011110011010", 
    57 => "001100000010001", 58 => "001100010001001", 59 => "001100100000010", 
    60 => "001100101111110", 61 => "001100111111011", 62 => "001101001111001", 
    63 => "001101011111010", 64 => "001101101111100", 65 => "001101111111111", 
    66 => "001110010000101", 67 => "001110100001011", 68 => "001110110010100", 
    69 => "001111000011101", 70 => "001111010101001", 71 => "001111100110110", 
    72 => "001111111000100", 73 => "010000001010100", 74 => "010000011100101", 
    75 => "010000101110111", 76 => "010001000001011", 77 => "010001010100000", 
    78 => "010001100110111", 79 => "010001111001111", 80 => "010010001101000", 
    81 => "010010100000010", 82 => "010010110011110", 83 => "010011000111011", 
    84 => "010011011011001", 85 => "010011101111000", 86 => "010100000011001", 
    87 => "010100010111010", 88 => "010100101011101", 89 => "010101000000000", 
    90 => "010101010100101", 91 => "010101101001011", 92 => "010101111110010", 
    93 => "010110010011001", 94 => "010110101000010", 95 => "010110111101011", 
    96 => "010111010010110", 97 => "010111101000001", 98 => "010111111101101", 
    99 => "011000010011010", 100 => "011000101001000", 101 => "011000111110111", 
    102 => "011001010100110", 103 => "011001101010110", 104 => "011010000000111", 
    105 => "011010010111000", 106 => "011010101101010", 107 => "011011000011101", 
    108 => "011011011010000", 109 => "011011110000011", 110 => "011100000111000", 
    111 => "011100011101100", 112 => "011100110100010", 113 => "011101001010111", 
    114 => "011101100001101", 115 => "011101111000100", 116 => "011110001111011", 
    117 => "011110100110010", 118 => "011110111101001", 119 => "011111010100001", 
    120 => "011111101011001", 121 => "100000000010001", 122 => "100000011001001", 
    123 => "100000110000010", 124 => "100001000111011", 125 => "100001011110011", 
    126 => "100001110101100", 127 => "100010001100101", 128 => "100010100011110", 
    129 => "100010111010111", 130 => "100011010010000", 131 => "100011101001001", 
    132 => "100100000000010", 133 => "100100010111011", 134 => "100100101110011", 
    135 => "100101000101011", 136 => "100101011100100", 137 => "100101110011100", 
    138 => "100110001010011", 139 => "100110100001011", 140 => "100110111000010", 
    141 => "100111001111001", 142 => "100111100101111", 143 => "100111111100101", 
    144 => "101000010011011", 145 => "101000101010000", 146 => "101001000000101", 
    147 => "101001010111001", 148 => "101001101101101", 149 => "101010000100000", 
    150 => "101010011010010", 151 => "101010110000100", 152 => "101011000110110", 
    153 => "101011011100110", 154 => "101011110010110", 155 => "101100001000110", 
    156 => "101100011110100", 157 => "101100110100010", 158 => "101101001001111", 
    159 => "101101011111011", 160 => "101101110100111", 161 => "101110001010001", 
    162 => "101110011111011", 163 => "101110110100011", 164 => "101111001001011", 
    165 => "101111011110010", 166 => "101111110010111", 167 => "110000000111100", 
    168 => "110000011100000", 169 => "110000110000010", 170 => "110001000100100", 
    171 => "110001011000100", 172 => "110001101100011", 173 => "110010000000010", 
    174 => "110010010011110", 175 => "110010100111010", 176 => "110010111010100", 
    177 => "110011001101110", 178 => "110011100000110", 179 => "110011110011100", 
    180 => "110100000110001", 181 => "110100011000101", 182 => "110100101011000", 
    183 => "110100111101001", 184 => "110101001111001", 185 => "110101100000111", 
    186 => "110101110010100", 187 => "110110000011111", 188 => "110110010101001", 
    189 => "110110100110001", 190 => "110110110111000", 191 => "110111000111101", 
    192 => "110111011000001", 193 => "110111101000011", 194 => "110111111000011", 
    195 => "111000001000010", 196 => "111000010111111", 197 => "111000100111010", 
    198 => "111000110110100", 199 => "111001000101100", 200 => "111001010100010", 
    201 => "111001100010110", 202 => "111001110001001", 203 => "111001111111010", 
    204 => "111010001101001", 205 => "111010011010110", 206 => "111010101000010", 
    207 => "111010110101011", 208 => "111011000010011", 209 => "111011001111001", 
    210 => "111011011011101", 211 => "111011100111111", 212 => "111011110011111", 
    213 => "111011111111101", 214 => "111100001011001", 215 => "111100010110011", 
    216 => "111100100001100", 217 => "111100101100010", 218 => "111100110110110", 
    219 => "111101000001000", 220 => "111101001011000", 221 => "111101010100110", 
    222 => "111101011110010", 223 => "111101100111100", 224 => "111101110000100", 
    225 => "111101111001010", 226 => "111110000001101", 227 => "111110001001111", 
    228 => "111110010001110", 229 => "111110011001100", 230 => "111110100000111", 
    231 => "111110101000000", 232 => "111110101110110", 233 => "111110110101011", 
    234 => "111110111011101", 235 => "111111000001110", 236 => "111111000111100", 
    237 => "111111001101000", 238 => "111111010010001", 239 => "111111010111001", 
    240 => "111111011011110", 241 => "111111100000001", 242 => "111111100100010", 
    243 => "111111101000000", 244 => "111111101011100", 245 => "111111101110110", 
    246 => "111111110001110", 247 => "111111110100100", 248 => "111111110110111", 
    249 => "111111111001000", 250 => "111111111010111", 251 => "111111111100011", 
    252 => "111111111101101", 253 => "111111111110101", 254 => "111111111111011", 
    255 => "111111111111110", 256 => "111111111111111", 257 => "111111111111110", 
    258 => "111111111111011", 259 => "111111111110101", 260 => "111111111101101", 
    261 => "111111111100011", 262 => "111111111010111", 263 => "111111111001000", 
    264 => "111111110110111", 265 => "111111110100100", 266 => "111111110001110", 
    267 => "111111101110110", 268 => "111111101011100", 269 => "111111101000000", 
    270 => "111111100100010", 271 => "111111100000001", 272 => "111111011011110", 
    273 => "111111010111001", 274 => "111111010010001", 275 => "111111001101000", 
    276 => "111111000111100", 277 => "111111000001110", 278 => "111110111011101", 
    279 => "111110110101011", 280 => "111110101110110", 281 => "111110101000000", 
    282 => "111110100000111", 283 => "111110011001100", 284 => "111110010001110", 
    285 => "111110001001111", 286 => "111110000001101", 287 => "111101111001010", 
    288 => "111101110000100", 289 => "111101100111100", 290 => "111101011110010", 
    291 => "111101010100110", 292 => "111101001011000", 293 => "111101000001000", 
    294 => "111100110110110", 295 => "111100101100010", 296 => "111100100001100", 
    297 => "111100010110011", 298 => "111100001011001", 299 => "111011111111101", 
    300 => "111011110011111", 301 => "111011100111111", 302 => "111011011011101", 
    303 => "111011001111001", 304 => "111011000010011", 305 => "111010110101011", 
    306 => "111010101000010", 307 => "111010011010110", 308 => "111010001101001", 
    309 => "111001111111010", 310 => "111001110001001", 311 => "111001100010110", 
    312 => "111001010100010", 313 => "111001000101100", 314 => "111000110110100", 
    315 => "111000100111010", 316 => "111000010111111", 317 => "111000001000010", 
    318 => "110111111000011", 319 => "110111101000011", 320 => "110111011000001", 
    321 => "110111000111101", 322 => "110110110111000", 323 => "110110100110001", 
    324 => "110110010101001", 325 => "110110000011111", 326 => "110101110010100", 
    327 => "110101100000111", 328 => "110101001111001", 329 => "110100111101001", 
    330 => "110100101011000", 331 => "110100011000101", 332 => "110100000110001", 
    333 => "110011110011100", 334 => "110011100000110", 335 => "110011001101110", 
    336 => "110010111010100", 337 => "110010100111010", 338 => "110010010011110", 
    339 => "110010000000010", 340 => "110001101100011", 341 => "110001011000100", 
    342 => "110001000100100", 343 => "110000110000010", 344 => "110000011100000", 
    345 => "110000000111100", 346 => "101111110010111", 347 => "101111011110010", 
    348 => "101111001001011", 349 => "101110110100011", 350 => "101110011111011", 
    351 => "101110001010001", 352 => "101101110100111", 353 => "101101011111011", 
    354 => "101101001001111", 355 => "101100110100010", 356 => "101100011110100", 
    357 => "101100001000110", 358 => "101011110010110", 359 => "101011011100110", 
    360 => "101011000110110", 361 => "101010110000100", 362 => "101010011010010", 
    363 => "101010000100000", 364 => "101001101101101", 365 => "101001010111001", 
    366 => "101001000000101", 367 => "101000101010000", 368 => "101000010011011", 
    369 => "100111111100101", 370 => "100111100101111", 371 => "100111001111001", 
    372 => "100110111000010", 373 => "100110100001011", 374 => "100110001010011", 
    375 => "100101110011100", 376 => "100101011100100", 377 => "100101000101011", 
    378 => "100100101110011", 379 => "100100010111011", 380 => "100100000000010", 
    381 => "100011101001001", 382 => "100011010010000", 383 => "100010111010111", 
    384 => "100010100011110", 385 => "100010001100101", 386 => "100001110101100", 
    387 => "100001011110011", 388 => "100001000111011", 389 => "100000110000010", 
    390 => "100000011001001", 391 => "100000000010001", 392 => "011111101011001", 
    393 => "011111010100001", 394 => "011110111101001", 395 => "011110100110010", 
    396 => "011110001111011", 397 => "011101111000100", 398 => "011101100001101", 
    399 => "011101001010111", 400 => "011100110100010", 401 => "011100011101100", 
    402 => "011100000111000", 403 => "011011110000011", 404 => "011011011010000", 
    405 => "011011000011101", 406 => "011010101101010", 407 => "011010010111000", 
    408 => "011010000000111", 409 => "011001101010110", 410 => "011001010100110", 
    411 => "011000111110111", 412 => "011000101001000", 413 => "011000010011010", 
    414 => "010111111101101", 415 => "010111101000001", 416 => "010111010010110", 
    417 => "010110111101011", 418 => "010110101000010", 419 => "010110010011001", 
    420 => "010101111110010", 421 => "010101101001011", 422 => "010101010100101", 
    423 => "010101000000000", 424 => "010100101011101", 425 => "010100010111010", 
    426 => "010100000011001", 427 => "010011101111000", 428 => "010011011011001", 
    429 => "010011000111011", 430 => "010010110011110", 431 => "010010100000010", 
    432 => "010010001101000", 433 => "010001111001111", 434 => "010001100110111", 
    435 => "010001010100000", 436 => "010001000001011", 437 => "010000101110111", 
    438 => "010000011100101", 439 => "010000001010100", 440 => "001111111000100", 
    441 => "001111100110110", 442 => "001111010101001", 443 => "001111000011101", 
    444 => "001110110010100", 445 => "001110100001011", 446 => "001110010000101", 
    447 => "001101111111111", 448 => "001101101111100", 449 => "001101011111010", 
    450 => "001101001111001", 451 => "001100111111011", 452 => "001100101111110", 
    453 => "001100100000010", 454 => "001100010001001", 455 => "001100000010001", 
    456 => "001011110011010", 457 => "001011100100110", 458 => "001011010110011", 
    459 => "001011001000010", 460 => "001010111010011", 461 => "001010101100110", 
    462 => "001010011111011", 463 => "001010010010001", 464 => "001010000101001", 
    465 => "001001111000011", 466 => "001001101100000", 467 => "001001011111110", 
    468 => "001001010011101", 469 => "001001000111111", 470 => "001000111100011", 
    471 => "001000110001001", 472 => "001000100110001", 473 => "001000011011011", 
    474 => "001000010000110", 475 => "001000000110100", 476 => "000111111100100", 
    477 => "000111110010110", 478 => "000111101001010", 479 => "000111100000000", 
    480 => "000111010111000", 481 => "000111001110011", 482 => "000111000101111", 
    483 => "000110111101101", 484 => "000110110101110", 485 => "000110101110001", 
    486 => "000110100110110", 487 => "000110011111101", 488 => "000110011000110", 
    489 => "000110010010001", 490 => "000110001011111", 491 => "000110000101111", 
    492 => "000110000000001", 493 => "000101111010101", 494 => "000101110101011", 
    495 => "000101110000100", 496 => "000101101011111", 497 => "000101100111100", 
    498 => "000101100011011", 499 => "000101011111100", 500 => "000101011100000", 
    501 => "000101011000110", 502 => "000101010101110", 503 => "000101010011001", 
    504 => "000101010000110", 505 => "000101001110101", 506 => "000101001100110", 
    507 => "000101001011001", 508 => "000101001001111", 509 => "000101001000111", 
    510 => "000101001000001", 511 => "000101000111110" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe is
    generic (
        DataWidth : INTEGER := 15;
        AddressRange : INTEGER := 512;
        AddressWidth : INTEGER := 9);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe is
    component hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe_rom_U :  component hls_real2xfft_window_fn_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_3_0_ap_fixed_16_1_5_0_0_1024_2_dEe_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


