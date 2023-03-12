#!/bin/bash

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

mkdir -p ../../gnmi
mv doc/index.html ../../gnmi/index.html
sed -i '' "s|__KIND__|gNMI|g" ../../gnmi/index.html
sed -i '' "s|__NAME__ ||g" ../../gnmi/index.html
sed -i '' "s|__NDK_VER__|$1|g" ../../gnmi/index.html


# generate gNOI & gNSI proto docs
modelName=("gnoi" "gnsi")

for model in ${modelName[@]}; do

  for entry in $model/*.proto; do

    protoFile=$(basename $entry)
    protoName=${protoFile%.*}

    docker run --rm \
      -v $(pwd)/doc:/out \
      -v $(pwd)/$model:/protos \
      --entrypoint '' \
      pseudomuto/protoc-gen-doc \
      bash -c "protoc -I /protos --doc_out=/out /protos/$protoFile --doc_opt=/out/doc.tmpl,index.html"

    mkdir -p ../../$model/$protoName
    mv doc/index.html ../../$model/$protoName/index.html

    if [[ "$model" == "gnoi" ]]; then
      titleName="gNOI"
    elif [[ "$model" == "gnsi" ]]; then
      titleName="gNSI"
    fi

    sed -i '' "s|__KIND__|$titleName|g" ../../$model/$protoName/index.html
    sed -i '' "s|__NAME__|$protoName|g" ../../$model/$protoName/index.html
    sed -i '' "s|__NDK_VER__|$2|g" ../../$model/$protoName/index.html
    sed -i '' "s|../assets|../../assets|g" ../../$model/$protoName/index.html
    sed -i '' "s|\"../\"|\"../../\"|g" ../../$model/$protoName/index.html

  done

done
