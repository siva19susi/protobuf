#!/bin/bash

set -e

if [ $# != 4 ]; then
  echo "No NDK version provided. Usage: bash doc/gen.sh <SRL-version> <gNMI-version> <gNOI-version> <gNSI-version>"
  exit 1
fi

# generate SRL proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/srl:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the NDK version accordingly
mkdir -p doc/srl
mv doc/index.html doc/srl/index.html
sed -i '' "s|__KIND__|SR Linux|g" doc/srl/index.html
sed -i '' "s|__NDK_VER__|$1|g" doc/srl/index.html

# generate gNMI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnmi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the NDK version accordingly
mkdir -p doc/gnmi
mv doc/index.html doc/gnmi/index.html
sed -i '' "s|__KIND__|gNMI|g" doc/gnmi/index.html
sed -i '' "s|__NDK_VER__|$2|g" doc/gnmi/index.html

# generate gNOI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnoi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the NDK version accordingly
mkdir -p doc/gnoi
mv doc/index.html doc/gnoi/index.html
sed -i '' "s|__KIND__|gNOI|g" doc/gnoi/index.html
sed -i '' "s|__NDK_VER__|$3|g" doc/gnoi/index.html

# generate gNSI proto docs
docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnsi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=/out/doc.tmpl,index.html"

# change the NDK version accordingly
mkdir -p doc/gnsi
mv doc/index.html doc/gnsi/index.html
sed -i '' "s|__KIND__|gNSI|g" doc/gnsi/index.html
sed -i '' "s|__NDK_VER__|$4|g" doc/gnsi/index.html
