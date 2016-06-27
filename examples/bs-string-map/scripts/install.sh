
#!/bin/sh

set -e

bsc -bs-npm-output-path $npm_package_name:lib/js -I src -c src/string_map.mli src/string_map.ml 

# install
cp ./src/*.cm* ./lib/ocaml
