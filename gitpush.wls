#!/usr/bin/env wolframscript
(* ::Package:: *)

RunProcess[StringSplit["git add ."],"StandardOutput"]//Print
Pause[1]
RunProcess[StringSplit["git commit -m "<>If[Length[$ScriptCommandLine]>1,$ScriptCommandLine[[2]],"\:9ed8\:8ba4\:6d88\:606f"]]]
Pause[1]
RunProcess[StringSplit["git pull origin master"]]
Pause[1]
RunProcess[StringSplit["git push origin master"]]
