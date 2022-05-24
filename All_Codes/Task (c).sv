// Task implementation with IO declared in body

// Task which performs the increment

module inc_dec;

task static_increment(input int incr);

  int i = 1;

  i += incr;

  $display("Result of static increment = %0d", i);

endtask : static_increment

// automatic task which increments a local variable

task automatic auto_increment(input int incr);

  int i = 1;

  i += incr;

  $display("Result of automatic increment = %0d", i);

endtask : auto_increment

initial begin

  // First call the static task three times

  static_increment(1);

  static_increment(2);

  static_increment(3);

  // Then call the automatic task three times

  auto_increment(1);

  auto_increment(2);

  auto_increment(3);

end

endmodule