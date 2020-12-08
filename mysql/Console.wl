(* ::Package:: *)

BeginPackage["xxl`mysql`Console`"]


toList::usage="toList[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:5217\:8868"


toAssoc::usage="toAssoc[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:5173\:8054"


toDataset::usage="toDataset[s] \:628a\:5b57\:7b26\:4e32\:63a7\:5236\:53f0\:5b57\:7b26\:4e32\:8f6c\:6210\:6570\:636e\:96c6"


Begin["`Private`"]


toList[s_String]:=StringCases[s,Shortest["|"~~Whitespace~~line___~~Whitespace~~"|\n"]:>StringSplit[line,RegularExpression["\\s*\\|\\s*"]]]


toAssoc[s_String]:=Module[
	{list=xxl`mysql`Console`toList[s],first,rest},
		first=First[list];
		rest=Rest[list];
		Map[Association[(Rule@@#&)/@Transpose[{first,#}]]&,rest,{1}]
	]


toDataset[s_String]:=xxl`mysql`Console`toAssoc[s]//Dataset


End[]


EndPackage[]
