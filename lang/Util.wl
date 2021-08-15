(* ::Package:: *)

BeginPackage["xxl`lang`Util`"]


assocCsv::usage="toCsv[list] \:5173\:8054\:5217\:8868\:8f6c\:6210csv\:683c\:5f0f"


csvAssoc::usage="csvAssoc[csv] csv\:8f6cassociation"


jsonAssoc::usage="toJson[json] json\:8f6cassociation"


jsonDataset::usage="toJsonDataset[json] json\:8f6cDataset"


addQuotationMark::usage="addQuotationMark[s] \:6dfb\:52a0\:53cc\:5f15\:53f7"


toStringAssoc::usage="toStringAssoc[s] toString\:5b57\:7b26\:4e32\:8f6c\:6210association"


Begin["`Private`"]


ClearAll[assocCsv];


assocCsv[list_List]:=Module[{keys=Keys[First[list]],values=Map[Values,list]},Prepend[values,keys]]


ClearAll[csvAssoc]


csvAssoc[csv_List,headFunc_Function]:=Module[
	{head=headFunc[csv//First],data=csv//Rest,columnNum=csv//First//Length},
	Map[Association[Table[head[[i]]->#[[i]],{i,1,columnNum}]]&,data,{1}]
]


csvAssoc[csv_List]:=csvAssoc[csv,#&]


ClearAll[jsonAssoc]


jsonAssoc[json_String]:=ToString[json,CharacterEncoding->"UTF8"]//ImportString[#,"RawJSON"]&


ClearAll[jsonDataset]


jsonDataset[json_String]:=jsonAssoc[json]//Dataset


ClearAll[addQuotationMark]


addQuotationMark[s_String]:="\""<>s<>"\"";


SetAttributes[addQuotationMark,Listable]


ClearAll[toStringAssoc];


toStringAssoc[s_String,snake_:(True|False)]:=s//StringCases[#,Shortest[("{"|" ")~~k__~~"="~~v__~~(","|"}")]:>(k->v)]&//Association@@#&//If[snake,KeyMap[StringReplace[#,x_?UpperCaseQ:>("_"<>ToLowerCase[x])]&,#],#]&;


toStringAssoc[s_String]:=toStringAssoc[s,True];


End[]


EndPackage[]
