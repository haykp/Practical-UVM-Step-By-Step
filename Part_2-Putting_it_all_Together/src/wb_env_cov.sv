//
// Template for UVM-compliant Coverage Class
//

`ifndef WB_ENV_COV__SV
`define WB_ENV_COV__SV

class wb_env_cov extends uvm_component;
   `uvm_component_utils(wb_env_cov)
   
   event cov_event;
   wb_transaction tr;
   uvm_analysis_imp #(wb_transaction, wb_env_cov) cov_export;

 
   covergroup cg_trans ;
      coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(wb_transaction tr);
      this.tr = tr;
		cg_trans.sample();
   endfunction: write

endclass: wb_env_cov

`endif // WB_ENV_COV__SV

