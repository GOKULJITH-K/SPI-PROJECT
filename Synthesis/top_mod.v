/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Sun Sep 21 17:54:00 2025
/////////////////////////////////////////////////////////////


module spi_slave_interface ( PCLK, PRESET_n, PWRITE_i, PSEL_i, PENABLE_i, ss_i, 
        recieve_data_i, tip_i, PADDR_i, PWDATA_i, miso_data_i, mstr_o, cpol_o, 
        cpha_o, lsbfe_o, spiswai_o, spi_interrupt_request_o, PREADY_o, 
        PSLVERR_o, send_data_o, mosi_data_o, spi_mode_o, sppr_o, spr_o, 
        PRDATA_o );
  input [2:0] PADDR_i;
  input [7:0] PWDATA_i;
  input [7:0] miso_data_i;
  output [7:0] mosi_data_o;
  output [1:0] spi_mode_o;
  output [2:0] sppr_o;
  output [2:0] spr_o;
  output [7:0] PRDATA_o;
  input PCLK, PRESET_n, PWRITE_i, PSEL_i, PENABLE_i, ss_i, recieve_data_i,
         tip_i;
  output mstr_o, cpol_o, cpha_o, lsbfe_o, spiswai_o, spi_interrupt_request_o,
         PREADY_o, PSLVERR_o, send_data_o;
  wire   n189, \next_state[1] , \next_mode[1] , SPI_CR_1_1, SPI_CR_2_0, modf,
         N173, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n155, n156, n157, n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n154, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187;
  wire   [1:0] state;
  wire   [7:5] SPI_CR_1;
  wire   [7:2] SPI_CR_2;
  wire   [7:0] SPI_DR;
  wire   [7:0] SPI_SR;

  FD2 \state_reg[0]  ( .D(n155), .CP(PCLK), .CD(PRESET_n), .Q(state[0]) );
  FD2 \state_reg[1]  ( .D(\next_state[1] ), .CP(PCLK), .CD(PRESET_n), .Q(
        state[1]), .QN(n184) );
  FD2 \SPI_CR_1_reg[7]  ( .D(n153), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_1[7]), 
        .QN(n183) );
  FD2 \SPI_CR_1_reg[6]  ( .D(n152), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_1[6]), 
        .QN(n186) );
  FD2 \SPI_CR_1_reg[5]  ( .D(n151), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_1[5]), 
        .QN(n187) );
  FD2 \SPI_CR_1_reg[4]  ( .D(n150), .CP(PCLK), .CD(PRESET_n), .Q(mstr_o), .QN(
        n182) );
  FD2 \SPI_CR_1_reg[3]  ( .D(n149), .CP(PCLK), .CD(PRESET_n), .Q(cpol_o) );
  FD2 \SPI_CR_1_reg[1]  ( .D(n147), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_1_1)
         );
  FD2 \SPI_CR_1_reg[0]  ( .D(n146), .CP(PCLK), .CD(PRESET_n), .Q(lsbfe_o) );
  FD2 \SPI_CR_2_reg[4]  ( .D(n145), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_2[4]), 
        .QN(n185) );
  FD2 \SPI_CR_2_reg[3]  ( .D(n144), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_2[3])
         );
  FD2 \SPI_CR_2_reg[1]  ( .D(n143), .CP(PCLK), .CD(PRESET_n), .Q(spiswai_o) );
  FD2 \spi_mode_o_reg[0]  ( .D(n156), .CP(PCLK), .CD(PRESET_n), .Q(n189), .QN(
        n180) );
  FD2 \spi_mode_o_reg[1]  ( .D(\next_mode[1] ), .CP(PCLK), .CD(PRESET_n), .Q(
        spi_mode_o[1]), .QN(n178) );
  FD2 \SPI_CR_2_reg[0]  ( .D(n142), .CP(PCLK), .CD(PRESET_n), .Q(SPI_CR_2_0)
         );
  FD2 \SPI_BR_reg[6]  ( .D(n141), .CP(PCLK), .CD(PRESET_n), .Q(sppr_o[2]) );
  FD2 \SPI_BR_reg[5]  ( .D(n140), .CP(PCLK), .CD(PRESET_n), .Q(sppr_o[1]) );
  FD2 \SPI_BR_reg[4]  ( .D(n139), .CP(PCLK), .CD(PRESET_n), .Q(sppr_o[0]) );
  FD2 \SPI_DR_reg[0]  ( .D(n135), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[0]), 
        .QN(n174) );
  FD2 \SPI_DR_reg[1]  ( .D(n134), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[1]), 
        .QN(n177) );
  FD2 \SPI_DR_reg[2]  ( .D(n133), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[2]), 
        .QN(n2) );
  FD2 \SPI_DR_reg[3]  ( .D(n132), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[3]), 
        .QN(n181) );
  FD2 \SPI_DR_reg[4]  ( .D(n131), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[4]), 
        .QN(n1) );
  FD2 \SPI_DR_reg[5]  ( .D(n130), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[5]), 
        .QN(n176) );
  FD2 \SPI_DR_reg[6]  ( .D(n129), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[6]), 
        .QN(n175) );
  FD2 \SPI_DR_reg[7]  ( .D(n128), .CP(PCLK), .CD(PRESET_n), .Q(SPI_DR[7]), 
        .QN(n179) );
  FD2 send_data_o_reg ( .D(n127), .CP(PCLK), .CD(PRESET_n), .Q(send_data_o) );
  FD2 \SPI_SR_reg[7]  ( .D(N173), .CP(PCLK), .CD(PRESET_n), .Q(SPI_SR[7]) );
  FD2 \SPI_SR_reg[4]  ( .D(modf), .CP(PCLK), .CD(PRESET_n), .Q(SPI_SR[4]) );
  FD4 \SPI_CR_1_reg[2]  ( .D(n148), .CP(PCLK), .SD(PRESET_n), .Q(cpha_o) );
  FD4 \SPI_SR_reg[5]  ( .D(n157), .CP(PCLK), .SD(PRESET_n), .Q(SPI_SR[5]) );
  FD2 \mosi_data_o_reg[7]  ( .D(n126), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[7]) );
  FD2 \mosi_data_o_reg[6]  ( .D(n125), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[6]) );
  FD2 \mosi_data_o_reg[5]  ( .D(n124), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[5]) );
  FD2 \mosi_data_o_reg[4]  ( .D(n123), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[4]) );
  FD2 \mosi_data_o_reg[3]  ( .D(n122), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[3]) );
  FD2 \mosi_data_o_reg[2]  ( .D(n121), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[2]) );
  FD2 \mosi_data_o_reg[1]  ( .D(n120), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[1]) );
  FD2 \mosi_data_o_reg[0]  ( .D(n119), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_data_o[0]) );
  FD2 \SPI_BR_reg[2]  ( .D(n138), .CP(PCLK), .CD(PRESET_n), .Q(spr_o[2]) );
  FD2 \SPI_BR_reg[1]  ( .D(n137), .CP(PCLK), .CD(PRESET_n), .Q(spr_o[1]) );
  FD2P \SPI_BR_reg[0]  ( .D(n136), .CP(PCLK), .CD(PRESET_n), .Q(spr_o[0]) );
  IVA U3 ( .A(n107), .Z(n167) );
  IVA U4 ( .A(n31), .Z(n144) );
  IVA U5 ( .A(n33), .Z(n149) );
  IVA U6 ( .A(n34), .Z(n146) );
  IVA U7 ( .A(n35), .Z(n148) );
  IVA U8 ( .A(n32), .Z(n142) );
  IVA U9 ( .A(n49), .Z(n48) );
  IVA U10 ( .A(n157), .Z(N173) );
  IVA U11 ( .A(n76), .Z(n77) );
  IVA U12 ( .A(n171), .Z(n37) );
  IVA U13 ( .A(n68), .Z(n70) );
  NR2 U14 ( .A(state[0]), .B(n184), .Z(PREADY_o) );
  ND4 U15 ( .A(n1), .B(n176), .C(n175), .D(n179), .Z(n4) );
  ND4 U16 ( .A(n174), .B(n177), .C(n2), .D(n181), .Z(n3) );
  NR2 U17 ( .A(n4), .B(n3), .Z(n157) );
  IVP U18 ( .A(PWRITE_i), .Z(n5) );
  ND2 U19 ( .A(PREADY_o), .B(n5), .Z(n65) );
  IVP U20 ( .A(PADDR_i[2]), .Z(n12) );
  ND2 U21 ( .A(n12), .B(PADDR_i[1]), .Z(n6) );
  NR2 U22 ( .A(n6), .B(PADDR_i[0]), .Z(n61) );
  OR2P U23 ( .A(PADDR_i[1]), .B(PADDR_i[0]), .Z(n7) );
  NR2 U24 ( .A(n7), .B(n12), .Z(n106) );
  ND2 U25 ( .A(SPI_DR[6]), .B(n106), .Z(n9) );
  NR2 U26 ( .A(n7), .B(PADDR_i[2]), .Z(n63) );
  ND2 U27 ( .A(n63), .B(SPI_CR_1[6]), .Z(n8) );
  ND2 U28 ( .A(n9), .B(n8), .Z(n10) );
  AO6 U29 ( .A(n61), .B(sppr_o[2]), .C(n10), .Z(n11) );
  NR2 U30 ( .A(n65), .B(n11), .Z(PRDATA_o[6]) );
  IVP U31 ( .A(PADDR_i[1]), .Z(n13) );
  ND2 U32 ( .A(PADDR_i[0]), .B(n12), .Z(n18) );
  NR2 U33 ( .A(n13), .B(n18), .Z(n64) );
  AO2 U34 ( .A(n64), .B(SPI_SR[5]), .C(n63), .D(SPI_CR_1[5]), .Z(n15) );
  ND2 U35 ( .A(SPI_DR[5]), .B(n106), .Z(n14) );
  ND2 U36 ( .A(n15), .B(n14), .Z(n16) );
  AO6 U37 ( .A(n61), .B(sppr_o[1]), .C(n16), .Z(n17) );
  NR2 U38 ( .A(n65), .B(n17), .Z(PRDATA_o[5]) );
  NR2 U39 ( .A(n18), .B(PADDR_i[1]), .Z(n55) );
  AO2 U40 ( .A(SPI_DR[0]), .B(n106), .C(n63), .D(lsbfe_o), .Z(n20) );
  ND2 U41 ( .A(n61), .B(spr_o[0]), .Z(n19) );
  ND2 U42 ( .A(n20), .B(n19), .Z(n21) );
  AO6 U43 ( .A(SPI_CR_2_0), .B(n55), .C(n21), .Z(n22) );
  NR2 U44 ( .A(n65), .B(n22), .Z(PRDATA_o[0]) );
  ND2 U45 ( .A(SPI_DR[2]), .B(n106), .Z(n24) );
  ND2 U46 ( .A(n61), .B(spr_o[2]), .Z(n23) );
  ND2 U47 ( .A(n24), .B(n23), .Z(n25) );
  AO6 U48 ( .A(cpha_o), .B(n63), .C(n25), .Z(n26) );
  NR2 U49 ( .A(n65), .B(n26), .Z(PRDATA_o[2]) );
  AO2 U50 ( .A(SPI_DR[1]), .B(n106), .C(n63), .D(SPI_CR_1_1), .Z(n28) );
  ND2 U51 ( .A(n61), .B(spr_o[1]), .Z(n27) );
  ND2 U52 ( .A(n28), .B(n27), .Z(n29) );
  AO6 U53 ( .A(n55), .B(spiswai_o), .C(n29), .Z(n30) );
  NR2 U54 ( .A(n65), .B(n30), .Z(PRDATA_o[1]) );
  AN2P U55 ( .A(PREADY_o), .B(PWRITE_i), .Z(n171) );
  ND2 U56 ( .A(n171), .B(n55), .Z(n76) );
  AO4 U57 ( .A(n76), .B(PWDATA_i[3]), .C(SPI_CR_2[3]), .D(n77), .Z(n31) );
  AO4 U58 ( .A(n76), .B(PWDATA_i[0]), .C(SPI_CR_2_0), .D(n77), .Z(n32) );
  ND2 U59 ( .A(n171), .B(n63), .Z(n74) );
  IVP U60 ( .A(n74), .Z(n75) );
  AO4 U61 ( .A(n74), .B(PWDATA_i[3]), .C(cpol_o), .D(n75), .Z(n33) );
  AO4 U62 ( .A(n74), .B(PWDATA_i[0]), .C(lsbfe_o), .D(n75), .Z(n34) );
  AO4 U63 ( .A(n74), .B(PWDATA_i[2]), .C(cpha_o), .D(n75), .Z(n35) );
  IVP U64 ( .A(n61), .Z(n36) );
  NR2 U65 ( .A(n37), .B(n36), .Z(n49) );
  ND2 U66 ( .A(sppr_o[1]), .B(n48), .Z(n39) );
  ND2 U67 ( .A(n49), .B(PWDATA_i[5]), .Z(n38) );
  ND2 U68 ( .A(n39), .B(n38), .Z(n140) );
  ND2 U69 ( .A(sppr_o[2]), .B(n48), .Z(n41) );
  ND2 U70 ( .A(n49), .B(PWDATA_i[6]), .Z(n40) );
  ND2 U71 ( .A(n41), .B(n40), .Z(n141) );
  ND2 U72 ( .A(sppr_o[0]), .B(n48), .Z(n43) );
  ND2 U73 ( .A(n49), .B(PWDATA_i[4]), .Z(n42) );
  ND2 U74 ( .A(n43), .B(n42), .Z(n139) );
  ND2 U75 ( .A(spr_o[1]), .B(n48), .Z(n45) );
  ND2 U76 ( .A(n49), .B(PWDATA_i[1]), .Z(n44) );
  ND2 U77 ( .A(n45), .B(n44), .Z(n137) );
  ND2 U78 ( .A(spr_o[0]), .B(n48), .Z(n47) );
  ND2 U79 ( .A(n49), .B(PWDATA_i[0]), .Z(n46) );
  ND2 U80 ( .A(n47), .B(n46), .Z(n136) );
  ND2 U81 ( .A(spr_o[2]), .B(n48), .Z(n51) );
  ND2 U82 ( .A(n49), .B(PWDATA_i[2]), .Z(n50) );
  ND2 U83 ( .A(n51), .B(n50), .Z(n138) );
  NR4 U84 ( .A(SPI_CR_1_1), .B(ss_i), .C(n182), .D(n185), .Z(modf) );
  NR2 U85 ( .A(modf), .B(N173), .Z(n52) );
  AO4 U86 ( .A(n183), .B(n52), .C(n187), .D(N173), .Z(spi_interrupt_request_o)
         );
  AO7 U87 ( .A(spi_mode_o[1]), .B(n189), .C(spiswai_o), .Z(n68) );
  AO7 U88 ( .A(n180), .B(n178), .C(n186), .Z(n69) );
  NR2 U89 ( .A(n68), .B(n69), .Z(\next_mode[1] ) );
  AN4P U90 ( .A(state[0]), .B(PENABLE_i), .C(PSEL_i), .D(n184), .Z(
        \next_state[1] ) );
  AO2 U91 ( .A(n55), .B(SPI_CR_2[3]), .C(n63), .D(cpol_o), .Z(n54) );
  ND2 U92 ( .A(SPI_DR[3]), .B(n106), .Z(n53) );
  AO6 U93 ( .A(n54), .B(n53), .C(n65), .Z(PRDATA_o[3]) );
  AO2 U94 ( .A(n55), .B(SPI_CR_2[4]), .C(n63), .D(mstr_o), .Z(n56) );
  IVP U95 ( .A(n56), .Z(n57) );
  AO6 U96 ( .A(SPI_SR[4]), .B(n64), .C(n57), .Z(n59) );
  ND2 U97 ( .A(n106), .B(SPI_DR[4]), .Z(n58) );
  ND2 U98 ( .A(n59), .B(n58), .Z(n60) );
  AO6 U99 ( .A(sppr_o[0]), .B(n61), .C(n60), .Z(n62) );
  NR2 U100 ( .A(n62), .B(n65), .Z(PRDATA_o[4]) );
  AO2 U101 ( .A(n64), .B(SPI_SR[7]), .C(n63), .D(SPI_CR_1[7]), .Z(n67) );
  ND2 U102 ( .A(SPI_DR[7]), .B(n106), .Z(n66) );
  AO6 U103 ( .A(n67), .B(n66), .C(n65), .Z(PRDATA_o[7]) );
  AN2P U104 ( .A(PREADY_o), .B(ss_i), .Z(PSLVERR_o) );
  NR2 U105 ( .A(n70), .B(n69), .Z(n156) );
  IVP U106 ( .A(PSEL_i), .Z(n73) );
  NR2 U107 ( .A(PENABLE_i), .B(state[1]), .Z(n71) );
  NR2 U108 ( .A(PREADY_o), .B(n71), .Z(n72) );
  NR2 U109 ( .A(n73), .B(n72), .Z(n155) );
  IVP U110 ( .A(PWDATA_i[7]), .Z(n79) );
  AO2 U111 ( .A(n75), .B(n79), .C(n183), .D(n74), .Z(n153) );
  IVP U112 ( .A(PWDATA_i[6]), .Z(n98) );
  AO2 U113 ( .A(n75), .B(n98), .C(n186), .D(n74), .Z(n152) );
  IVP U114 ( .A(PWDATA_i[5]), .Z(n80) );
  AO2 U115 ( .A(n75), .B(n80), .C(n187), .D(n74), .Z(n151) );
  IVP U116 ( .A(PWDATA_i[4]), .Z(n97) );
  AO2 U117 ( .A(n75), .B(n97), .C(n182), .D(n74), .Z(n150) );
  IVP U118 ( .A(PWDATA_i[1]), .Z(n78) );
  EO1 U119 ( .A(n75), .B(n78), .C(SPI_CR_1_1), .D(n75), .Z(n147) );
  AO2 U120 ( .A(n77), .B(n97), .C(n185), .D(n76), .Z(n145) );
  EO1 U121 ( .A(n77), .B(n78), .C(spiswai_o), .D(n77), .Z(n143) );
  AO2 U122 ( .A(SPI_DR[1]), .B(PWDATA_i[1]), .C(n78), .D(n177), .Z(n105) );
  AO2 U123 ( .A(SPI_DR[7]), .B(PWDATA_i[7]), .C(n79), .D(n179), .Z(n104) );
  EO1 U124 ( .A(SPI_DR[2]), .B(PWDATA_i[2]), .C(PWDATA_i[2]), .D(SPI_DR[2]), 
        .Z(n84) );
  EO1 U125 ( .A(SPI_DR[0]), .B(PWDATA_i[0]), .C(PWDATA_i[0]), .D(SPI_DR[0]), 
        .Z(n83) );
  AO2 U126 ( .A(SPI_DR[5]), .B(PWDATA_i[5]), .C(n80), .D(n176), .Z(n82) );
  EO1 U127 ( .A(SPI_DR[3]), .B(PWDATA_i[3]), .C(PWDATA_i[3]), .D(SPI_DR[3]), 
        .Z(n81) );
  NR4 U128 ( .A(n84), .B(n83), .C(n82), .D(n81), .Z(n102) );
  EO1 U129 ( .A(SPI_DR[1]), .B(miso_data_i[1]), .C(miso_data_i[1]), .D(
        SPI_DR[1]), .Z(n86) );
  NR2 U130 ( .A(miso_data_i[0]), .B(n174), .Z(n85) );
  AO1P U131 ( .A(miso_data_i[0]), .B(n174), .C(n86), .D(n85), .Z(n96) );
  EO1 U132 ( .A(miso_data_i[3]), .B(SPI_DR[3]), .C(SPI_DR[3]), .D(
        miso_data_i[3]), .Z(n88) );
  NR2 U133 ( .A(miso_data_i[2]), .B(n2), .Z(n87) );
  AO1P U134 ( .A(miso_data_i[2]), .B(n2), .C(n88), .D(n87), .Z(n95) );
  EO1 U135 ( .A(miso_data_i[5]), .B(SPI_DR[5]), .C(SPI_DR[5]), .D(
        miso_data_i[5]), .Z(n90) );
  NR2 U136 ( .A(miso_data_i[4]), .B(n1), .Z(n89) );
  AO1P U137 ( .A(miso_data_i[4]), .B(n1), .C(n90), .D(n89), .Z(n94) );
  EO1 U138 ( .A(miso_data_i[7]), .B(SPI_DR[7]), .C(SPI_DR[7]), .D(
        miso_data_i[7]), .Z(n92) );
  NR2 U139 ( .A(miso_data_i[6]), .B(n175), .Z(n91) );
  AO1P U140 ( .A(miso_data_i[6]), .B(n175), .C(n92), .D(n91), .Z(n93) );
  ND4 U141 ( .A(n96), .B(n95), .C(n94), .D(n93), .Z(n101) );
  AO2 U142 ( .A(SPI_DR[4]), .B(n97), .C(PWDATA_i[4]), .D(n1), .Z(n100) );
  AO2 U143 ( .A(SPI_DR[6]), .B(n98), .C(PWDATA_i[6]), .D(n175), .Z(n99) );
  ND4 U144 ( .A(n102), .B(n101), .C(n100), .D(n99), .Z(n103) );
  NR4 U145 ( .A(n105), .B(spi_mode_o[1]), .C(n104), .D(n103), .Z(n107) );
  AO7 U146 ( .A(recieve_data_i), .B(n180), .C(n178), .Z(n108) );
  AO1P U147 ( .A(PWRITE_i), .B(PREADY_o), .C(n107), .D(n108), .Z(n163) );
  AN2P U148 ( .A(n171), .B(n106), .Z(n162) );
  AO2 U149 ( .A(miso_data_i[0]), .B(n163), .C(PWDATA_i[0]), .D(n162), .Z(n111)
         );
  AO2 U150 ( .A(PREADY_o), .B(PWRITE_i), .C(n167), .D(n108), .Z(n109) );
  NR2 U151 ( .A(n109), .B(n162), .Z(n164) );
  ND2 U152 ( .A(SPI_DR[0]), .B(n164), .Z(n110) );
  ND2 U153 ( .A(n111), .B(n110), .Z(n135) );
  AO2 U154 ( .A(miso_data_i[1]), .B(n163), .C(PWDATA_i[1]), .D(n162), .Z(n113)
         );
  ND2 U155 ( .A(SPI_DR[1]), .B(n164), .Z(n112) );
  ND2 U156 ( .A(n113), .B(n112), .Z(n134) );
  AO2 U157 ( .A(miso_data_i[2]), .B(n163), .C(PWDATA_i[2]), .D(n162), .Z(n115)
         );
  ND2 U158 ( .A(SPI_DR[2]), .B(n164), .Z(n114) );
  ND2 U159 ( .A(n115), .B(n114), .Z(n133) );
  AO2 U160 ( .A(miso_data_i[3]), .B(n163), .C(PWDATA_i[3]), .D(n162), .Z(n117)
         );
  ND2 U161 ( .A(SPI_DR[3]), .B(n164), .Z(n116) );
  ND2 U162 ( .A(n117), .B(n116), .Z(n132) );
  AO2 U163 ( .A(miso_data_i[4]), .B(n163), .C(PWDATA_i[4]), .D(n162), .Z(n154)
         );
  ND2 U164 ( .A(SPI_DR[4]), .B(n164), .Z(n118) );
  ND2 U165 ( .A(n154), .B(n118), .Z(n131) );
  AO2 U166 ( .A(miso_data_i[5]), .B(n163), .C(PWDATA_i[5]), .D(n162), .Z(n159)
         );
  ND2 U167 ( .A(SPI_DR[5]), .B(n164), .Z(n158) );
  ND2 U168 ( .A(n159), .B(n158), .Z(n130) );
  AO2 U169 ( .A(miso_data_i[6]), .B(n163), .C(PWDATA_i[6]), .D(n162), .Z(n161)
         );
  ND2 U170 ( .A(SPI_DR[6]), .B(n164), .Z(n160) );
  ND2 U171 ( .A(n161), .B(n160), .Z(n129) );
  AO2 U172 ( .A(miso_data_i[7]), .B(n163), .C(PWDATA_i[7]), .D(n162), .Z(n166)
         );
  ND2 U173 ( .A(SPI_DR[7]), .B(n164), .Z(n165) );
  ND2 U174 ( .A(n166), .B(n165), .Z(n128) );
  ND2 U175 ( .A(recieve_data_i), .B(n178), .Z(n170) );
  ND2 U176 ( .A(send_data_o), .B(n171), .Z(n169) );
  NR2 U177 ( .A(n171), .B(n167), .Z(n172) );
  AO3 U178 ( .A(n171), .B(n170), .C(n169), .D(n168), .Z(n127) );
  IVDA U179 ( .A(n172), .Y(n168), .Z(n173) );
  EO1 U180 ( .A(n173), .B(n179), .C(mosi_data_o[7]), .D(n173), .Z(n126) );
  EO1 U181 ( .A(n173), .B(n175), .C(mosi_data_o[6]), .D(n173), .Z(n125) );
  EO1 U182 ( .A(n173), .B(n176), .C(mosi_data_o[5]), .D(n173), .Z(n124) );
  EO1 U183 ( .A(n173), .B(n1), .C(mosi_data_o[4]), .D(n173), .Z(n123) );
  EO1 U184 ( .A(n173), .B(n181), .C(mosi_data_o[3]), .D(n173), .Z(n122) );
  EO1 U185 ( .A(n173), .B(n2), .C(mosi_data_o[2]), .D(n173), .Z(n121) );
  EO1 U186 ( .A(n173), .B(n177), .C(mosi_data_o[1]), .D(n173), .Z(n120) );
  EO1 U187 ( .A(n173), .B(n174), .C(mosi_data_o[0]), .D(n173), .Z(n119) );
