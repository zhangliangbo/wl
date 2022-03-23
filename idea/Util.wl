(* ::Package:: *)

BeginPackage["xxl`idea`Util`"]


programArgsToOneline::usage="programArgsToOneline[s]\:591a\:884c\:53c2\:6570\:53d8\:6210\:4e00\:884c"


Begin["`Private`"]


Clear[programArgsToOneline]


programArgsToOneline[s_String]:=StringSplit[s,"\n"]//Partition[#,2]&//Map[StringRiffle[#," "]&,#,{1}]&//Map[""<>#<>""&,#,{1}]&//StringRiffle[#," "]&


End[]


EndPackage[]
