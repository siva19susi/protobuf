docker run --rm \
  -v $(pwd)/doc:/out \
  -v $(pwd)/gnmi:/protos \
  --entrypoint '' \
  pseudomuto/protoc-gen-doc \
  bash -c "protoc -I /protos --doc_out=/out /protos/*.proto --doc_opt=json,gnmi.json"
