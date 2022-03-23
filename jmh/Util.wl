(* ::Package:: *)

BeginPackage["xxl`jmh`Util`"]


jmhPlot::usage="jmhPlot[s]\:7ed8\:5236jmh\:6d4b\:8bd5\:56fe"


Begin["`Private`"]


Clear[jmhPlot]


jmhPlot[s_String]:=Module[
{r,n},
r=s//StringSplit[#,"\n"]&//Map[StringSplit[#,Whitespace]&,#,{1}]&;
n=Map[{ToExpression@First[StringCases[#[[1]],__~~"measure"~~o__:>o]],ToExpression[#[[4]]]}&,r[[2;;]],{1}]//SortBy[#,First]&;
ListLinePlot[n,PlotLabel->First[StringCases[r[[-1,1]],t__~~"."~~___:>t]],AxesLabel->{"n",r[[-1,-1]]}]
]


End[]


EndPackage[]
