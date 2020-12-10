(* ::Package:: *)

BeginPackage["xxl`navicat`Sql`"]


noDrop::usage="noDrop[path] \:53bb\:6389drop\:8868\:683c\:8bed\:53e5"


replace::usage="replace[path,replacement] \:66ff\:6362\:5b57\:7b26\:4e32"


Begin["`Private`"]


ClearAll[noDrop];


noDrop[path_String]:=Module[
	{dst=FileNameJoin[{FileNameTake[path,{1,-2}],FileBaseName[path]<>"_no_drop."<>FileExtension[path]}],
	sql=Import[path,"Text"]},
	Export[dst,StringTake[sql,{StringPosition[sql,"BEGIN;\n"][[-1,-1]],-1}],"Text"]
]


ClearAll[replace];


replace[path_String,replacement_List]:=Module[
	{dst=FileNameJoin[{FileNameTake[path,{1,-2}],FileBaseName[path]<>"_repalce."<>FileExtension[path]}],
	sql=Import[path,"Text"]},
	Export[dst,StringReplace[sql,replacement],"Text"]
]


End[]


EndPackage[]
