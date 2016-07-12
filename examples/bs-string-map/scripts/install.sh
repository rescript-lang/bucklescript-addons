
#!/bin/sh

set -e

./node_modules/.bin/bsc -bs-package-name bs-string-map -bs-package-output lib/js -bs-package-output amdjs:lib/amdjs -bs-no-any-assert -bs-package-output goog:lib/goog  -I src -c -bs-files src/*.mli src/*.ml

# install
cp ./src/*.cm* ./lib/ocaml
