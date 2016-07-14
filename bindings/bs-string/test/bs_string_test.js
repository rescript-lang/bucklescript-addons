// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.2 , PLEASE EDIT WITH CARE
'use strict';

var Pervasives = require("bs-platform/lib/js/pervasives");
var Bs_mocha   = require("bs-mocha/lib/js/bs_mocha");
var Block      = require("bs-platform/lib/js/block");

var suites = [/* [] */0];

var test_id = [0];

function eq(loc, param) {
  var y = param[1];
  var x = param[0];
  test_id[0] = test_id[0] + 1 | 0;
  suites[0] = /* :: */[
    /* tuple */[
      loc + (" id " + Pervasives.string_of_int(test_id[0])),
      function () {
        return /* Eq */Block.__(0, [
                  x,
                  y
                ]);
      }
    ],
    suites[0]
  ];
  return /* () */0;
}

eq('File "test/bs_string_test.ml", line 14, characters 7-14', /* tuple */[
      "hihi".slice(2),
      "hi"
    ]);

eq('File "test/bs_string_test.ml", line 15, characters 7-14', /* tuple */[
      "  The quick brown fox jumps over the lazy dog. ".split((/\s+/)),
      /* array */[
        "",
        "The",
        "quick",
        "brown",
        "fox",
        "jumps",
        "over",
        "the",
        "lazy",
        "dog.",
        ""
      ]
    ]);

Bs_mocha.from_pair_suites("test/bs_string_test.ml", suites[0]);

exports.suites  = suites;
exports.test_id = test_id;
exports.eq      = eq;
/*  Not a pure module */
