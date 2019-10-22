(* ::Package:: *)

BeginPackage["xxl`copyright`Software`"]


fileLines::usage="\:7edf\:8ba1\:6587\:4ef6\:6216\:8005\:76ee\:5f55\:7684\:884c\:6570";


Begin["`Private`"]


fileLines[dir_]:=Module[
	{files,lines=0},
	If[
		DirectoryQ[dir],
		files=FileNames[Alternatives["*.vue"|"*.js"|"*.scss"],dir,Infinity];
		lines=(StringCount[Import[#,"Text"],RegularExpression["\\n"]]+1)&/@files;
		Plus[Sequence@@lines]
		,
		StringCount[Import[dir,"Text"],RegularExpression["\\n"]]+1
	]
]


End[]


EndPackage[]
