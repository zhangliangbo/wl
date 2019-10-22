(* ::Package:: *)

BeginPackage["xxl`android`Util`"]


renameMipmap::usage="\:91cd\:547d\:540dmipmap\:76ee\:5f55\:4e0b\:7684\:8d44\:6e90"


Begin["`Private`"]


renameMipmap[dir_String,name_String,newName_String]:=
Module[
	{src},
	src=FileNames[name<>".*",dir,Infinity];
	RenameFile[#,StringReplace[#,name->newName]]&/@src
]


End[]


EndPackage[]
