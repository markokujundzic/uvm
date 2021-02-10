`include "uvm_macros.svh"
import uvm_pkg::*;
import transakcija_sv_unit::*;

class skorbord extends uvm_scoreboard;

`uvm_component_utils(skorbord)

function new(string name = "skorbord", uvm_component parent=null);
 super.new(name, parent);
endfunction

bit[3:0] ocekivano = 4'b1011;
bit[3:0] dobijeno;
bit out;

uvm_analysis_imp #(transakcija,skorbord) imp;

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 imp = new ("imp", this);
endfunction

virtual function write(transakcija t);
 dobijeno = dobijeno << 1 | t.in;
 `uvm_info("SKB", $sformatf("in=%0d out=%0d exp=%4b got=%4b", t.in, t.out, ocekivano, dobijeno), UVM_NONE)
 if (t.out != out)
  `uvm_error("SKB", $sformatf("ERROR! out=%0d exp=%0d", t.out, out))
 else
  `uvm_info("SKB", $sformatf("PASS! out=%0d exp=%0d", t.out, out), UVM_NONE)
 if (!(ocekivano ^ dobijeno))
  out = 1;
 else
  out = 0;
endfunction

endclass
