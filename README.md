SUTD CS 1D


## 50.002 1D Project Documentation

Week 8 Checkoff 1

### Team 4:

| 1006084 | Patrick Phone Myat Mo |
| --- | --- |
| 1006118 | Ng Junhao Marcus |
| 1006105 | Dangi Smriti |
| 1005936 | Chun Zhi Heng Davis |
| 1005984 | Ng Hau Yin Kendrick |
| 1006184 | Atul Parida |

## Instruction Set

We have designed an instruction set for the operators we wish to utilize in our game in the table below, organized by the opcode which relates to the operation followed by the module where it is programmed

| OPCODE | Operation Used | Module |
| --- | --- | --- |
| 00 00X0 | ADDER | adder16
 |
| 00 00X1 | SUBTRACT |
| 00 0100 | MULTIPLY | multiplier16 |
| 01 0000 | ZERO | boolean16 |
| 01 0001 | NOR |
| 01 0011 | NOT 'X' |
| 01 0101 | NOT 'Y' |
| 01 0110 | XOR |
| 01 0111 | NAND |
| 01 1000 | AND |
| 01 1001 | XNOR |
| 01 1010 | 'X' |
| 01 1100 | 'Y' |
| 01 1110 | OR |
| 01 1111 | ONE |
| 10 0000 | SHIFT LEFT | shifter16
 |
| 10 0001 | SHIFT RIGHT |
| 10 0011 | SHIFT RIGHT ARITHMETIC |
| 11 001X | CMPEQ | comparator16 |
| 11 010X | CMPLT |
| 11 011X | CMPLE |
| 11 101X | MAXIMUM |
| 11 110X | MINIMUM |

Fig. 1: Instruction set for ALU

## FPGA Diagram

![](RackMultipart20230315-1-tiojtu_html_bf03cfbb3a8b060.png)

Fig. 2 Annotated FPGA Diagram

The functionality of the FPGA is explained in the table below:

| Inputs | Representation | Outputs | Representation |
| --- | --- | --- | --- |
| 16-bit X[15:0] | io\_dip[1], io\_dip[0] | 16-bit ALU[15:0] | io\_led[1:0] |
| 16-bit Y[15:0] | io\_dip[1], io\_dip[0] | 1-bit Z | io\_led[2][0] |
| 6-bit OPCODE ALUFN[5:0] | io\_dip[2][5:0] | 1-bit V | io\_led[2][1] |
| 1-bit N | io\_led[2][2] |

## Auto Testing

FSM will cycle through different test cases listed on the auto\_tester.luc module.

If the auto tester manages to go through all the test cases without any error, the 7-segments will display "0000". If at any point of time it fails, a letter "e" will be displayed.

1. Press io\_button[2] switching to automatic testing modes.
2. In the auto\_tester.luc module, the FSM will cycle through 18 test cases listed below.
3. If the auto tester manages to go through all the test cases without any error, the 7 segments will display " 0000".

|
 | Operation | X | Y | OPCODE | Expected Output |
| --- | --- | --- | --- | --- | --- |
| 0 | ADDER | 16h0001 | 16hFFFF | 6b000000 | 16h0000 |
| 1 |
 | 16h7FFF | 16h0001 | 6b000000 | 16h0000 |
|
 |
 | 16h0001 | 16h0002 | 6b000000 | 16h0003 |
| 2 | SUBTRACT | 16h0003 | 16h0002 | 6b000001 | 16h0001 |
| 3 |
 | 16h0000 | 16h0001 | 6b000001 | 16hFFFF |
|
 |
 | 16h7FFF | 16h0000 | 6b000001 | 16h0000 |
| 4 | MULTIPLY | 16h0003 | 16h0002 | 6b000100 | 16h0006 |
| 5 |
 | 16hFFF2 | 16hFFF3 | 6b000100 | 16hFFF3 |
| 16 | XOR | 16hffff | 16hffff | 6b010110 | 16h0000 |
| 18 | NAND | 16h2af0 | 16hafe0 | 6b010111 | 16hd51f |
| 20 | AND | 16h0000 | 16h7fff | 6b110101 | 16h0001 |
| 32 | SHIFT LEFT | 16hffff | 16h0008 | 6b100000 | 16hff00 |
| 36 | SHIFT RIGHT ARITHMETIC | 16h3fff | 16h0008 | 6b100011 | 16h003f |
| 38 | CMPEQ | 16h0001 | 16h0001 | 6b110010 | 16hFFFF |
| 40 | CMPLT | 16h0000 | 16h7fff | 6b110101 | 6b110101 |
| 42 | CMPLE | 16h7fff | 16h0000 | 6b110111 | 16h0000 |
| 44 | MAXIMUM | 16h0202 | 16hf007 | 6b111011 | 16hf007 |
| 46 | MINIMUM | 16hffff | 16hffff | 6b111101 | 16hffff |

## Manual Testing

### Procedure

1. Press io\_button[2] to switch between automatic and manual testing modes.
2. Enter the associated 6-bit OPCODE using io\_dip[2][5:0].
3. When the 7-segment display shows "X" and "Y", enter the 16-bit values for X and Y by using {io\_dip[1], io\_dip[0]} respectively.
4. Press io\_button[1] to confirm the selected inputs of X and Y.
5. When the 7-segment display shows "o", the output from the ALU will be displayed on {io\_led[1], io\_led[0]}.

| Inputs | Representation | Outputs | Representation |
| --- | --- | --- | --- |
| 16-bit X[15:0] | io\_dip[1], io\_dip[0] | 16-bit ALU[15:0] | io\_led[1:0] |
| 16-bit Y[15:0] | io\_dip[1], io\_dip[0] | 1-bit Z | io\_led[2][0] |
| 6-bit OPCODE ALUFN[5:0] | io\_dip[2][5:0] | 1-bit V | io\_led[2][1] |
| 1-bit N | io\_led[2][2] |
