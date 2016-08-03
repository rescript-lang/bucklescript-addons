const exec = require('child_process').execSync;

//build OCaml files
var build = 'bsc -bs-package-name bs-promise -I src -c -bs-files src/*.mli';
var compile_output = exec(build, { encoding: 'ascii' } );
if (compile_output) {
  console.log(compile_output);
}

//make lib/ocaml folder
var mkdir = 'mkdir -p lib/ocaml';
var mkdir_output = exec(mkdir, { encoding: 'ascii' } );
if (mkdir_output) {
	console.log(mkdir_output);
}

//copy binary files to lib/ocaml
var cp = 'cp ./src/*.cm* ./lib/ocaml/';
var cp_output = exec(cp, { encoding: 'ascii' } );
if (cp_output) {
  console.log(cp_output);
}