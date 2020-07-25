#!/usr/bin/env wolframscript
(* ::Package:: *)

Print["add"]


RunProcess[StringSplit["git add ."],"StandardOutput"]//Print


Print["commit"]


RunProcess[StringSplit["git commit -m "<>If[Length[$ScriptCommandLine]>1,$ScriptCommandLine[[2]],"default message"]],"StandardOutput"]//Print


Print["pull"]


RunProcess[StringSplit["git pull"],"StandardOutput"]//Print


Print["push"]


RunProcess[StringSplit["git push"],"StandardOutput"]//Print


Print["finish"]


Pause[1]
