
// TODO bsc compiler should default 
// to such variables when it is set

var fs = require('fs')
var child_process = require('child_process')
var process = global.process
var path = require('path')
var src_dir = "src"


if (!String.prototype.endsWith) {
  String.prototype.endsWith = function(searchString, position) {
      var subjectString = this.toString();
      if (typeof position !== 'number' || !isFinite(position) || Math.floor(position) !== position || position > subjectString.length) {
        position = subjectString.length;
      }
      position -= searchString.length;
      var lastIndex = subjectString.indexOf(searchString, position);
      return lastIndex !== -1 && lastIndex === position;
  };
}
// TODO: to work with 0.12
// polyfil endswith
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