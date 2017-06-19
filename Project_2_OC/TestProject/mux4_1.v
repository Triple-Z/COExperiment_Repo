`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:16 06/09/2017 
// Design Name: 
// Module Name:    mux4_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux4_1(
    input sw6_a1,
    input sw5_a0,
    input sw4_d4,
    input sw3_d3,
    input sw2_d2,
    input sw1_d1,
    output led8_out
    );

    assign led8_out = sw1_d1 & (!sw6_a1) & (!sw5_a0) | sw2_d2 & (!sw6_a1) & (sw5_a0) | sw3_d3 & (sw6_a1) & (!sw5_a0) | sw4_d4 & (sw6_a1) & (sw5_a0);


endmodule
