(* ::Package:: *)

BeginPackage["xxl`util`File`",{"JLink`"}];


fileReplace::usage="fileReplace[file,rule] \:66ff\:6362\:6587\:4ef6\:7684\:5185\:5bb9";


Begin["`Private`"]


ClearAll[fileReplace]


fileReplace[file_String,rule_List,OptionsPattern[]]:=Import[file,"Text"]//StringReplace[#,rule]&//Export[FileNameJoin[{FileNameDrop[file,-1],FileBaseName[file]<>OptionValue["suffix"]<>"."<>FileExtension[file]}],#,"Text"]&


fileReplace[file_String,rule_String,OptionsPattern[]]:=xxl`util`File`fileReplace[file,{rule}]


Options[fileReplace]={"suffix"->"_new"};


End[]


EndPackage[]
