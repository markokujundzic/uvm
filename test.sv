`include "uvm_macros.svh"
import uvm_pkg::*;
import sekvenca_sv_unit::sekvenca;
import okruzenje_sv_unit::*;

class test extends uvm_test;

`uvm_component_utils(test)

function new(string name = "test", uvm_component parent=null);
 super.new(name, parent);
endfunction

virtual interfejs i;
okruzenje o;
sekvenca s;

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if (!uvm_config_db#(virtual interfejs)::get(this, "", "i", i))
  `uvm_fatal("TEST", "Neuspesno dohvatanje interfejsa") 
 o = okruzenje::type_id::create("o", this);
 s = sekvenca::type_id::create("s");
endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);
 uvm_top.print_topology();
endfunction

virtual task run_phase(uvm_phase phase);
 super.run_phase(phase);
 phase.raise_objection(this);
 apply_reset();
 s.start(o.a.s);
 phase.drop_objection(this);
endtask

virtual task apply_reset();
 i.rst_n <= 0;
 i.in <= 0;
 #50;
 i.rst_n <= 1;
endtask

endclass
