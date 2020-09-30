(* ::Package:: *)

BeginPackage["xxl`io`Json`"]


toJson::usage="toJson[json] json\:5b57\:7b26\:4e32\:8f6c\:6210Association"


Begin["`Private`"]


toJson[json_String]:=ToString[json,CharacterEncoding->"UTF8"]//ImportString[#,"RawJSON"]&


End[]


EndPackage[]
