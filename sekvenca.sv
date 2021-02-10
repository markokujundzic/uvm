`include "uvm_macros.svh"
import uvm_pkg::*;
import transakcija_sv_unit::*;

class sekvenca extends uvm_sequence;

`uvm_object_utils(sekvenca)

function new(string name = "sekvenca");
 super.new(name);
endfunction

virtual task body();
 for (int i = 0; i < 50; i++) begin
  transakcija t = transakcija::type_id::create("t");
  start_item(t);
  t.randomize();
  `uvm_info("SEK", $sformatf("Generisana nova transakcija:\n%s", t.sprint()), UVM_NONE)
  finish_item(t);
 end
 `uvm_info("SEK", $sformatf("Zavrseno generisanje transakcija"), UVM_NONE)
endtask

endclass

