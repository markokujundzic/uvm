`include "uvm_macros.svh"
import uvm_pkg::*;

class transakcija extends uvm_sequence_item;

rand bit in;
bit out;

`uvm_object_utils_begin(transakcija)
`uvm_field_int(in, UVM_ALL_ON)
`uvm_field_int(out, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name = "transakcija");
 super.new(name);
endfunction

virtual function string convert2str();
 return $sformatf("in=%0d, out=%0d", in, out);
endfunction

constraint c { in dist {0:/20, 1:/80}; }

endclass