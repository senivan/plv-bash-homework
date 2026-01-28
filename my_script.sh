#!/bin/bash
usage() {
  cat << 'EOF'
Usage: ./my_script.sh [-h] [-d NUM] [-r] [PATH]
  - -h      display this message
  - -d      depth of recursion in the directory
  - -r      enables recursive search through folders
  - PATH    path to a folder. Optional, if not present current working directory used.
EOF
}

isSoftLink() {
  local filename=$1
  local flag=0
  for test_name in $(find -type l)
  do
    local R_FILENAME=$(realpath -s $filename)
    local R_TESTNAME=$(realpath -s $test_name)
    if [ "$R_FILENAME" = "$R_TESTNAME" ]
    then
      flag=1
      break
    fi
  done
  echo $flag
}



depth=""
recursive=0
dir=""

isSoftLink "cat.txt"

