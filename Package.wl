(* ::Package:: *)

BeginPackage["xxl`Package`"]


packageName::usage="packageName[] \:83b7\:53d6\:5305\:540d"


Begin["`Private`"]


packageName[]:=StringReplace[NotebookFileName[],{($HomeDirectory<>$PathnameSeparator)->"",FileExtension[NotebookFileName[]]->"",$PathnameSeparator->"`","."->"`"}]


End[]


EndPackage[]
