#!/usr/bin/env wolframscript
(* ::Package:: *)

RunProcess[StringSplit["git add ."],"StandardOutput"]//Print
RunProcess[StringSplit["git commit -m "<>If[Length[$ScriptCommandLine]>1,$ScriptCommandLine[[2]],"\:9ed8\:8ba4\:6d88\:606f"]],"StandardOutput"]//Print
RunProcess[StringSplit["git pull origin master"],"StandardOutput"]//Print
RunProcess[StringSplit["git push origin master"],"StandardOutput"]//Print
