(* ::Package:: *)

BeginPackage["xxl`java`Base`",{"JLink`"}]


Begin["`Private`"]


If[JLink`JavaLink[]===Null,JLink`InstallJava[]];


End[]


EndPackage[]
