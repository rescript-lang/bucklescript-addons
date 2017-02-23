const exec = require('child_process').execSync;

//build test files
var build = './node_modules/bs-platform/bin/bsc.exe -bs-package-name bs-promise -bs-package-output test/ -I src -I test -c -bs-files src/*.mli test/*.ml;';
var compile_output = exec(build, { encoding: 'ascii' } );
if (compile_output) {
  console.log(compile_output);
}

//run tests
var run_tests = 'node test/bs_promise_test.js';
console.log("Running tests...");
var test_output = exec(run_tests, { encoding: 'ascii' } );
if (test_output) {
  console.log(test_output);
}
console.log("Done.");
