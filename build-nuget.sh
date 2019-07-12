#!/bin/sh

DIR=$(realpath $(dirname "$0"))

mkdir $DIR/tmp
cp $DIR/out/*.dll $DIR/tmp/
cp $DIR/nuget/*.nuspec $DIR/tmp/
for nuspec in $DIR/tmp/*.nuspec
do
	sed -i "s/{KSP-VERSION}/$1/g" $nuspec
	nuget pack $nuspec
done
rm -r $DIR/tmp
