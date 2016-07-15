// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.2 , PLEASE EDIT WITH CARE
'use strict';

var Bs_readline = require("./bs_readline");
var Readline    = require("readline");
var Process     = require("process");

var first_line = [/* true */1];

var rl = Readline.createInterface({
      input: Process.stdin,
      output: Process.stdout,
      terminal: false
    });

Bs_readline.on_line(rl, function (line) {
      if (first_line[0]) {
        first_line[0] = /* false */0;
        return /* () */0;
      }
      else {
        console.log(line);
        console.log(42);
        return /* () */0;
      }
    });

Bs_readline.on_close(rl, function () {
      Process.exit(0);
      return /* () */0;
    });

/* rl Not a pure module */
