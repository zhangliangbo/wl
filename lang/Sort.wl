(* ::Package:: *)

BeginPackage["xxl`lang`Sort`"]


quick::usage="quick[list] \:5feb\:901f\:6392\:5e8f"


Begin["`Private`"]


ClearAll[bubble];


bubble[list_Symbol]:=Module[
	{sorted,unsorted},
	For[sorted=Length[list],sorted>1,sorted--,
		For[unsorted=1,unsorted<sorted,unsorted++,
			If[]
		]
	]
]


ClearAll[quickMiddle];


quickMiddle[list_Symbol,start_Integer,end_Integer]:=Module[
	{s=start,e=end,base,temp},
	base=list[[start]];
	While[s<e,
		While[s<e&&list[[e]]>=base,e--];
		While[s<e&&list[[s]]<=base,s++];
		If[s<e,temp=list[[s]];list[[s]]=list[[e]];list[[e]]=temp];
	];
	list[[start]]=list[[s]];
	list[[s]]=base;
	s
];


SetAttributes[quickMiddle,HoldFirst];


ClearAll[quickSort];


quickSort[list_Symbol,start_Integer,end_Integer]:=Module[
	{middle},
	If[
		start<end,
		middle=quickMiddle[list,start,end];
		If[start<middle-1,quickSort[list,start,middle-1]];
		If[middle+1<end,quickSort[list,middle+1,end]];
	]
]


SetAttributes[quickSort,HoldFirst];


ClearAll[quick];


quick[list_Symbol]:=Module[
	{},
	quickSort[list,1,Length[list]];
	list
]


SetAttributes[quick,HoldFirst]


End[]


EndPackage[]
