(* ::Package:: *)

BeginPackage["xxl`github`Level0`",{"xxl`java`Base`"}]


toAssoc::usage="toAssoc[map] map\:8f6cassociation"


toList::usage="toList[map] map\:8f6c\:5217\:8868"


toDataset::usage="toDataset[map] map\:8f6cDataset"


Begin["`Private`"]


JLink`AddToClassPath["D:\\level\\level0\\build\\libs\\level0-1.0.1-all.jar"];


JLink`LoadJavaClass[#]&/@
	{"xxl.mathematica.java.Converter"};


ClearAll[toAssoc]


toAssoc[object_]:=JLink`JavaBlock[
	Module[
		{rules},
		If[!JLink`InstanceOf[object,"java.util.Map"],Return[object]];
		rules=xxl`mathematica`java`Converter`map[object];
		Map[#@getKey[]->#@getValue[]&,rules//JLink`JavaObjectToExpression]//Apply[Association,#]&
	]
];


SetAttributes[toAssoc,{Listable}]


ClearAll[toList]


toList[object_]:=toAssoc[object]//Prepend[Values[#],Keys[First[#]]]&


ClearAll[toDataset]


toDataset[object_]:=toAssoc[object]//Dataset


End[]


EndPackage[]
