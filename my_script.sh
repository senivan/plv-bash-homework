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

allSoftlinks() {
  local depth=$2
  local start=$(realpath $1)
  for link in $(find $start -mindepth 1 -maxdepth $depth -type l)
  do
    echo File \"$link\" is a soft link
  done
}

allExec(){
  local depth=$2
  local start=$(realpath $1)
  for _exec in $(find $start -mindepth 1 -maxdepth $depth -executable)
  do 
    echo File \"$_exec\" is an executable
  done

}


depth=""
recursive=0
dir=""

while getopts ":hrd:" o; do
  case "${o}" in
    h)
      usage
      ;;
    r)
      recursive=1
      ;;
    d)
      depth=${OPTARG}
      if [[ $depth -lt 0 ]]
      then
	usage
	exit 1
      fi
      ;;
    *)
      usage
      ;;
  esac
done

shift $((OPTIND - 1))
dir=$@
dir=${dir:=$(pwd)}
find_depth=0
if [[ $recursive -gt 0 ]]
then
  find_depth=$(( $depth+1 ))
else
  find_depth=1
fi

allExec $dir $find_depth
allSoftlinks $dir $find_depth






