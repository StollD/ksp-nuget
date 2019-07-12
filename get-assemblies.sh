#!/bin/sh

CDR=$(pwd)
DIR=$(realpath $(dirname "$0"))
KSP=$1/KSP_Data/Managed

mkdir $DIR/out
mkdir $DIR/tmp
cp $KSP/Assembly-CSharp.dll $KSP/Assembly-CSharp-firstpass.dll \
	$KSP/UnityEngine.dll $KSP/UnityEngine.UI.dll $DIR/tmp/
mono $DIR/tools/de4dot/de4dot.exe --dont-rename $DIR/tmp/Assembly-CSharp.dll
mv $DIR/tmp/Assembly-CSharp-cleaned.dll $DIR/tmp/Assembly-CSharp.dll
cd $DIR/tmp
mono $DIR/tools/stubber/Stubber.exe *.dll $DIR/out/
cd $CDR
rm -r $DIR/tmp
