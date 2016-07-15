// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.2 , PLEASE EDIT WITH CARE
'use strict';

var Process     = require("process");
var Bs_readline = require("./bs_readline");
var Bs_string   = require("bs-string/lib/js/bs_string");
var Readline    = require("readline");

var rl = Readline.createInterface({
      input: Process.stdin,
      output: Process.stdout,
      terminal: false
    });

function process(str) {
  var digits = Bs_string.ascii_explode(str).map(function (x) {
        return x.charCodeAt(0) - "0".charCodeAt(0) | 0;
      });
  return digits.reduce(function (acc, a) {
              return Math.max(acc, a);
            }, 1);
}

Bs_readline.on_line(rl, function (line) {
      console.log(process(line));
      return /* () */0;
    });

/* rl Not a pure module */
