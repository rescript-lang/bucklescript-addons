// GENERATED CODE BY BUCKLESCRIPT VERSION 0.9.4 , PLEASE EDIT WITH CARE
'use strict';


function fib(n) {
  var _n = n;
  var _a = 1;
  var _b = 1;
  while(true) {
    var b = _b;
    var a = _a;
    var n$1 = _n;
    if (n$1) {
      _b = a + b | 0;
      _a = b;
      _n = n$1 - 1 | 0;
      continue ;
      
    }
    else {
      return a;
    }
  };
}

exports.fib = fib;
/* No side effect */
