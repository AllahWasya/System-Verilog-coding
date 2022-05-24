package my_pkg;
typedef enum {TRUE,FALSE} bool_t;
typedef enum logic [1:0]{WASAYA, Ali ,BILAL,SHAHID} names_t;

endpackage:my_pkg

module mod1;
import my_pkg::*;

bool_t  a1 = TRUE;
names_t b1 = BILAL;

initial begin
  
  bool_t bool_t1;
  $display("Logic value =%0d",a1, b1);

end

endmodule: mod1