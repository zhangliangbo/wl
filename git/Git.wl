(* ::Package:: *)

BeginPackage["xxl`git`Git`"]


onepush::usage="\:4e00\:952e\:6dfb\:52a0 \:63d0\:4ea4 \:5220\:9664"


Begin["`Private`"]


onepush[dir_String,msg_String:"default message"]:=Block[
{},
RunProcess[{"git","add","."},ProcessDirectory->dir]/.
in_Association:>If[in["ExitCode"]==0,Print["add success"];RunProcess[{"git","commit","-m","default message"},ProcessDirectory->dir],Print["add error: "<>in["StandardError"]]]/.
in_Association:>If[in["ExitCode"]==0,Print["commit success"];RunProcess[{"git","push","origin","master"},ProcessDirectory->dir],Print["commit error: "<>in["StandardError"]]]/.
in_Association:>If[in["ExitCode"]==0,Print["push success"],Print["push error: "<>in["StandardError"]]]
]


End[]


EndPackage[]
