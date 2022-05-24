//////////////////////////////////////////////////////////////////
package my_pkg;
typedef enum {TRUE,FALSE} bool_t;
typedef enum logic [1:0]{WASAYA, Ali ,BILAL,SHAHID} names_t;
typedef enum bit { Write,Read} mem_oper;
endpackage:my_pkg
////////////////////////////////////////////////////////////////////
typedef enum bit {Read, Write} reg_oper;
typedef enum {sun=3, moon} earth;
import my_pkg::*;
/////////////////////////////////////////////////////////////////////
module mod1;
bool_t  a1 = FALSE;  // a1 is variable of type bool_t which inclues FASLE 
names_t b1 = BILAL; // b1 is variable of type names_t which include all names
/////////////////////////////////////////////////////////////////////
initial begin
  mem_oper  obj1=my_pkg::Read; // syntax to read data from pakage 
  reg_oper  obj2=Read;  
  earth     obj3=moon;
  $display("Logic value =%0d",a1,a1.name()); 
  // a1=0 (indicating the location of TRUE ), name  
  $display("Logic value =%0d",b1,b1.name());  
  // b1=2 (indicating the index of BILAL), name
  $display("Logic value =%0d",b1.last(),b1.first(),b1.prev());
  // b1=BILAL at loc 2, so first is zero, last is 3 and previous is 1
  $display("Reading=%0d",obj1,obj2,obj3);
end
endmodule :mod1





 
 
