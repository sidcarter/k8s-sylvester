#!/usr/bin/env bash

set -e
set -o pipefail

while IFS= read -r -d '' file
do
    echo "${file}"
    shellcheck "${file}"
done <   <(find . -type f -name '*.sh' -print0)
