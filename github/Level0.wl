(* ::Package:: *)

BeginPackage["xxl`github`Level0`",{"JLink`"}]


toAssoc::usage="toAssoc[map] map\:8f6cassociation"


toDataset::usage="toDataset[map] map\:8f6cDataset"


toJson::usage="toJson[json] json\:8f6cassociation"


toJsonDataset::usage="toJsonDataset[json] json\:8f6cDataset"


Begin["`Private`"]


If[JLink`JavaLink[]===Null,JLink`InstallJava[]];


JLink`AddToClassPath["D:\\level\\level0\\build\\libs\\level0-1.0.1-all.jar"];


If[FreeQ[LoadedJavaClasses[],JavaClass[#,___]],LoadJavaClass[#]]&/@
	{"xxl.mathematica.java.Converter"};


ClearAll[toAssoc]


toAssoc[object_]:=JavaBlock[
	Module[
		{rules},
		If[!JLink`InstanceOf[object,"java.util.Map"],Return[object]];
		rules=xxl`mathematica`java`Converter`map[object]//JLink`JavaObjectToExpression;
		Map[#@getKey[]->#@getValue[]&,rules]//Apply[Association,#]&
	]
];


SetAttributes[toAssoc,{Listable}]


ClearAll[toDataset]


toDataset[object_]:=xxl`github`Level0`toAssoc[object]//Dataset


ClearAll[toJson]


toJson[json_String]:=ToString[json,CharacterEncoding->"UTF8"]//ImportString[#,"RawJSON"]&


ClearAll[toJsonDataset]


toJsonDataset[json_String]:=xxl`github`Level0`toJson[json]//Dataset


End[]


EndPackage[]
