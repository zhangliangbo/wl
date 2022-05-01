(* ::Package:: *)

BeginPackage["xxl`mysql`Util`"]


batchInsertSql::usage="batchInsertSql[t,c] \:751f\:6210\:6279\:91cf\:63d2\:5165\:7684\:8bed\:53e5"


batchUpdateSql::usage="batchUpdateSql[t,c] \:751f\:6210\:6279\:91cf\:66f4\:65b0\:7684\:8bed\:53e5"


Begin["`Private`"]


ClearAll[batchInsertSql];


batchInsertSql[t_String,c_String]:=Module[
{columns=StringSplit[c,"\n"]},
StringTemplate["insert into `1` (`2`) values (`3`)"][t,StringRiffle[columns,","],columns//Length//ConstantArray["?",#]&//StringRiffle[#,","]&]
]


ClearAll[batchUpdateSql];


batchUpdateSql[t_String,c_String]:=Module[
{columns=StringSplit[c,"\n"]},
StringTemplate["update `1` set `2` where id=?"][t,columns//DeleteCases[#,"id"]&//Map[#<>":=?"&,#,{1}]&//StringRiffle[#,","]&]
]


End[]


EndPackage[]