endmodule


module spi_baud_generator ( PCLK, PRESET_n, spiswai_i, cpol_i, cpha_i, ss_i, 
        sppr_i, spr_i, spi_mode_i, sclk_o, miso_recieve_sclk_o, 
        miso_recieve_sclk0_o, mosi_send_sclk0_o, BaudRateDivisor_o, 
        mosi_send_sclk_o_BAR );
  input [2:0] sppr_i;
  input [2:0] spr_i;
  input [1:0] spi_mode_i;
  output [11:0] BaudRateDivisor_o;
  input PCLK, PRESET_n, spiswai_i, cpol_i, cpha_i, ss_i;
  output sclk_o, miso_recieve_sclk_o, miso_recieve_sclk0_o, mosi_send_sclk0_o,
         mosi_send_sclk_o_BAR;
  wire   mosi_send_sclk_o, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78,
         N79, N80, n24, n25, n26, n27, n28, n29, n30,
         \DP_OP_44J1_124_8366/n442 , \DP_OP_44J1_124_8366/n439 ,
         \DP_OP_44J1_124_8366/n434 , \DP_OP_44J1_124_8366/n431 ,
         \DP_OP_44J1_124_8366/n428 , \DP_OP_44J1_124_8366/n419 ,
         \DP_OP_44J1_124_8366/n390 , n3, n4, n5, n6, n7, n8, n9, n10, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n31, n32, n33, n34,
         n35, n36, n37, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231;
  wire   [11:0] counter_s;
  assign BaudRateDivisor_o[1] = \DP_OP_44J1_124_8366/n442 ;
  assign BaudRateDivisor_o[2] = \DP_OP_44J1_124_8366/n439 ;
  assign BaudRateDivisor_o[3] = \DP_OP_44J1_124_8366/n434 ;
  assign BaudRateDivisor_o[4] = \DP_OP_44J1_124_8366/n431 ;
  assign BaudRateDivisor_o[5] = \DP_OP_44J1_124_8366/n428 ;
  assign BaudRateDivisor_o[6] = \DP_OP_44J1_124_8366/n419 ;
  assign BaudRateDivisor_o[10] = \DP_OP_44J1_124_8366/n390 ;

  FD3 sclk_o_reg ( .D(n30), .CP(PCLK), .CD(n24), .SD(n25), .Q(sclk_o), .QN(
        n229) );
  FD2 \counter_s_reg[11]  ( .D(N80), .CP(PCLK), .CD(PRESET_n), .Q(
        counter_s[11]) );
  FD2 \counter_s_reg[10]  ( .D(N79), .CP(PCLK), .CD(PRESET_n), .Q(
        counter_s[10]), .QN(n5) );
  FD2 \counter_s_reg[9]  ( .D(N78), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[9]), 
        .QN(n228) );
  FD2 \counter_s_reg[8]  ( .D(N77), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[8])
         );
  FD2 \counter_s_reg[7]  ( .D(N76), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[7]), 
        .QN(n227) );
  FD2 \counter_s_reg[6]  ( .D(N75), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[6])
         );
  FD2 \counter_s_reg[5]  ( .D(N74), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[5]), 
        .QN(n226) );
  FD2 \counter_s_reg[4]  ( .D(N73), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[4])
         );
  FD2 \counter_s_reg[3]  ( .D(N72), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[3]), 
        .QN(n225) );
  FD2 \counter_s_reg[2]  ( .D(N71), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[2])
         );
  FD2 \counter_s_reg[1]  ( .D(N70), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[1]), 
        .QN(n224) );
  FD2 \counter_s_reg[0]  ( .D(N69), .CP(PCLK), .CD(PRESET_n), .Q(counter_s[0]), 
        .QN(n223) );
  FD2 miso_recieve_sclk_o_reg ( .D(n29), .CP(PCLK), .CD(PRESET_n), .Q(
        miso_recieve_sclk_o), .QN(n230) );
  FD2 miso_recieve_sclk0_o_reg ( .D(n28), .CP(PCLK), .CD(PRESET_n), .Q(
        miso_recieve_sclk0_o), .QN(n231) );
  FD2 mosi_send_sclk_o_reg ( .D(n27), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_send_sclk_o), .QN(mosi_send_sclk_o_BAR) );
  FD2 mosi_send_sclk0_o_reg ( .D(n26), .CP(PCLK), .CD(PRESET_n), .Q(
        mosi_send_sclk0_o) );
  FA1A U3 ( .A(n20), .B(n19), .CI(n18), .CO(n148), .S(n23) );
  FA1A U4 ( .A(n73), .B(n72), .CI(n71), .CO(n64), .S(n82) );
  FA1A U5 ( .A(n33), .B(n32), .CI(n31), .CO(n22), .S(n46) );
  NR2 U6 ( .A(n13), .B(n12), .Z(n17) );
  B2I U7 ( .A(n127), .Z1(n3), .Z2(n4) );
  IVDA U8 ( .A(n48), .Y(BaudRateDivisor_o[8]), .Z(n6) );
  AN2P U9 ( .A(n65), .B(n64), .Z(n7) );
  AN2P U10 ( .A(n87), .B(n86), .Z(n8) );
  NR2 U11 ( .A(n150), .B(n149), .Z(BaudRateDivisor_o[11]) );
  IVA U12 ( .A(n177), .Z(n178) );
  IVA U13 ( .A(\DP_OP_44J1_124_8366/n390 ), .Z(n184) );
  IVA U14 ( .A(\DP_OP_44J1_124_8366/n428 ), .Z(n172) );
  IVA U15 ( .A(n94), .Z(n100) );
  AN2P U16 ( .A(n145), .B(n228), .Z(n146) );
  EN U17 ( .A(n87), .B(n86), .Z(n88) );
  IVA U18 ( .A(n148), .Z(n150) );
  IVA U19 ( .A(n203), .Z(n143) );
  FA1A U20 ( .A(n81), .B(n80), .CI(n79), .CO(n83), .S(n86) );
  AN2P U21 ( .A(n136), .B(n226), .Z(n137) );
  IVA U22 ( .A(n201), .Z(n140) );
  IVA U23 ( .A(n221), .Z(n134) );
  IVA U24 ( .A(n209), .Z(n210) );
  IVA U25 ( .A(n219), .Z(n131) );
  IVA U26 ( .A(n218), .Z(n215) );
  IVA U27 ( .A(cpol_i), .Z(n152) );
  EN U28 ( .A(n7), .B(n47), .Z(n48) );
  ND3 U29 ( .A(n113), .B(n112), .C(n114), .Z(n115) );
  ND2 U30 ( .A(n122), .B(n97), .Z(n123) );
  IVP U31 ( .A(sppr_i[2]), .Z(n70) );
  ND2 U32 ( .A(spr_i[1]), .B(spr_i[2]), .Z(n12) );
  OR2P U33 ( .A(spr_i[0]), .B(n12), .Z(n35) );
  NR2 U34 ( .A(n70), .B(n35), .Z(n20) );
  IVP U35 ( .A(spr_i[0]), .Z(n13) );
  IVP U36 ( .A(n17), .Z(n15) );
  NR2 U37 ( .A(n14), .B(n15), .Z(n19) );
  IVP U38 ( .A(sppr_i[1]), .Z(n66) );
  NR2 U39 ( .A(n66), .B(n15), .Z(n18) );
  NR2 U40 ( .A(n66), .B(n35), .Z(n33) );
  IVP U41 ( .A(spr_i[1]), .Z(n50) );
  ND3 U42 ( .A(spr_i[0]), .B(spr_i[2]), .C(n50), .Z(n44) );
  NR2 U43 ( .A(n70), .B(n44), .Z(n32) );
  IVDA U44 ( .A(sppr_i[0]), .Y(n14), .Z(n61) );
  MUX21L U45 ( .A(n15), .B(n35), .S(n61), .Z(n31) );
  ND2 U46 ( .A(n23), .B(n22), .Z(n16) );
  ND2 U47 ( .A(sppr_i[2]), .B(n17), .Z(n149) );
  EN U48 ( .A(n149), .B(n148), .Z(n21) );
  EN U49 ( .A(n16), .B(n21), .Z(\DP_OP_44J1_124_8366/n390 ) );
  EO U50 ( .A(n23), .B(n22), .Z(n37) );
  NR2 U51 ( .A(n66), .B(n44), .Z(n42) );
  NR2 U52 ( .A(spr_i[1]), .B(spr_i[0]), .Z(n34) );
  ND2 U53 ( .A(spr_i[2]), .B(n34), .Z(n68) );
  NR2 U54 ( .A(n70), .B(n68), .Z(n41) );
  MUX21L U55 ( .A(n35), .B(n44), .S(n61), .Z(n40) );
  ND2 U56 ( .A(n46), .B(n45), .Z(n36) );
  EN U57 ( .A(n37), .B(n36), .Z(BaudRateDivisor_o[9]) );
  IVDA U58 ( .A(BaudRateDivisor_o[9]), .Y(n39), .Z(n10) );
  FA1A U59 ( .A(n42), .B(n41), .CI(n40), .CO(n45), .S(n65) );
  NR2 U60 ( .A(n66), .B(n68), .Z(n73) );
  IVP U61 ( .A(spr_i[2]), .Z(n43) );
  ND2 U62 ( .A(spr_i[0]), .B(n43), .Z(n49) );
  OR2P U63 ( .A(n49), .B(n50), .Z(n67) );
  NR2 U64 ( .A(n70), .B(n67), .Z(n72) );
  MUX21L U65 ( .A(n44), .B(n68), .S(n61), .Z(n71) );
  EO U66 ( .A(n46), .B(n45), .Z(n47) );
  OR2P U67 ( .A(spr_i[1]), .B(n49), .Z(n54) );
  NR2 U68 ( .A(spr_i[0]), .B(spr_i[2]), .Z(n51) );
  ND2 U69 ( .A(n51), .B(n50), .Z(n60) );
  MUX21L U70 ( .A(n54), .B(n60), .S(n61), .Z(n63) );
  IVP U71 ( .A(n60), .Z(n52) );
  AN2P U72 ( .A(sppr_i[1]), .B(n52), .Z(n62) );
  AN2P U73 ( .A(n63), .B(n62), .Z(n57) );
  ND2 U74 ( .A(n51), .B(spr_i[1]), .Z(n69) );
  MUX21L U75 ( .A(n69), .B(n54), .S(n61), .Z(n56) );
  ND2 U76 ( .A(n52), .B(sppr_i[2]), .Z(n53) );
  AO7 U77 ( .A(n54), .B(n66), .C(n53), .Z(n58) );
  AO7 U78 ( .A(n57), .B(n56), .C(n58), .Z(n89) );
  NR2 U79 ( .A(n54), .B(n70), .Z(n55) );
  MUX21L U80 ( .A(n67), .B(n69), .S(n61), .Z(n77) );
  NR2 U81 ( .A(n66), .B(n69), .Z(n78) );
  EO3P U82 ( .A(n55), .B(n77), .C(n78), .Z(n85) );
  EN U83 ( .A(n89), .B(n85), .Z(\DP_OP_44J1_124_8366/n431 ) );
  NR2 U84 ( .A(n57), .B(n56), .Z(n59) );
  EN U85 ( .A(n59), .B(n58), .Z(\DP_OP_44J1_124_8366/n434 ) );
  NR2 U86 ( .A(n61), .B(n60), .Z(\DP_OP_44J1_124_8366/n442 ) );
  EO U87 ( .A(n63), .B(n62), .Z(\DP_OP_44J1_124_8366/n439 ) );
  EN U88 ( .A(n65), .B(n64), .Z(n75) );
  NR2 U89 ( .A(n66), .B(n67), .Z(n81) );
  MUX21L U90 ( .A(n68), .B(n67), .S(sppr_i[0]), .Z(n80) );
  NR2 U91 ( .A(n70), .B(n69), .Z(n79) );
  ND2 U92 ( .A(n83), .B(n82), .Z(n74) );
  EN U93 ( .A(n75), .B(n74), .Z(n76) );
  IVDA U94 ( .A(n76), .Y(BaudRateDivisor_o[7]), .Z(n9) );
  AN2P U95 ( .A(n78), .B(n77), .Z(n87) );
  EN U96 ( .A(n83), .B(n82), .Z(n84) );
  EN U97 ( .A(n8), .B(n84), .Z(\DP_OP_44J1_124_8366/n419 ) );
  IVDA U98 ( .A(n85), .Y(n90) );
  MUX21L U99 ( .A(n90), .B(n88), .S(n89), .Z(\DP_OP_44J1_124_8366/n428 ) );
  NR3 U100 ( .A(ss_i), .B(spi_mode_i[1]), .C(spiswai_i), .Z(n209) );
  EN U101 ( .A(\DP_OP_44J1_124_8366/n390 ), .B(n10), .Z(n92) );
  IVP U102 ( .A(\DP_OP_44J1_124_8366/n431 ), .Z(n154) );
  OR2P U103 ( .A(\DP_OP_44J1_124_8366/n442 ), .B(\DP_OP_44J1_124_8366/n439 ), 
        .Z(n94) );
  NR2 U104 ( .A(\DP_OP_44J1_124_8366/n434 ), .B(n94), .Z(n91) );
  AN2P U105 ( .A(n154), .B(n91), .Z(n97) );
  NR2 U106 ( .A(\DP_OP_44J1_124_8366/n419 ), .B(\DP_OP_44J1_124_8366/n428 ), 
        .Z(n120) );
  ND4 U107 ( .A(n6), .B(n97), .C(n9), .D(n120), .Z(n109) );
  MUX21L U108 ( .A(n92), .B(\DP_OP_44J1_124_8366/n390 ), .S(n109), .Z(n93) );
  EN U109 ( .A(n93), .B(counter_s[9]), .Z(n116) );
  EN U110 ( .A(\DP_OP_44J1_124_8366/n431 ), .B(\DP_OP_44J1_124_8366/n434 ), 
        .Z(n95) );
  MUX21L U111 ( .A(\DP_OP_44J1_124_8366/n431 ), .B(n95), .S(n100), .Z(n96) );
  EN U112 ( .A(n96), .B(counter_s[3]), .Z(n107) );
  IVP U113 ( .A(n97), .Z(n121) );
  EN U114 ( .A(\DP_OP_44J1_124_8366/n428 ), .B(counter_s[4]), .Z(n98) );
  EN U115 ( .A(n121), .B(n98), .Z(n105) );
  EN U116 ( .A(\DP_OP_44J1_124_8366/n442 ), .B(counter_s[1]), .Z(n99) );
  EN U117 ( .A(\DP_OP_44J1_124_8366/n439 ), .B(n99), .Z(n104) );
  EN U118 ( .A(\DP_OP_44J1_124_8366/n442 ), .B(counter_s[0]), .Z(n164) );
  NR2 U119 ( .A(counter_s[11]), .B(n164), .Z(n103) );
  EO U120 ( .A(n100), .B(counter_s[2]), .Z(n101) );
  EN U121 ( .A(n101), .B(\DP_OP_44J1_124_8366/n434 ), .Z(n102) );
  ND4 U122 ( .A(n105), .B(n104), .C(n103), .D(n102), .Z(n106) );
  NR2 U123 ( .A(n107), .B(n106), .Z(n114) );
  EN U124 ( .A(BaudRateDivisor_o[9]), .B(counter_s[8]), .Z(n108) );
  EN U125 ( .A(n109), .B(n108), .Z(n113) );
  EN U126 ( .A(\DP_OP_44J1_124_8366/n419 ), .B(\DP_OP_44J1_124_8366/n428 ), 
        .Z(n110) );
  MUX21L U127 ( .A(n110), .B(\DP_OP_44J1_124_8366/n419 ), .S(n121), .Z(n111)
         );
  EO U128 ( .A(n111), .B(counter_s[5]), .Z(n112) );
  NR2 U129 ( .A(n116), .B(n115), .Z(n126) );
  EN U130 ( .A(BaudRateDivisor_o[8]), .B(BaudRateDivisor_o[7]), .Z(n117) );
  MUX21L U131 ( .A(BaudRateDivisor_o[8]), .B(n117), .S(n120), .Z(n118) );
  NR2 U132 ( .A(n118), .B(n121), .Z(n119) );
  EN U133 ( .A(n119), .B(counter_s[7]), .Z(n125) );
  EO U134 ( .A(n120), .B(BaudRateDivisor_o[7]), .Z(n122) );
  EO U135 ( .A(n123), .B(counter_s[6]), .Z(n124) );
  ND4 U136 ( .A(n126), .B(n125), .C(n5), .D(n124), .Z(n217) );
  ND2 U137 ( .A(n209), .B(n217), .Z(n127) );
  ND2 U138 ( .A(counter_s[1]), .B(counter_s[0]), .Z(n219) );
  ND2 U139 ( .A(n223), .B(n224), .Z(n128) );
  ND2 U140 ( .A(n219), .B(n128), .Z(n129) );
  NR2 U141 ( .A(n4), .B(n129), .Z(N70) );
  ND2 U142 ( .A(counter_s[3]), .B(counter_s[2]), .Z(n130) );
  NR2 U143 ( .A(n219), .B(n130), .Z(n221) );
  ND2 U144 ( .A(n131), .B(counter_s[2]), .Z(n132) );
  ND2 U145 ( .A(n132), .B(n225), .Z(n133) );
  ND2 U146 ( .A(n134), .B(n133), .Z(n135) );
  NR2 U147 ( .A(n4), .B(n135), .Z(N72) );
  ND3 U148 ( .A(counter_s[5]), .B(n221), .C(counter_s[4]), .Z(n201) );
  ND2 U149 ( .A(n221), .B(counter_s[4]), .Z(n136) );
  OR2P U150 ( .A(n140), .B(n137), .Z(n138) );
  NR2 U151 ( .A(n4), .B(n138), .Z(N74) );
  ND2 U152 ( .A(counter_s[7]), .B(counter_s[6]), .Z(n139) );
  NR2 U153 ( .A(n201), .B(n139), .Z(n203) );
  ND2 U154 ( .A(n140), .B(counter_s[6]), .Z(n141) );
  ND2 U155 ( .A(n141), .B(n227), .Z(n142) );
  ND2 U156 ( .A(n143), .B(n142), .Z(n144) );
  NR2 U157 ( .A(n4), .B(n144), .Z(N76) );
  AN3 U158 ( .A(counter_s[9]), .B(n203), .C(counter_s[8]), .Z(n205) );
  ND2 U159 ( .A(n203), .B(counter_s[8]), .Z(n145) );
  OR2P U160 ( .A(n205), .B(n146), .Z(n147) );
  NR2 U161 ( .A(n4), .B(n147), .Z(N78) );
  IVP U162 ( .A(PRESET_n), .Z(n151) );
  ND2 U163 ( .A(cpol_i), .B(n151), .Z(n25) );
  ND2 U164 ( .A(n152), .B(n151), .Z(n24) );
  NR2 U165 ( .A(\DP_OP_44J1_124_8366/n390 ), .B(BaudRateDivisor_o[11]), .Z(
        n153) );
  NR2 U166 ( .A(n10), .B(BaudRateDivisor_o[8]), .Z(n185) );
  ND2 U167 ( .A(n153), .B(n185), .Z(n156) );
  NR2 U168 ( .A(\DP_OP_44J1_124_8366/n419 ), .B(BaudRateDivisor_o[7]), .Z(n155) );
  NR2 U169 ( .A(\DP_OP_44J1_124_8366/n434 ), .B(\DP_OP_44J1_124_8366/n439 ), 
        .Z(n168) );
  ND2 U170 ( .A(n168), .B(n154), .Z(n173) );
  NR2 U171 ( .A(n173), .B(\DP_OP_44J1_124_8366/n428 ), .Z(n177) );
  ND2 U172 ( .A(n155), .B(n177), .Z(n188) );
  NR2 U173 ( .A(n156), .B(n188), .Z(n157) );
  NR2 U174 ( .A(n157), .B(counter_s[11]), .Z(n197) );
  EO U175 ( .A(n188), .B(BaudRateDivisor_o[8]), .Z(n158) );
  EO U176 ( .A(n158), .B(counter_s[7]), .Z(n162) );
  EN U177 ( .A(\DP_OP_44J1_124_8366/n419 ), .B(n9), .Z(n159) );
  MUX21H U178 ( .A(n9), .B(n159), .S(n177), .Z(n160) );
  EO U179 ( .A(n160), .B(counter_s[6]), .Z(n161) );
  ND2 U180 ( .A(n162), .B(n161), .Z(n183) );
  EO U181 ( .A(\DP_OP_44J1_124_8366/n434 ), .B(\DP_OP_44J1_124_8366/n439 ), 
        .Z(n163) );
  EN U182 ( .A(n163), .B(counter_s[2]), .Z(n167) );
  EO U183 ( .A(\DP_OP_44J1_124_8366/n439 ), .B(counter_s[1]), .Z(n165) );
  ND2 U184 ( .A(n165), .B(n164), .Z(n166) );
  NR2 U185 ( .A(n167), .B(n166), .Z(n171) );
  EN U186 ( .A(n168), .B(\DP_OP_44J1_124_8366/n431 ), .Z(n169) );
  EO U187 ( .A(n169), .B(counter_s[3]), .Z(n170) );
  ND2 U188 ( .A(n171), .B(n170), .Z(n176) );
  EN U189 ( .A(n173), .B(n172), .Z(n174) );
  EN U190 ( .A(n174), .B(counter_s[4]), .Z(n175) );
  NR2 U191 ( .A(n176), .B(n175), .Z(n181) );
  EO U192 ( .A(n178), .B(\DP_OP_44J1_124_8366/n419 ), .Z(n179) );
  EO U193 ( .A(n179), .B(counter_s[5]), .Z(n180) );
  ND2 U194 ( .A(n181), .B(n180), .Z(n182) );
  NR2 U195 ( .A(n183), .B(n182), .Z(n194) );
  EO U196 ( .A(n185), .B(n184), .Z(n186) );
  NR2 U197 ( .A(n186), .B(n188), .Z(n187) );
  EO U198 ( .A(n187), .B(counter_s[9]), .Z(n192) );
  EO U199 ( .A(BaudRateDivisor_o[9]), .B(BaudRateDivisor_o[8]), .Z(n189) );
  MUX21H U200 ( .A(n189), .B(n39), .S(n188), .Z(n190) );
  EN U201 ( .A(n190), .B(counter_s[8]), .Z(n191) );
  NR2 U202 ( .A(n192), .B(n191), .Z(n193) );
  ND2 U203 ( .A(n194), .B(n193), .Z(n195) );
  NR2 U204 ( .A(n195), .B(counter_s[10]), .Z(n196) );
  ND2 U205 ( .A(n197), .B(n196), .Z(n200) );
  EO U206 ( .A(cpol_i), .B(cpha_i), .Z(n218) );
  ND2 U207 ( .A(n218), .B(sclk_o), .Z(n216) );
  ND2 U208 ( .A(mosi_send_sclk0_o), .B(n215), .Z(n198) );
  AO7 U209 ( .A(n200), .B(n216), .C(n198), .Z(n26) );
  ND2 U210 ( .A(n215), .B(n229), .Z(n214) );
  ND2 U211 ( .A(n218), .B(mosi_send_sclk_o), .Z(n199) );
  AO7 U212 ( .A(n214), .B(n200), .C(n199), .Z(n27) );
  EO U213 ( .A(n201), .B(counter_s[6]), .Z(n202) );
  NR2 U214 ( .A(n4), .B(n202), .Z(N75) );
  EN U215 ( .A(n203), .B(counter_s[8]), .Z(n204) );
  NR2 U216 ( .A(n4), .B(n204), .Z(N77) );
  ND2 U217 ( .A(counter_s[10]), .B(n205), .Z(n207) );
  AO7 U218 ( .A(counter_s[10]), .B(n205), .C(n207), .Z(n206) );
  NR2 U219 ( .A(n127), .B(n206), .Z(N79) );
  EO U220 ( .A(n207), .B(counter_s[11]), .Z(n208) );
  NR2 U221 ( .A(n127), .B(n208), .Z(N80) );
  ND2 U222 ( .A(n209), .B(n229), .Z(n213) );
  ND2 U223 ( .A(sclk_o), .B(n3), .Z(n212) );
  ND2 U224 ( .A(cpol_i), .B(n210), .Z(n211) );
  AO3 U225 ( .A(n217), .B(n213), .C(n212), .D(n211), .Z(n30) );
  AO4 U226 ( .A(n215), .B(n230), .C(n214), .D(n217), .Z(n29) );
  AO4 U227 ( .A(n218), .B(n231), .C(n217), .D(n216), .Z(n28) );
  NR2 U228 ( .A(counter_s[0]), .B(n4), .Z(N69) );
  EO U229 ( .A(n219), .B(counter_s[2]), .Z(n220) );
  NR2 U230 ( .A(n4), .B(n220), .Z(N71) );
  EN U231 ( .A(n221), .B(counter_s[4]), .Z(n222) );
  NR2 U232 ( .A(n4), .B(n222), .Z(N73) );
