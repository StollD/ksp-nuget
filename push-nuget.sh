#!/bin/sh

DIR=$(realpath $(dirname "$0"))
KEY=$1

for nupkg in $DIR/*.nupkg
do
	if [[ "$nupkg" == *"Assembly-CSharp"* ]]
	then
		FEED="ksp-assemblies"
	fi
	if [[ "$nupkg" == *"UnityEngine"* ]]
	then
		FEED="ksp-assemblies"
	fi
	if [[ "$nupkg" == *"ModularFlightIntegrator"* ]]
	then
		FEED="ksp-mods"
	fi
	nuget push $nupkg $KEY -Source https://www.myget.org/F/$FEED/api/v2/package
done
