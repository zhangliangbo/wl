(* ::Package:: *)

BeginPackage["xxl`lang`Util`"]


toCsv::usage="toCsv[list] \:5173\:8054\:5217\:8868\:8f6c\:6210csv\:683c\:5f0f"


Begin["`Private`"]


ClearAll[toCsv];


toCsv[list_List]:=Module[{keys=Keys[First[list]],values=Map[Values,list]},Prepend[values,keys]]


End[]


EndPackage[]