endmodule


module spi_slave_select ( PCLK, PRESET_n, mstr_i, spiswai_i, send_data_i, 
        spi_mode_i, BaudRateDivisor_i, recieve_data_o, ss_o, tip_o );
  input [1:0] spi_mode_i;
  input [11:0] BaudRateDivisor_i;
  input PCLK, PRESET_n, mstr_i, spiswai_i, send_data_i;
  output recieve_data_o, ss_o, tip_o;
  wire   rcv_s, N8, N34, N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, N69,
         N70, N71, N72, N73, N74, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136;
  wire   [15:0] count_s;

  FD2 rcv_s_reg ( .D(N8), .CP(PCLK), .CD(PRESET_n), .Q(rcv_s) );
  FD2 recieve_data_o_reg ( .D(rcv_s), .CP(PCLK), .CD(PRESET_n), .Q(
        recieve_data_o) );
  FD4 ss_o_reg ( .D(N34), .CP(PCLK), .SD(PRESET_n), .Q(ss_o) );
  FD4 \count_s_reg[15]  ( .D(N74), .CP(PCLK), .SD(PRESET_n), .Q(count_s[15]), 
        .QN(n135) );
  FD4 \count_s_reg[14]  ( .D(N73), .CP(PCLK), .SD(PRESET_n), .Q(count_s[14]), 
        .QN(n131) );
  FD4 \count_s_reg[13]  ( .D(N72), .CP(PCLK), .SD(PRESET_n), .Q(count_s[13])
         );
  FD4 \count_s_reg[12]  ( .D(N71), .CP(PCLK), .SD(PRESET_n), .Q(count_s[12]), 
        .QN(n136) );
  FD4 \count_s_reg[11]  ( .D(N70), .CP(PCLK), .SD(PRESET_n), .Q(count_s[11]), 
        .QN(n133) );
  FD4 \count_s_reg[10]  ( .D(N69), .CP(PCLK), .SD(PRESET_n), .Q(count_s[10]), 
        .QN(n132) );
  FD4 \count_s_reg[9]  ( .D(N68), .CP(PCLK), .SD(PRESET_n), .Q(count_s[9]) );
  FD4 \count_s_reg[8]  ( .D(N67), .CP(PCLK), .SD(PRESET_n), .Q(count_s[8]), 
        .QN(n130) );
  FD4 \count_s_reg[7]  ( .D(N66), .CP(PCLK), .SD(PRESET_n), .Q(count_s[7]) );
  FD4 \count_s_reg[6]  ( .D(N65), .CP(PCLK), .SD(PRESET_n), .Q(count_s[6]), 
        .QN(n129) );
  FD4 \count_s_reg[5]  ( .D(N64), .CP(PCLK), .SD(PRESET_n), .Q(count_s[5]) );
  FD4 \count_s_reg[4]  ( .D(N63), .CP(PCLK), .SD(PRESET_n), .Q(count_s[4]), 
        .QN(n134) );
  FD4 \count_s_reg[3]  ( .D(N62), .CP(PCLK), .SD(PRESET_n), .Q(count_s[3]) );
  FD4 \count_s_reg[2]  ( .D(N61), .CP(PCLK), .SD(PRESET_n), .Q(count_s[2]) );
  FD4 \count_s_reg[1]  ( .D(N60), .CP(PCLK), .SD(PRESET_n), .Q(count_s[1]) );
  FD4 \count_s_reg[0]  ( .D(N59), .CP(PCLK), .SD(PRESET_n), .Q(count_s[0]) );
  NR2 U3 ( .A(BaudRateDivisor_i[8]), .B(BaudRateDivisor_i[9]), .Z(n8) );
  IVA U4 ( .A(n124), .Z(n72) );
  IVA U5 ( .A(n123), .Z(n69) );
  IVA U6 ( .A(n120), .Z(n66) );
  IVA U7 ( .A(BaudRateDivisor_i[10]), .Z(n2) );
  IVA U8 ( .A(BaudRateDivisor_i[11]), .Z(n6) );
  IVA U9 ( .A(n119), .Z(n63) );
  IVA U10 ( .A(n116), .Z(n60) );
  IVA U11 ( .A(n20), .Z(n21) );
  OR2P U12 ( .A(count_s[0]), .B(n112), .Z(n53) );
  IVA U13 ( .A(n113), .Z(n57) );
  IVA U14 ( .A(n110), .Z(n54) );
  IVA U15 ( .A(n40), .Z(n41) );
  IVA U16 ( .A(send_data_i), .Z(n45) );
  OR2P U17 ( .A(BaudRateDivisor_i[1]), .B(BaudRateDivisor_i[2]), .Z(n20) );
  OR2P U18 ( .A(BaudRateDivisor_i[3]), .B(n20), .Z(n18) );
  OR2P U19 ( .A(BaudRateDivisor_i[4]), .B(n18), .Z(n16) );
  NR2P U20 ( .A(BaudRateDivisor_i[5]), .B(n16), .Z(n15) );
  IVP U21 ( .A(BaudRateDivisor_i[6]), .Z(n1) );
  IVP U22 ( .A(BaudRateDivisor_i[7]), .Z(n14) );
  ND3P U23 ( .A(n15), .B(n1), .C(n14), .Z(n32) );
  IVP U24 ( .A(n32), .Z(n3) );
  ND4 U25 ( .A(n3), .B(n8), .C(n2), .D(n6), .Z(n100) );
  EN U26 ( .A(BaudRateDivisor_i[9]), .B(BaudRateDivisor_i[8]), .Z(n4) );
  MUX21L U27 ( .A(n4), .B(BaudRateDivisor_i[9]), .S(n32), .Z(n80) );
  AO2 U28 ( .A(count_s[15]), .B(n100), .C(count_s[12]), .D(n80), .Z(n12) );
  EO U29 ( .A(BaudRateDivisor_i[10]), .B(BaudRateDivisor_i[11]), .Z(n5) );
  MUX21L U30 ( .A(n6), .B(n5), .S(n8), .Z(n7) );
  MUX21L U31 ( .A(n7), .B(BaudRateDivisor_i[11]), .S(n32), .Z(n79) );
  ND2 U32 ( .A(count_s[14]), .B(n79), .Z(n11) );
  EO U33 ( .A(n8), .B(BaudRateDivisor_i[10]), .Z(n9) );
  MUX21L U34 ( .A(n9), .B(BaudRateDivisor_i[10]), .S(n32), .Z(n99) );
  ND2 U35 ( .A(count_s[13]), .B(n99), .Z(n10) );
  AN3 U36 ( .A(n12), .B(n11), .C(n10), .Z(n49) );
  EO U37 ( .A(BaudRateDivisor_i[6]), .B(BaudRateDivisor_i[7]), .Z(n13) );
  MUX21L U38 ( .A(n14), .B(n13), .S(n15), .Z(n81) );
  EN U39 ( .A(n15), .B(BaudRateDivisor_i[6]), .Z(n88) );
  IVP U40 ( .A(n16), .Z(n17) );
  EO U41 ( .A(n17), .B(BaudRateDivisor_i[5]), .Z(n89) );
  IVP U42 ( .A(n18), .Z(n19) );
  EN U43 ( .A(BaudRateDivisor_i[4]), .B(n19), .Z(n90) );
  EO U44 ( .A(BaudRateDivisor_i[3]), .B(n21), .Z(n82) );
  ND2 U45 ( .A(n82), .B(n129), .Z(n25) );
  EO U46 ( .A(BaudRateDivisor_i[2]), .B(BaudRateDivisor_i[1]), .Z(n83) );
  AO3 U47 ( .A(count_s[5]), .B(n83), .C(BaudRateDivisor_i[1]), .D(count_s[4]), 
        .Z(n23) );
  ND2 U48 ( .A(n83), .B(count_s[5]), .Z(n22) );
  AO3 U49 ( .A(n82), .B(n129), .C(n23), .D(n22), .Z(n24) );
  AO3 U50 ( .A(count_s[7]), .B(n90), .C(n25), .D(n24), .Z(n27) );
  ND2 U51 ( .A(count_s[7]), .B(n90), .Z(n26) );
  AO3 U52 ( .A(n89), .B(n130), .C(n27), .D(n26), .Z(n29) );
  ND2 U53 ( .A(n89), .B(n130), .Z(n28) );
  AO3 U54 ( .A(count_s[9]), .B(n88), .C(n29), .D(n28), .Z(n31) );
  ND2 U55 ( .A(count_s[9]), .B(n88), .Z(n30) );
  AO2 U56 ( .A(n81), .B(n132), .C(n31), .D(n30), .Z(n39) );
  EN U57 ( .A(n32), .B(BaudRateDivisor_i[8]), .Z(n98) );
  IVP U58 ( .A(n81), .Z(n33) );
  ND2 U59 ( .A(count_s[10]), .B(n33), .Z(n34) );
  AO7 U60 ( .A(n98), .B(n133), .C(n34), .Z(n38) );
  ND2 U61 ( .A(n98), .B(n133), .Z(n37) );
  IVP U62 ( .A(n80), .Z(n35) );
  ND2 U63 ( .A(n35), .B(n136), .Z(n36) );
  AO3 U64 ( .A(n39), .B(n38), .C(n37), .D(n36), .Z(n48) );
  NR2 U65 ( .A(count_s[13]), .B(count_s[15]), .Z(n40) );
  IVP U66 ( .A(n99), .Z(n43) );
  AO2 U67 ( .A(n40), .B(n43), .C(n131), .D(n135), .Z(n46) );
  NR2 U68 ( .A(count_s[14]), .B(n41), .Z(n42) );
  ND2 U69 ( .A(n43), .B(n42), .Z(n44) );
  AO3 U70 ( .A(n46), .B(n79), .C(n45), .D(n44), .Z(n47) );
  AO6 U71 ( .A(n49), .B(n48), .C(n47), .Z(n51) );
  NR2 U72 ( .A(spiswai_i), .B(spi_mode_i[1]), .Z(n50) );
  ND2 U73 ( .A(mstr_i), .B(n50), .Z(n52) );
  OR2P U74 ( .A(n51), .B(n52), .Z(N34) );
  IVP U75 ( .A(N34), .Z(n128) );
  NR2 U76 ( .A(send_data_i), .B(n52), .Z(n125) );
  IVP U77 ( .A(n125), .Z(n112) );
  ND2 U78 ( .A(n128), .B(n53), .Z(N59) );
  AN2P U79 ( .A(count_s[0]), .B(count_s[1]), .Z(n108) );
  ND2 U80 ( .A(count_s[2]), .B(n108), .Z(n110) );
  ND2 U81 ( .A(n54), .B(count_s[3]), .Z(n113) );
  EO U82 ( .A(n113), .B(count_s[4]), .Z(n55) );
  OR2P U83 ( .A(n112), .B(n55), .Z(n56) );
  ND2 U84 ( .A(n128), .B(n56), .Z(N63) );
  ND3 U85 ( .A(count_s[4]), .B(count_s[5]), .C(n57), .Z(n116) );
  EN U86 ( .A(n116), .B(n129), .Z(n58) );
  OR2P U87 ( .A(n112), .B(n58), .Z(n59) );
  ND2 U88 ( .A(n128), .B(n59), .Z(N65) );
  ND3 U89 ( .A(count_s[6]), .B(count_s[7]), .C(n60), .Z(n119) );
  EN U90 ( .A(n119), .B(n130), .Z(n61) );
  OR2P U91 ( .A(n112), .B(n61), .Z(n62) );
  ND2 U92 ( .A(n128), .B(n62), .Z(N67) );
  ND3 U93 ( .A(count_s[8]), .B(count_s[9]), .C(n63), .Z(n120) );
  EN U94 ( .A(n120), .B(n132), .Z(n64) );
  OR2P U95 ( .A(n112), .B(n64), .Z(n65) );
  ND2 U96 ( .A(n128), .B(n65), .Z(N69) );
  ND2 U97 ( .A(count_s[10]), .B(n66), .Z(n123) );
  EN U98 ( .A(n123), .B(n133), .Z(n67) );
  OR2P U99 ( .A(n112), .B(n67), .Z(n68) );
  ND2 U100 ( .A(n128), .B(n68), .Z(N70) );
  ND3 U101 ( .A(count_s[11]), .B(count_s[12]), .C(n69), .Z(n124) );
  EO U102 ( .A(n124), .B(count_s[13]), .Z(n70) );
  OR2P U103 ( .A(n112), .B(n70), .Z(n71) );
  ND2 U104 ( .A(n128), .B(n71), .Z(N72) );
  ND2 U105 ( .A(count_s[13]), .B(n72), .Z(n75) );
  EN U106 ( .A(n75), .B(n131), .Z(n73) );
  OR2P U107 ( .A(n112), .B(n73), .Z(n74) );
  ND2 U108 ( .A(n128), .B(n74), .Z(N73) );
  NR2 U109 ( .A(n131), .B(n75), .Z(n76) );
  EN U110 ( .A(n76), .B(count_s[15]), .Z(n77) );
  OR2P U111 ( .A(n112), .B(n77), .Z(n78) );
  ND2 U112 ( .A(n128), .B(n78), .Z(N74) );
  EN U113 ( .A(n79), .B(count_s[14]), .Z(n106) );
  EN U114 ( .A(n80), .B(count_s[12]), .Z(n97) );
  EN U115 ( .A(n81), .B(n132), .Z(n96) );
  EN U116 ( .A(n82), .B(n129), .Z(n87) );
  EN U117 ( .A(n83), .B(count_s[5]), .Z(n86) );
  EN U118 ( .A(BaudRateDivisor_i[1]), .B(count_s[4]), .Z(n85) );
  ND4 U119 ( .A(n125), .B(count_s[2]), .C(n108), .D(count_s[3]), .Z(n84) );
  NR4 U120 ( .A(n87), .B(n86), .C(n85), .D(n84), .Z(n94) );
  EO U121 ( .A(n88), .B(count_s[9]), .Z(n93) );
  EN U122 ( .A(n89), .B(count_s[8]), .Z(n92) );
  EO U123 ( .A(n90), .B(count_s[7]), .Z(n91) );
  ND4 U124 ( .A(n94), .B(n93), .C(n92), .D(n91), .Z(n95) );
  NR3 U125 ( .A(n97), .B(n96), .C(n95), .Z(n104) );
  EN U126 ( .A(n98), .B(count_s[11]), .Z(n103) );
  EO U127 ( .A(n99), .B(count_s[13]), .Z(n102) );
  EN U128 ( .A(n100), .B(n135), .Z(n101) );
  ND4 U129 ( .A(n104), .B(n103), .C(n102), .D(n101), .Z(n105) );
  NR2 U130 ( .A(n106), .B(n105), .Z(N8) );
  EN U131 ( .A(count_s[0]), .B(count_s[1]), .Z(n107) );
  AO7 U132 ( .A(n112), .B(n107), .C(n128), .Z(N60) );
  AO3 U133 ( .A(count_s[2]), .B(n108), .C(n125), .D(n110), .Z(n109) );
  ND2 U134 ( .A(n128), .B(n109), .Z(N61) );
  EO U135 ( .A(n110), .B(count_s[3]), .Z(n111) );
  AO7 U136 ( .A(n112), .B(n111), .C(n128), .Z(N62) );
  NR2 U137 ( .A(n134), .B(n113), .Z(n114) );
  AO3 U138 ( .A(count_s[5]), .B(n114), .C(n125), .D(n116), .Z(n115) );
  ND2 U139 ( .A(n128), .B(n115), .Z(N64) );
  NR2 U140 ( .A(n129), .B(n116), .Z(n117) );
  AO3 U141 ( .A(count_s[7]), .B(n117), .C(n125), .D(n119), .Z(n118) );
  ND2 U142 ( .A(n128), .B(n118), .Z(N66) );
  NR2 U143 ( .A(n130), .B(n119), .Z(n121) );
  AO3 U144 ( .A(count_s[9]), .B(n121), .C(n125), .D(n120), .Z(n122) );
  ND2 U145 ( .A(n128), .B(n122), .Z(N68) );
  NR2 U146 ( .A(n133), .B(n123), .Z(n126) );
  AO3 U147 ( .A(count_s[12]), .B(n126), .C(n125), .D(n124), .Z(n127) );
  ND2 U148 ( .A(n128), .B(n127), .Z(N71) );
