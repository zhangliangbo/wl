#!/usr/bin/env wolframscript
(* ::Package:: *)

RunProcess[StringSplit["git add ."],"StandardOutput"]//Print
RunProcess[StringSplit["git commit -m "<>If[Length[$ScriptCommandLine]>1,$ScriptCommandLine[[2]],"\:9ed8\:8ba4\:6d88\:606f"]],"StandardOutput"]//Print
Print["start pull"]
RunProcess[StringSplit["git pull"],"StandardOutput"]//Print
Print["start push"]
RunProcess[StringSplit["git push"],"StandardOutput"]//Print
