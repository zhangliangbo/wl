(* ::Package:: *)

BeginPackage["xxl`mysql`Util`"]


batchInsertSql::usage="batchInsertSql[t,c] \:751f\:6210\:6279\:91cf\:63d2\:5165\:7684\:8bed\:53e5"


Begin["`Private`"]


ClearAll[batchInsertSql];


batchInsertSql[t_String,c_String]:=Module[
{columns=StringSplit[c,"\n"]},
StringTemplate["insert into `1` (`2`) values (`3`)"][t,StringRiffle[columns,","],columns//Length//ConstantArray["?",#]&//StringRiffle[#,","]&]
]


End[]


EndPackage[]
