// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.8 , PLEASE EDIT WITH CARE
'use strict';


function assert_bool(b, loc) {
  if (b) {
    return /* () */0;
  }
  else {
    console.log("Assertion Failure. " + loc);
    return /* () */0;
  }
}

function fail(loc) {
  return assert_bool(/* false */0, loc);
}

function thenValueTest() {
  var p = Promise.resolve(4);
  return p.then(function (x) {
              return assert_bool(+(x === 4), 'File "test/bs_promise_test.ml", line 37, characters 43-50');
            });
}

function thenTest() {
  var p = Promise.resolve(6);
  return p.then(function () {
              return Promise.resolve(12).then(function (y) {
                          return assert_bool(+(y === 12), 'File "test/bs_promise_test.ml", line 42, characters 42-49');
                        });
            });
}

function catchTest() {
  var p = Promise.reject("error");
  return p.then(function () {
                return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 46, characters 35-42');
              }).catch(function (error) {
              return assert_bool(+(error === "error"), 'File "test/bs_promise_test.ml", line 47, characters 55-62');
            });
}

function resolveTest() {
  var p1 = Promise.resolve(10);
  return p1.then(function (x) {
              return assert_bool(+(x === 10), 'File "test/bs_promise_test.ml", line 51, characters 45-52');
            });
}

function rejectTest() {
  var p = Promise.reject("error");
  return p.catch(function (error) {
              return assert_bool(+(error === "error"), 'File "test/bs_promise_test.ml", line 55, characters 57-64');
            });
}

function thenWithErrorResolvedTest() {
  var p = Promise.resolve(20);
  return p.then(function (value) {
              return assert_bool(+(value === 20), 'File "test/bs_promise_test.ml", line 59, characters 63-70');
            }, function () {
              return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 59, characters 98-105');
            });
}

function thenWithErrorRejectedTest() {
  var p = Promise.reject("error");
  return p.then(function () {
              return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 63, characters 43-50');
            }, function (error) {
              return assert_bool(+(error === "error"), 'File "test/bs_promise_test.ml", line 63, characters 102-109');
            });
}

function allFulfillTest() {
  var p1 = Promise.resolve(1);
  var p2 = Promise.resolve(2);
  var p3 = Promise.resolve(3);
  var promises = /* array */[
    p1,
    p2,
    p3
  ];
  return Promise.all(promises).then(function (fulfilled) {
              assert_bool(+(fulfilled[0] === 1), 'File "test/bs_promise_test.ml", line 72, characters 34-41');
              assert_bool(+(fulfilled[1] === 2), 'File "test/bs_promise_test.ml", line 73, characters 34-41');
              return assert_bool(+(fulfilled[2] === 3), 'File "test/bs_promise_test.ml", line 74, characters 34-41');
            });
}

function allRejectTest() {
  var p1 = Promise.resolve(1);
  var p2 = Promise.resolve(3);
  var p3 = Promise.reject("error");
  var promises = /* array */[
    p1,
    p2,
    p3
  ];
  return Promise.all(promises).then(function () {
                return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 82, characters 35-42');
              }).catch(function (error) {
              return assert_bool(+(error === "error"), 'File "test/bs_promise_test.ml", line 83, characters 56-63');
            });
}

function raceTest() {
  var p1 = Promise.resolve("first");
  var p2 = Promise.resolve("second");
  var p3 = Promise.resolve("third");
  var promises = /* array */[
    p1,
    p2,
    p3
  ];
  return Promise.race(promises).then(function (fulfilled) {
                return assert_bool(+(fulfilled === "first"), 'File "test/bs_promise_test.ml", line 91, characters 64-71');
              }).catch(function () {
              return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 92, characters 30-37');
            });
}

function createPromiseRejectTest() {
  return new Promise(function (_, reject) {
                return reject("error");
              }).catch(function (error) {
              return assert_bool(+(error === "error"), 'File "test/bs_promise_test.ml", line 96, characters 56-63');
            });
}

function createPromiseFulfillTest() {
  return new Promise(function (fulfill, _) {
                  return fulfill("success");
                }).then(function (fulfilled) {
                return assert_bool(+(fulfilled === "success"), 'File "test/bs_promise_test.ml", line 100, characters 66-73');
              }).catch(function () {
              return assert_bool(/* false */0, 'File "test/bs_promise_test.ml", line 101, characters 31-38');
            });
}

thenValueTest(/* () */0);

thenTest(/* () */0);

catchTest(/* () */0);

resolveTest(/* () */0);

rejectTest(/* () */0);

thenWithErrorResolvedTest(/* () */0);

thenWithErrorRejectedTest(/* () */0);

allFulfillTest(/* () */0);

allRejectTest(/* () */0);

raceTest(/* () */0);

createPromiseRejectTest(/* () */0);

createPromiseFulfillTest(/* () */0);

exports.assert_bool               = assert_bool;
exports.fail                      = fail;
exports.thenValueTest             = thenValueTest;
exports.thenTest                  = thenTest;
exports.catchTest                 = catchTest;
exports.resolveTest               = resolveTest;
exports.rejectTest                = rejectTest;
exports.thenWithErrorResolvedTest = thenWithErrorResolvedTest;
exports.thenWithErrorRejectedTest = thenWithErrorRejectedTest;
exports.allFulfillTest            = allFulfillTest;
exports.allRejectTest             = allRejectTest;
exports.raceTest                  = raceTest;
exports.createPromiseRejectTest   = createPromiseRejectTest;
exports.createPromiseFulfillTest  = createPromiseFulfillTest;
/* prim Not a pure module */
