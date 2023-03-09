#!/bin/bash

set -e

if [ $# != 3 ]; then
  echo "No NDK version provided. Usage: bash doc/gen.sh <gNMI-version> <gNOI-version> <gNSI-version>"
  exit 1
fi

# generate gNMI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnmi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the version accordingly
mkdir -p ../../gnmi
mv doc/index.html ../../gnmi/index.html
sed -i '' "s|__KIND__|gNMI|g" ../../gnmi/index.html
sed -i '' "s|__NDK_VER__|$1|g" ../../gnmi/index.html

# generate gNOI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnoi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the version accordingly
mkdir -p ../../gnoi
mv doc/index.html ../../gnoi/index.html
sed -i '' "s|__KIND__|gNOI|g" ../../gnoi/index.html
sed -i '' "s|__NDK_VER__|$2|g" ../../gnoi/index.html

# generate gNSI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnsi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the version accordingly
mkdir -p ../../gnsi
mv doc/index.html ../../gnsi/index.html
sed -i '' "s|__KIND__|gNSI|g" ../../gnsi/index.html
sed -i '' "s|__NDK_VER__|$3|g" ../../gnsi/index.html