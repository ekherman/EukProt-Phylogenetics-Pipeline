#!/bin/bash

programname=$0
usage(){
	echo "Usage: $programname [-i input_dir]"
	echo "   -i       specify the path to the input directory"
	echo "   -o       specify the path to the output temp directory"
	exit 1
}
if [ $# -eq 0 ]; then
    usage && exit 1
fi

# Script options
while getopts i:o: flag
do
  case "${flag}" in
        i) dir=${OPTARG};;
        o) outdir=${OPTARG};;
        *)
          usage && exit 1;;
  esac
done

cd "$dir" || exit 1
for i in *.fasta
do
  sed -e "/^>/s/>.*/>$i/g" "$i" > "$i"2
done

for i in *.fasta2
do
  sed -i '/^>/s/\.fasta//g' "$i"
done

mkdir -p "$outdir"
for i in *.fasta2
do
  mv "$i" "$outdir"
done

touch rename_complete.txt
exit 0
