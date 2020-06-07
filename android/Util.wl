(* ::Package:: *)

BeginPackage["xxl`android`Util`"]


renameMipmap::usage="renameMipmap[dir,name,newName]\:91cd\:547d\:540d\:5236\:5b9a\:76ee\:5f55\:4e0b\:7684mipmap\:56fe\:7247\:8d44\:6e90"


renameMipmap::usage="renameMipmap[name,newName]\:9ed8\:8ba4\:5f53\:524d\:7b14\:8bb0\:672c\:4e0b\:7684\:6240\:5728\:76ee\:5f55"


Begin["`Private`"]


renameMipmap[dir_String,name_String,newName_String]:=
Module[
	{},
	Map[
		RenameFile[#,StringReplace[#,name<>"."->newName<>"."]]&,
		FileNames[name<>".*",dir,Infinity],
		{1}
	]
]


renameMipmap[name_String,newName_String]:=
Module[
	{},
	Map[
		RenameFile[#,StringReplace[#,name<>"."->newName<>"."]]&,
		FileNames[name<>".*",NotebookDirectory[],Infinity],
		{1}
	]
]


End[]


EndPackage[]
