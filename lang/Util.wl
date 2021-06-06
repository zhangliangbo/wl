(* ::Package:: *)

BeginPackage["xxl`lang`Util`"]


assocCsv::usage="toCsv[list] \:5173\:8054\:5217\:8868\:8f6c\:6210csv\:683c\:5f0f"


csvAssoc::usage="csvAssoc[csv] csv\:8f6cassociation"


jsonAssoc::usage="toJson[json] json\:8f6cassociation"


jsonDataset::usage="toJsonDataset[json] json\:8f6cDataset"


Begin["`Private`"]


ClearAll[assocCsv];


assocCsv[list_List]:=Module[{keys=Keys[First[list]],values=Map[Values,list]},Prepend[values,keys]]


ClearAll[csvAssoc]


csvAssoc[csv_List]:=Module[
	{head=csv//First,data=csv//Rest,columnNum=csv//First//Length},
	Map[Association[Table[head[[i]]->#[[i]],{i,1,columnNum}]]&,data,{1}]
]


ClearAll[jsonAssoc]


jsonAssoc[json_String]:=ToString[json,CharacterEncoding->"UTF8"]//ImportString[#,"RawJSON"]&


ClearAll[jsonDataset]


jsonDataset[json_String]:=jsonAssoc[json]//Dataset


End[]


EndPackage[]
