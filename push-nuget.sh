#!/bin/sh

DIR=$(realpath $(dirname "$0"))
KEY=$1

for nupkg in $DIR/*.nupkg
do
	case "$nupkg" in
		*ModularFlightIntegrator*)
			FEED="ksp-mods"
			;;
		*)
			FEED="ksp-assemblies"
			;;
	esac
	if [ ! "$FEED" = "" ] && [ ! "$KEY" = "" ]; then
		nuget push $nupkg $KEY -Source https://www.myget.org/F/$FEED/api/v2/package
	fi
done
