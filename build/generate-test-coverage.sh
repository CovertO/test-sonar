#!/bin/bash

set -e

# Run unit tests
echo " * Generating test coverage ..."
echo

mkdir -p reports

go test -json -covermode=atomic -coverprofile=./reports/coverage.out | tee ./reports/gotest.out

echo
echo " * Done."
