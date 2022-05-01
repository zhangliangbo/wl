(* ::Package:: *)

BeginPackage["xxl`prometheus`Util`"]


dropNote::usage="dropNote[s]\:53bb\:6389\:6ce8\:91ca"


metricAssoc::usage="metricAssoc[s]\:6307\:6807\:8f6c\:6210\:5173\:8054"


Begin["`Private`"]


ClearAll[dropNote]


dropNote[s_String]:=s//StringSplit[#,"\n"]&//DeleteCases[#,a_/;StringStartsQ[a,"#"]]&


ClearAll[metricAssoc]


metricAssoc[s_String]:=Module[
	{sequence=s//StringSplit[#,"\n"]&//Map[StringTrim,#,{1}]&},
	SequenceSplit[sequence,
		{h_/;StringStartsQ[h,"#"],t_/;StringStartsQ[t,"#"],d__/;AllTrue[{d},Not[StringStartsQ[#,"#"]]&]}:>Association["name"->StringDelete[h,"# HELP"],"type"->Last[StringSplit[t," "]],"data"->StringRiffle[{d},"<br/>"]]
	]//SortBy[#,"name"]&
]


End[]


EndPackage[]
