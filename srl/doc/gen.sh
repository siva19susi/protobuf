#!/bin/bash

set -e

if [ $# != 1 ]; then
  echo "No NDK version provided. Usage: bash doc/gen.sh <SRL-version>"
  exit 1
fi

# generate SRL proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/ndk:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the NDK version accordingly
sed -i '' "s|__KIND__|SR Linux|g" doc/index.html
sed -i '' "s|__NDK_VER__|$1|g" doc/index.html
