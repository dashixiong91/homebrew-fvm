#!/usr/bin/env bash

set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

VERSION="1.0.8"
DOWNLOAD_URL="https://github.com/xinfeng-tech/fvm/archive/v${VERSION}.tar.gz"
FORMULA_FILE="${THIS_DIR}/fvm.rb"

# 获取以给定字符串的行号，没有则返回-1
function get_field_line_num(){
    local field target_file line_num
    target_file="$1"
    field="$2"
    line_num=`grep -n "$field" "$target_file" | awk -F ':' '{print $1}' | sed -n '$'p`
    if [[ ! ${line_num} == ""  ]]; then
        echo ${line_num}
        return
    fi
    echo "-1"
}

function update_formual(){
  local field="$1"
  local value="$2"
  local line_num=`get_field_line_num "$FORMULA_FILE" "$field"`
  local sed_mode="a"
  if [[ ${line_num} == "-1" ]];then
      return
  fi
  if [[ ${line_num} == "0" ]]; then
      sed_mode="i"
      line_num="1"
  fi
  sed -i "" "${line_num}${sed_mode}\\
  \  ${field} \"${value}\"\\
  " "${FORMULA_FILE}"
  sed -i "" "${line_num}d" "${FORMULA_FILE}"
}

function get_shasum(){
  local temp_log="${TMPDIR}fvm/fvm_fetch.log"
  mkdir -p `dirname $temp_log`
  brew fetch -f $FORMULA_FILE > $temp_log
  local shasum256_value=`cat $temp_log | grep 'SHA256' | awk '{print $2}'`
  rm -rf $temp_log
  echo ${shasum256_value}
}
function main(){
  update_formual "url" $DOWNLOAD_URL
  local sha256=`get_shasum`
  update_formual "sha256" $sha256
  echo "url:$DOWNLOAD_URL"
  echo "sha256:${sha256}"
  git add .
  git commit -m "update: ${VERSION}"
}
main