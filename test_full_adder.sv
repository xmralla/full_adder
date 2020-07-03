`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2020 07:08:34 PM
// Design Name: 
// Module Name: test_mul16_dsp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_full_adder();
    
localparam W = 64;

reg valid = 0;

reg clk    = 0;
reg valid  = 0;
wire ready;

reg resetn = 0;

integer start_time;
integer stop_time;


reg  [W-1:0] a0 = 0;
reg  [W-1:0] b0 = 0;
wire [W-1:0] d0;

reg  [W-1:0] c0 = 0;

wire CA;

localparam CYCLE =0.5;

full_adder #(.W(W)) m(
    .clk   (clk),
    .resetn(resetn),
    .a     (a0),
    .b     (b0),
    .c     (0),
    .S     (d0),
    .C     (CA)
);

initial begin
    resetn = 0;
    #(4*CYCLE)
    resetn = 1;
    #(4*CYCLE) 
    a0 = 64'h1ffa3e3;
    b0 = 64'h1ff5c27;
    c0 = a0 + b0;
    while (c0 !== d0)
        #CYCLE
        
    #(5*CYCLE) 
    $finish;
end

always begin
    #CYCLE
    clk <= !clk;
end

endmodule