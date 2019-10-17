#!/bin/sh

CDR=$(pwd)
DIR=$(realpath $(dirname "$0"))
KSP="$1/KSP_Data/Managed"

array()
{
	for i; do
		echo "$i "
	done
}

ASSEMBLIES=$(array					\
	"Assembly-CSharp.dll"				\
	"Assembly-CSharp-firstpass.dll"			\
	"UnityEngine.AssetBundleModule.dll"		\
	"UnityEngine.CoreModule.dll"			\
	"UnityEngine.ImageConversionModule.dll"		\
	"UnityEngine.PhysicsModule.dll"			\
	"UnityEngine.SharedInternalsModule.dll"		\
	"UnityEngine.UI.dll"				\
	"UnityEngine.UnityWebRequestWWWModule.dll"	\
)

mkdir $DIR/out
mkdir $DIR/tmp

for asm in $(echo $ASSEMBLIES); do
	cp $KSP/$asm $DIR/tmp
done

pushd $DIR/tmp
	dotnet $DIR/tools/de4dot/de4dot.dll	\
		--dont-rename Assembly-CSharp.dll
	mv Assembly-CSharp-cleaned.dll Assembly-CSharp.dll
	mono $DIR/tools/stubber/Stubber.exe *.dll $DIR/out/
popd

rm -r $DIR/tmp
