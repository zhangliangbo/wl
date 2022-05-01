(* ::Package:: *)

BeginPackage["xxl`markdown`Util`"]


csvTable::usage="csvTable[c] csv\:8f6c\:6210table"


Begin["`Private`"]


ClearAll[csvTable]


csvTable[csv_List]:=Module[
	{head=csv//First,middle,body=csv//Rest},
	middle=StringRiffle[ConstantArray[":-",Length[head]],{"| "," | "," |"}];
	head=StringRiffle[head,{"| "," | "," |"}];
	body=Map[StringRiffle[#,{"| "," | "," |"}]&,body,{1}]//StringRiffle[#,"\n"]&;
	StringRiffle[{head,middle,body},"\n"]
]


End[]


EndPackage[]
