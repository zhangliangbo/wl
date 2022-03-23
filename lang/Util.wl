(* ::Package:: *)

BeginPackage["xxl`lang`Util`"]


assocCsv::usage="toCsv[list] \:5173\:8054\:5217\:8868\:8f6c\:6210csv\:683c\:5f0f"


csvAssoc::usage="csvAssoc[csv] csv\:8f6cassociation"


jsonAssoc::usage="toJson[json] json\:8f6cassociation"


jsonDataset::usage="toJsonDataset[json] json\:8f6cDataset"


addQuotationMark::usage="addQuotationMark[s] \:6dfb\:52a0\:53cc\:5f15\:53f7"


toStringAssoc::usage="toStringAssoc[s] toString\:5b57\:7b26\:4e32\:8f6c\:6210association"


upperSnake::usage="upperSnake[s] \:5927\:5199\:5e76\:4e0b\:5212\:7ebf"


lowerDot::usage="lowerDot[s] \:5c0f\:5199\:5e76\:70b9\:53f7"


addSingleQuotation::usage="addSingleQuotation[s] \:6dfb\:52a0\:5355\:5f15\:53f7"


camelToSnake::usage="camelToSnake[s] \:9a7c\:5cf0\:53d8\:4e0b\:5212\:7ebf"


intString::usage="intString[s] \:6574\:5f62\:5b57\:7b26\:4e32 "


stashField::usage="stashField[s,field] logstash\:7684\:6d88\:606f\:5b57\:6bb5"


assocJson::usage="assocJson[data] \:5bfc\:51fajson\:4f18\:5316\:7684\:51fd\:6570"


Begin["`Private`"]


ClearAll[assocJson];


assocJson[data_:(List|Association)]:=ExportString[data,"JSON"]//StringReplace[#,"\\"->""]&


ClearAll[stashField]


stashField[data_String,field_String]:=data//StringSplit[#,"\n"]&//Map[First@StringCases[#,Shortest[field<>"\":\""~~msg__~~"\""]:>msg]&,#]&


ClearAll[intString]


intString[s_Real]:=IntegerPart[s]


SetAttributes[intString,Listable]


ClearAll[camelToSnake];


camelToSnake[s_String]:=StringReplace[s,x_?UpperCaseQ:>("_"<>ToLowerCase[x])]


ClearAll[addSingleQuotation];


addSingleQuotation[s_String]:="'"<>ToString[s]<>"'";


addSingleQuotation[i_Integer]:=addSingleQuotation[ToString[i]];


SetAttributes[addSingleQuotation,Listable];


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


ClearAll[upperSnake]


upperSnake[s_String]:=StringReplace[s,"."->"_"]//ToUpperCase


ClearAll[lowerDot]


lowerDot[s_String]:=StringReplace[s,"_"->"."]//ToLowerCase


End[]


EndPackage[]
