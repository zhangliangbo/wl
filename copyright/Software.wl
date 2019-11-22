(* ::Package:: *)

BeginPackage["xxl`copyright`Software`"]


fileLines::usage="\:7edf\:8ba1\:6587\:4ef6\:6216\:8005\:76ee\:5f55\:7684\:884c\:6570";


selectNoEmptyLines::usage="\:627e\:51fa\:6240\:6709\:7684\:975e\:7a7a\:884c\:6570";


getPattern::usage="\:83b7\:53d6\:6587\:4ef6\:7684\:5339\:914d\:6a21\:5f0f";


Begin["`Private`"]


getPattern[extensions_]:=If[
	ListQ[extensions],
	Alternatives[Sequence@@(("*."<>#)&/@extensions)],
	"*."<>extensions
]


Options[fileLines]={"extension"->{"vue","js","scss"}};


fileLines[dir_,OptionsPattern[]]:=Module[
	{
	coutLine,
	files,
	lines=0
	},
	coutLine[path_]:=StringCount[Import[path,"Text"],RegularExpression["\\n{1,}"]]+1;
	If[
		DirectoryQ[dir],
		files=FileNames[getPattern[OptionValue["extension"]],dir,Infinity];
		lines=coutLine/@files;
		Plus[Sequence@@lines]
		,
		coutLine[dir]
	]
]


Options[selectNoEmptyLines]={"extension"->{"vue","js","scss"}};


selectNoEmptyLines[dir_String,lineNum_Integer,part_Integer,OptionsPattern[]]:=Module[
	{deleteLine, files, num=0, lineIndex=lineNum,index=1, text=ConstantArray["",part]},
	deleteLine[path_]:=StringReplace[Import[path,"Text"],RegularExpression["\\n{2,}"]->"\n"];
	If[
		DirectoryQ[dir],
		files=FileNames[getPattern[OptionValue["extension"]],dir,Infinity];
		Do[
			Part[text,index]=Part[text,index]<>deleteLine[Part[files,n]];
			num+=fileLines[Part[files,n]];
			If[num>lineNum,num=0;index++];
			If[index>part,Break[]]
			,
			{n,Length[files]}
		];
		text
		,
		deleteLine[dir]
	]
]


selectNoEmptyLines[files_List,lineNum_Integer]:=Module[
	{deleteLine, num=0, text=""},
	deleteLine[path_]:=StringReplace[Import[path,"Text"],RegularExpression["\\n{2,}"]->"\n"];
	Do[
		text=text<>deleteLine[Part[files,n]];
		num+=fileLines[Part[files,n]];
		If[num>lineNum,Break[]]
		,
		{n,Length[files]}
	];
	text
]


End[]


EndPackage[]
