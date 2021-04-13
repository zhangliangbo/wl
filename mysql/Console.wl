(* ::Package:: *)

BeginPackage["xxl`mysql`Console`"]


sqlDataToList::usage="sqlDataToList[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:5217\:8868"


sqlDataToAssoc::usage="sqlDataToAssoc[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:5173\:8054"


sqlDataToDataset::usage="sqlDataToDataset[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:6570\:636e\:96c6"


Begin["`Private`"]


ClearAll[sqlDataToList]


sqlDataToList[s_String]:=StringCases[s,Shortest["|"~~Whitespace~~line___~~Whitespace~~"|\n"]:>StringSplit[line,RegularExpression["\\s*\\|\\s*"]]]


ClearAll[sqlDataToAssoc]


sqlDataToAssoc[s_String]:=Module[
	{list=xxl`mysql`Console`sqlDataToList[s],first,rest},
		first=First[list];
		rest=Rest[list];
		Map[Association[(Rule@@#&)/@Transpose[{first,#}]]&,rest,{1}]
	]


ClearAll[sqlDataToDataset]


sqlDataToDataset[s_String]:=xxl`mysql`Console`sqlDataToAssoc[s]//Dataset


End[]


EndPackage[]
