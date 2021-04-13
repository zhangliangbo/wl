(* ::Package:: *)

BeginPackage["xxl`redis`Console`"]


redisKeyToList::usage="redisKeyToList \:5b57\:7b26\:4e32\:8f6c\:6210\:5217\:8868"


delMulti::usage="delMulti \:5220\:9664\:591a\:4e2a\:8bed\:53e5"


Begin["`Private`"]


redisKeyToList[str_String]:=StringCases[str,"\""~~Shortest[key__]~~"\"":>("\""<>key<>"\"")]


delMulti[str_String]:="del "<>StringRiffle[xxl`redis`Console`redisKeyToList[str]," "]


End[]


EndPackage[]
