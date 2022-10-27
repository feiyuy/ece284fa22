// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac
#(
    parameter       DATA_WIDTH                          =   4,
    parameter       SUM_WIDTH                           =   16
)
(
    input   wire            [DATA_WIDTH-1:0]                data_in,
    input   wire    signed  [DATA_WIDTH-1:0]                weight_in,
    input   wire    signed  [SUM_WIDTH-1:0]                 acc_in,

    output  wire    signed  [SUM_WIDTH-1:0]                 acc_out

);

    assign  acc_out =   acc_in + data_in * weight_in;

endmodule
