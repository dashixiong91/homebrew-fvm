#!/usr/bin/env bash

set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FORMULA_FILE="${THIS_DIR}/fvm.rb"


download_url="https://github.com/xinfeng-tech/fvm/archive/v1.0.8.tar.gz"
temp_zip="${TMPDIR}fvm/fvm.zip"
mkdir -p `dirname $temp_zip`

echo "url:$download_url"
curl --progress-bar -o $temp_zip $download_url

shasum256_value=`shasum -a 256 $temp_zip | awk '{print $1}'`

echo "shasum256:${shasum256_value}"
rm -rf $temp_zip

