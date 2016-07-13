// GENERATED CODE BY BUCKLESCRIPT VERSION 0.7.1 , PLEASE EDIT WITH CARE
'use strict';

var Bs_mocha   = require("bs-mocha/lib/js/bs_mocha");
var Block      = require("bs-platform/lib/js/block");
var String_map = require("../string_map");

var v = String_map.add("1", 1, String_map.add("3", 3, String_map.empty));

Bs_mocha.from_pair_suites("test/test_map.ml", /* :: */[
      /* tuple */[
        'File "test/test_map.ml", line 10, characters 4-11',
        function () {
          return /* Eq */Block.__(0, [
                    String_map.find("3", v),
                    3
                  ]);
        }
      ],
      /* [] */0
    ]);

/* v Not a pure module */
