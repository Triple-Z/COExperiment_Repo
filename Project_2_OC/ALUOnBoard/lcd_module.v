//*************************************************************************
//   > 文件名: lcd_module.v
//   > 描述  ：lcd触摸屏模块，为黑盒文件
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
//synthesis attribute box_type <lcd_module> "black_box" 
module lcd_module(
    input  clk,      //连接10Mhz的时钟
    input  resetn,   //低使能

    //调用触摸屏的接口
    input display_valid,
    input [39:0] display_name,
    input [31:0] display_value,
    output [5:0] display_number,
    output        input_valid,
    output [31:0] input_value,

    //lcd触摸屏相关接口，不需要更改
    output reg   lcd_rst,
    output       lcd_cs,
    output       lcd_rs,
    output       lcd_wr,
    output       lcd_rd,
    inout [15:0] lcd_data_io,
    output       lcd_bl_ctr,
    inout        ct_int,
    inout        ct_sda,
    output       ct_scl,
    output       ct_rstn
    ); 
endmodule
