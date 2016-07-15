
// TODO bsc compiler should default 
// to such variables when it is set

var fs = require('fs')
var child_process = require('child_process')
var process = require('process')
var path = require('path')
var src_dir = "src"
var files = 
fs
.readdirSync('./src')
.filter(function(x){return x.endsWith('.ml') || x.endsWith('.mli')})
.map (function(x){return path.join(src_dir,x)})

console.log("files", files );

var npm_package_name = process.env['npm_package_name']

var command = 
  "bsc -bs-package-name " + npm_package_name + 
  "  -bs-package-output lib/js -bs-package-output amdjs:lib/amdjs -bs-package-output goog:lib/goog " +
  "-I " + src_dir + 
  " -c -bs-files " +
  files.join(" ")
console.log("command", command);
child_process.execSync(command);


child_process.execSync("cp ./src/*.cm* ./lib/ocaml")