`include "defs.vh"

`timescale 1 ns / 1 ps
module registers_tb;
    reg [`NUM_REGS_WIDTH-1:0] rs = 0, rt = 0, rd = 0; 
    reg [`WORD_WIDTH-1:0] reg_in = 0;
    reg reg_write_en = 0;
    reg CLK = 0;
    reg RST = 0;
    wire [`WORD_WIDTH-1:0] rs_val, rt_val, rd_val;

    registers registers_c(rs, rt, rd, reg_in, reg_write_en, CLK, RST, rs_val, rt_val, rd_val);

    initial begin

        static integer i = 0; #10;
        RST = 1; #10;
        RST = 0; #10;
        CLK = 1; #20;
        CLK = 0; #20;
        RST = 1; #10;
       
        CLK = 1; #20;
        CLK = 0; #20;

        `ASSERT_EQ(rs_val, 0);
        `ASSERT_EQ(rt_val, 0);

        rd = 1; #10;
        reg_in = 1; #10;
        reg_write_en = 1; #10;
       
        CLK = 1; #20;
        CLK = 0; #20;

        `ASSERT_EQ(rd_val, 1);

    end
endmodule