endmodule


module spi_shift_reg ( PCLK, PRESET_n, ss_i, send_data_i, lsbfe_i, cpha_i, 
        cpol_i, miso_recieve_sclk_i, miso_recieve_sclk0_i, mosi_send_sclk0_i, 
        data_mosi_i, miso_i, recieve_data_i, mosi_o, data_miso_o, 
        mosi_send_sclk_i_BAR );
  input [7:0] data_mosi_i;
  output [7:0] data_miso_o;
  input PCLK, PRESET_n, ss_i, send_data_i, lsbfe_i, cpha_i, cpol_i,
         miso_recieve_sclk_i, miso_recieve_sclk0_i, mosi_send_sclk0_i, miso_i,
         recieve_data_i, mosi_send_sclk_i_BAR;
  output mosi_o;
  wire   mosi_send_sclk_i, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113;
  wire   [7:0] temp_reg;
  wire   [7:0] shift_register;
  wire   [2:0] counter;
  wire   [2:0] counter1;
  wire   [2:0] counter2;
  wire   [2:0] counter3;
  assign mosi_send_sclk_i = mosi_send_sclk_i_BAR;

  FD2 \shift_register_reg[7]  ( .D(n122), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[7]) );
  FD2 \shift_register_reg[6]  ( .D(n121), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[6]) );
  FD2 \shift_register_reg[5]  ( .D(n120), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[5]) );
  FD2 \shift_register_reg[4]  ( .D(n119), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[4]) );
  FD2 \shift_register_reg[3]  ( .D(n118), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[3]) );
  FD2 \shift_register_reg[2]  ( .D(n117), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[2]) );
  FD2 \shift_register_reg[1]  ( .D(n116), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[1]), .QN(n109) );
  FD2 \shift_register_reg[0]  ( .D(n115), .CP(PCLK), .CD(PRESET_n), .Q(
        shift_register[0]), .QN(n110) );
  FD2 \counter_reg[0]  ( .D(n136), .CP(PCLK), .CD(PRESET_n), .Q(counter[0]), 
        .QN(n107) );
  FD2 \counter_reg[1]  ( .D(n132), .CP(PCLK), .CD(PRESET_n), .Q(counter[1]), 
        .QN(n112) );
  FD2 \counter_reg[2]  ( .D(n131), .CP(PCLK), .CD(PRESET_n), .Q(counter[2]), 
        .QN(n108) );
  FD2 mosi_o_reg ( .D(n141), .CP(PCLK), .CD(PRESET_n), .Q(mosi_o), .QN(n113)
         );
  FD2 \counter2_reg[0]  ( .D(n135), .CP(PCLK), .CD(PRESET_n), .Q(counter2[0])
         );
  FD2 \counter2_reg[1]  ( .D(n134), .CP(PCLK), .CD(PRESET_n), .Q(counter2[1]), 
        .QN(n102) );
  FD2 \counter2_reg[2]  ( .D(n133), .CP(PCLK), .CD(PRESET_n), .Q(counter2[2]), 
        .QN(n111) );
  FD2 \temp_reg_reg[7]  ( .D(n130), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[7])
         );
  FD2 \temp_reg_reg[6]  ( .D(n129), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[6])
         );
  FD2 \temp_reg_reg[5]  ( .D(n128), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[5])
         );
  FD2 \temp_reg_reg[4]  ( .D(n127), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[4])
         );
  FD2 \temp_reg_reg[3]  ( .D(n126), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[3])
         );
  FD2 \temp_reg_reg[2]  ( .D(n125), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[2])
         );
  FD2 \temp_reg_reg[1]  ( .D(n124), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[1])
         );
  FD2 \temp_reg_reg[0]  ( .D(n123), .CP(PCLK), .CD(PRESET_n), .Q(temp_reg[0])
         );
  FD4 \counter1_reg[0]  ( .D(n137), .CP(PCLK), .SD(PRESET_n), .Q(counter1[0]), 
        .QN(n105) );
  FD4 \counter1_reg[1]  ( .D(n138), .CP(PCLK), .SD(PRESET_n), .Q(counter1[1]), 
        .QN(n100) );
  FD4 \counter1_reg[2]  ( .D(n142), .CP(PCLK), .SD(PRESET_n), .Q(counter1[2]), 
        .QN(n101) );
  FD4 \counter3_reg[0]  ( .D(n143), .CP(PCLK), .SD(PRESET_n), .Q(counter3[0]), 
        .QN(n103) );
  FD4 \counter3_reg[1]  ( .D(n139), .CP(PCLK), .SD(PRESET_n), .Q(counter3[1]), 
        .QN(n104) );
  FD4 \counter3_reg[2]  ( .D(n140), .CP(PCLK), .SD(PRESET_n), .Q(counter3[2]), 
        .QN(n106) );
  IVA U3 ( .A(n34), .Z(n37) );
  IVA U4 ( .A(n79), .Z(n33) );
  IVA U5 ( .A(n50), .Z(n42) );
  IVA U6 ( .A(n56), .Z(n57) );
  IVA U7 ( .A(n39), .Z(n3) );
  IVA U8 ( .A(n44), .Z(n1) );
  IVA U9 ( .A(n46), .Z(n6) );
  IVA U10 ( .A(n53), .Z(n58) );
  IVA U11 ( .A(miso_recieve_sclk_i), .Z(n45) );
  IVA U12 ( .A(ss_i), .Z(n38) );
  IVA U13 ( .A(mosi_send_sclk_i), .Z(n5) );
  IVA U14 ( .A(lsbfe_i), .Z(n26) );
  IVA U15 ( .A(send_data_i), .Z(n95) );
  AN2P U16 ( .A(temp_reg[0]), .B(recieve_data_i), .Z(data_miso_o[0]) );
  AN2P U17 ( .A(temp_reg[1]), .B(recieve_data_i), .Z(data_miso_o[1]) );
  AN2P U18 ( .A(temp_reg[2]), .B(recieve_data_i), .Z(data_miso_o[2]) );
  AN2P U19 ( .A(temp_reg[3]), .B(recieve_data_i), .Z(data_miso_o[3]) );
  AN2P U20 ( .A(temp_reg[4]), .B(recieve_data_i), .Z(data_miso_o[4]) );
  AN2P U21 ( .A(temp_reg[5]), .B(recieve_data_i), .Z(data_miso_o[5]) );
  AN2P U22 ( .A(temp_reg[6]), .B(recieve_data_i), .Z(data_miso_o[6]) );
  AN2P U23 ( .A(temp_reg[7]), .B(recieve_data_i), .Z(data_miso_o[7]) );
  EN U24 ( .A(cpol_i), .B(cpha_i), .Z(n46) );
  NR2 U25 ( .A(ss_i), .B(lsbfe_i), .Z(n4) );
  NR2 U26 ( .A(n46), .B(miso_recieve_sclk0_i), .Z(n44) );
  AO3 U27 ( .A(miso_recieve_sclk_i), .B(n6), .C(n4), .D(n1), .Z(n52) );
  NR2 U28 ( .A(counter3[0]), .B(n52), .Z(n79) );
  ND2 U29 ( .A(counter3[0]), .B(n52), .Z(n2) );
  ND2 U30 ( .A(n33), .B(n2), .Z(n143) );
  NR2 U31 ( .A(mosi_send_sclk0_i), .B(n46), .Z(n39) );
  AO3 U32 ( .A(n6), .B(n5), .C(n4), .D(n3), .Z(n35) );
  NR2 U33 ( .A(counter1[0]), .B(n35), .Z(n34) );
  NR2 U34 ( .A(counter1[1]), .B(counter1[2]), .Z(n12) );
  ND2 U35 ( .A(n12), .B(n34), .Z(n7) );
  ND2 U36 ( .A(counter1[1]), .B(counter1[2]), .Z(n14) );
  AO3 U37 ( .A(n34), .B(n101), .C(n7), .D(n14), .Z(n142) );
  ND2 U38 ( .A(n46), .B(mosi_send_sclk_i), .Z(n8) );
  AO3 U39 ( .A(mosi_send_sclk0_i), .B(n46), .C(n8), .D(n38), .Z(n31) );
  ND2 U40 ( .A(counter1[2]), .B(n100), .Z(n11) );
  ND2 U41 ( .A(counter1[1]), .B(n101), .Z(n10) );
  AO4 U42 ( .A(shift_register[5]), .B(n11), .C(shift_register[3]), .D(n10), 
        .Z(n18) );
  ND2 U43 ( .A(n12), .B(n109), .Z(n9) );
  AO3 U44 ( .A(shift_register[7]), .B(n14), .C(counter1[0]), .D(n9), .Z(n17)
         );
  AO4 U45 ( .A(shift_register[4]), .B(n11), .C(shift_register[2]), .D(n10), 
        .Z(n16) );
  ND2 U46 ( .A(n12), .B(n110), .Z(n13) );
  AO3 U47 ( .A(shift_register[6]), .B(n14), .C(n13), .D(n105), .Z(n15) );
  AO4 U48 ( .A(n18), .B(n17), .C(n16), .D(n15), .Z(n19) );
  ND2 U49 ( .A(n26), .B(n19), .Z(n30) );
  AO2 U50 ( .A(counter[0]), .B(shift_register[7]), .C(shift_register[6]), .D(
        n107), .Z(n21) );
  AO2 U51 ( .A(counter[0]), .B(shift_register[3]), .C(shift_register[2]), .D(
        n107), .Z(n20) );
  AO2 U52 ( .A(counter[2]), .B(n21), .C(n20), .D(n108), .Z(n25) );
  AO2 U53 ( .A(counter[0]), .B(shift_register[5]), .C(shift_register[4]), .D(
        n107), .Z(n23) );
  AO2 U54 ( .A(counter[0]), .B(shift_register[1]), .C(shift_register[0]), .D(
        n107), .Z(n22) );
  AO2 U55 ( .A(counter[2]), .B(n23), .C(n22), .D(n108), .Z(n24) );
  AO2 U56 ( .A(counter[1]), .B(n25), .C(n24), .D(n112), .Z(n27) );
  NR2 U57 ( .A(n27), .B(n26), .Z(n28) );
  NR2 U58 ( .A(n31), .B(n28), .Z(n29) );
  AO2 U59 ( .A(n113), .B(n31), .C(n30), .D(n29), .Z(n141) );
  NR2 U60 ( .A(counter3[1]), .B(counter3[2]), .Z(n78) );
  ND2 U61 ( .A(n78), .B(n79), .Z(n32) );
  ND2 U62 ( .A(counter3[1]), .B(counter3[2]), .Z(n53) );
  AO3 U63 ( .A(n79), .B(n106), .C(n32), .D(n53), .Z(n140) );
  AO2 U64 ( .A(counter3[1]), .B(n79), .C(n33), .D(n104), .Z(n139) );
  AO2 U65 ( .A(counter1[1]), .B(n34), .C(n37), .D(n100), .Z(n138) );
  ND2 U66 ( .A(counter1[0]), .B(n35), .Z(n36) );
  ND2 U67 ( .A(n37), .B(n36), .Z(n137) );
  ND2 U68 ( .A(lsbfe_i), .B(n38), .Z(n43) );
  AO1P U69 ( .A(n46), .B(mosi_send_sclk_i), .C(n39), .D(n43), .Z(n40) );
  ND2 U70 ( .A(counter[0]), .B(n40), .Z(n50) );
  NR2 U71 ( .A(counter[0]), .B(n40), .Z(n41) );
  NR2 U72 ( .A(n42), .B(n41), .Z(n136) );
  AO1P U73 ( .A(n46), .B(n45), .C(n44), .D(n43), .Z(n56) );
  ND2 U74 ( .A(counter2[0]), .B(n56), .Z(n48) );
  IVP U75 ( .A(n48), .Z(n75) );
  NR2 U76 ( .A(counter2[0]), .B(n56), .Z(n47) );
  NR2 U77 ( .A(n75), .B(n47), .Z(n135) );
  NR2 U78 ( .A(n102), .B(n48), .Z(n49) );
  AO6 U79 ( .A(n102), .B(n48), .C(n49), .Z(n134) );
  NR2 U80 ( .A(counter2[2]), .B(n102), .Z(n71) );
  EON1 U81 ( .A(n49), .B(n111), .C(n71), .D(n75), .Z(n133) );
  NR2 U82 ( .A(n112), .B(n50), .Z(n51) );
  AO6 U83 ( .A(n112), .B(n50), .C(n51), .Z(n132) );
  EO1 U84 ( .A(counter[2]), .B(n51), .C(n51), .D(counter[2]), .Z(n131) );
  NR2 U85 ( .A(n111), .B(n102), .Z(n59) );
  NR2 U86 ( .A(n103), .B(n52), .Z(n74) );
  AO2 U87 ( .A(n75), .B(n59), .C(n74), .D(n58), .Z(n55) );
  IVP U88 ( .A(miso_i), .Z(n83) );
  ND2 U89 ( .A(temp_reg[7]), .B(n55), .Z(n54) );
  AO7 U90 ( .A(n55), .B(n83), .C(n54), .Z(n130) );
  NR2 U91 ( .A(counter2[0]), .B(n57), .Z(n81) );
  AO2 U92 ( .A(n59), .B(n81), .C(n58), .D(n79), .Z(n61) );
  ND2 U93 ( .A(temp_reg[6]), .B(n61), .Z(n60) );
  AO7 U94 ( .A(n61), .B(n83), .C(n60), .Z(n129) );
  NR2 U95 ( .A(counter2[1]), .B(n111), .Z(n65) );
  NR2 U96 ( .A(counter3[1]), .B(n106), .Z(n64) );
  AO2 U97 ( .A(n75), .B(n65), .C(n74), .D(n64), .Z(n63) );
  ND2 U98 ( .A(temp_reg[5]), .B(n63), .Z(n62) );
  AO7 U99 ( .A(n63), .B(n83), .C(n62), .Z(n128) );
  AO2 U100 ( .A(n81), .B(n65), .C(n79), .D(n64), .Z(n67) );
  ND2 U101 ( .A(temp_reg[4]), .B(n67), .Z(n66) );
  AO7 U102 ( .A(n67), .B(n83), .C(n66), .Z(n127) );
  NR2 U103 ( .A(counter3[2]), .B(n104), .Z(n70) );
  AO2 U104 ( .A(n75), .B(n71), .C(n74), .D(n70), .Z(n69) );
  ND2 U105 ( .A(temp_reg[3]), .B(n69), .Z(n68) );
  AO7 U106 ( .A(n69), .B(n83), .C(n68), .Z(n126) );
  AO2 U107 ( .A(n81), .B(n71), .C(n79), .D(n70), .Z(n73) );
  ND2 U108 ( .A(temp_reg[2]), .B(n73), .Z(n72) );
  AO7 U109 ( .A(n73), .B(n83), .C(n72), .Z(n125) );
  NR2 U110 ( .A(counter2[2]), .B(counter2[1]), .Z(n80) );
  AO2 U111 ( .A(n75), .B(n80), .C(n74), .D(n78), .Z(n77) );
  ND2 U112 ( .A(temp_reg[1]), .B(n77), .Z(n76) );
  AO7 U113 ( .A(n77), .B(n83), .C(n76), .Z(n124) );
  AO2 U114 ( .A(n81), .B(n80), .C(n79), .D(n78), .Z(n84) );
  ND2 U115 ( .A(temp_reg[0]), .B(n84), .Z(n82) );
  AO7 U116 ( .A(n84), .B(n83), .C(n82), .Z(n123) );
  ND2 U117 ( .A(shift_register[7]), .B(n95), .Z(n86) );
  ND2 U118 ( .A(send_data_i), .B(data_mosi_i[7]), .Z(n85) );
  ND2 U119 ( .A(n86), .B(n85), .Z(n122) );
  ND2 U120 ( .A(shift_register[6]), .B(n95), .Z(n88) );
  ND2 U121 ( .A(send_data_i), .B(data_mosi_i[6]), .Z(n87) );
  ND2 U122 ( .A(n88), .B(n87), .Z(n121) );
  ND2 U123 ( .A(shift_register[5]), .B(n95), .Z(n90) );
  ND2 U124 ( .A(send_data_i), .B(data_mosi_i[5]), .Z(n89) );
  ND2 U125 ( .A(n90), .B(n89), .Z(n120) );
  ND2 U126 ( .A(shift_register[4]), .B(n95), .Z(n92) );
  ND2 U127 ( .A(send_data_i), .B(data_mosi_i[4]), .Z(n91) );
  ND2 U128 ( .A(n92), .B(n91), .Z(n119) );
  ND2 U129 ( .A(shift_register[3]), .B(n95), .Z(n94) );
  ND2 U130 ( .A(send_data_i), .B(data_mosi_i[3]), .Z(n93) );
  ND2 U131 ( .A(n94), .B(n93), .Z(n118) );
  ND2 U132 ( .A(shift_register[2]), .B(n95), .Z(n97) );
  ND2 U133 ( .A(send_data_i), .B(data_mosi_i[2]), .Z(n96) );
  ND2 U134 ( .A(n97), .B(n96), .Z(n117) );
  ND2 U135 ( .A(data_mosi_i[1]), .B(send_data_i), .Z(n98) );
  AO7 U136 ( .A(send_data_i), .B(n109), .C(n98), .Z(n116) );
  ND2 U137 ( .A(data_mosi_i[0]), .B(send_data_i), .Z(n99) );
  AO7 U138 ( .A(send_data_i), .B(n110), .C(n99), .Z(n115) );
