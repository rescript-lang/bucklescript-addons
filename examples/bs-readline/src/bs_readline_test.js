// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.3 , PLEASE EDIT WITH CARE
'use strict';

var Readline = require("readline");

var rl = Readline.createInterface({
      input: global.process.stdin,
      output: global.process.stdout,
      terminal: false
    });

var a_char_code = /* "A" */65;

var zero_char_code = /* "0" */48;

function process(str) {
  var digits = str.split("").map(function (x) {
        var v = x.charCodeAt(0);
        if (v >= a_char_code) {
          return ((v - a_char_code | 0) + 10 | 0) + 1 | 0;
        }
        else {
          return (v - zero_char_code | 0) + 1 | 0;
        }
      });
  return digits.reduce(function (acc, a) {
              return Math.max(acc, a);
            }, 1);
}

var lines = /* array */[];

rl.on("line", function (line) {
      lines.push(line);
      return /* () */0;
    });

rl.on("close", function () {
      var lines$1 = lines;
      if (lines$1.length !== 2) {
        return /* impossible branch */0;
      }
      else {
        var firstline = lines$1[0];
        var secondline = lines$1[1];
        var match_000 = process(firstline);
        var match_001 = process(secondline);
        var first = parseInt(firstline, match_000);
        var second = parseInt(secondline, match_001);
        global.process.stdout.write("" + (first + second));
        return /* () */0;
      }
    });

/* rl Not a pure module */
