`include "uvm_macros.svh"
import uvm_pkg::*;
import test_sv_unit::*;

module testbench;

reg clk;

interfejs i(clk);

dut d(clk, i.rst_n, i.in, i.out);

initial begin
 clk <= 0;
 uvm_config_db#(virtual interfejs)::set(null, "*", "i", i);
 run_test("test");
end

always
 #10 clk = ~clk;

endmodule