endmodule


module top_mod ( PCLK, PRESET_n, PWRITE_i, PSEL_i, PENABLE_i, miso_i, PADDR_i, 
        PWDATA_i, ss_o, sclk_o, spi_interrupt_request_o, mosi_o, PREADY_o, 
        PSLVERR_o, PRDATA_o );
  input [2:0] PADDR_i;
  input [7:0] PWDATA_i;
  output [7:0] PRDATA_o;
  input PCLK, PRESET_n, PWRITE_i, PSEL_i, PENABLE_i, miso_i;
  output ss_o, sclk_o, spi_interrupt_request_o, mosi_o, PREADY_o, PSLVERR_o;
  wire   recieve_data, mstr, cpol, cpha, lsbfe, spiswai, send_data,
         \spi_mode[1] , miso_recieve_sclk, miso_recieve_sclk0, mosi_send_sclk,
         mosi_send_sclk0;
  wire   [7:0] data_miso;
  wire   [7:0] data_mosi;
  wire   [2:0] sppr;
  wire   [2:0] spr;
  wire   [11:0] Baudratedivisor;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;

  spi_slave_interface B1 ( .PCLK(PCLK), .PRESET_n(PRESET_n), .PWRITE_i(
        PWRITE_i), .PSEL_i(PSEL_i), .PENABLE_i(PENABLE_i), .ss_i(ss_o), 
        .recieve_data_i(recieve_data), .tip_i(1'b0), .PADDR_i(PADDR_i), 
        .PWDATA_i(PWDATA_i), .miso_data_i(data_miso), .mstr_o(mstr), .cpol_o(
        cpol), .cpha_o(cpha), .lsbfe_o(lsbfe), .spiswai_o(spiswai), 
        .spi_interrupt_request_o(spi_interrupt_request_o), .PREADY_o(PREADY_o), 
        .PSLVERR_o(PSLVERR_o), .send_data_o(send_data), .mosi_data_o(data_mosi), .spi_mode_o({\spi_mode[1] , SYNOPSYS_UNCONNECTED__0}), .sppr_o(sppr), 
        .spr_o(spr), .PRDATA_o(PRDATA_o) );
  spi_baud_generator B2 ( .PCLK(PCLK), .PRESET_n(PRESET_n), .spiswai_i(spiswai), .cpol_i(cpol), .cpha_i(cpha), .ss_i(ss_o), .sppr_i(sppr), .spr_i(spr), 
        .spi_mode_i({\spi_mode[1] , 1'b0}), .sclk_o(sclk_o), 
        .miso_recieve_sclk_o(miso_recieve_sclk), .miso_recieve_sclk0_o(
        miso_recieve_sclk0), .mosi_send_sclk0_o(mosi_send_sclk0), 
        .BaudRateDivisor_o({Baudratedivisor[11:1], SYNOPSYS_UNCONNECTED__1}), 
        .mosi_send_sclk_o_BAR(mosi_send_sclk) );
  spi_slave_select B3 ( .PCLK(PCLK), .PRESET_n(PRESET_n), .mstr_i(mstr), 
        .spiswai_i(spiswai), .send_data_i(send_data), .spi_mode_i({
        \spi_mode[1] , 1'b0}), .BaudRateDivisor_i({Baudratedivisor[11:1], 1'b0}), .recieve_data_o(recieve_data), .ss_o(ss_o) );
  spi_shift_reg B4 ( .PCLK(PCLK), .PRESET_n(PRESET_n), .ss_i(ss_o), 
        .send_data_i(send_data), .lsbfe_i(lsbfe), .cpha_i(cpha), .cpol_i(cpol), 
        .miso_recieve_sclk_i(miso_recieve_sclk), .miso_recieve_sclk0_i(
        miso_recieve_sclk0), .mosi_send_sclk0_i(mosi_send_sclk0), 
        .data_mosi_i(data_mosi), .miso_i(miso_i), .recieve_data_i(recieve_data), .mosi_o(mosi_o), .data_miso_o(data_miso), .mosi_send_sclk_i_BAR(
        mosi_send_sclk) );
endmodule

