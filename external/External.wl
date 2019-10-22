(* ::Package:: *)

BeginPackage["xxl`external`External`"]


runProcess::usage="\:6267\:884c\:8fdc\:7a0b\:547d\:4ee4"


Begin["`Private`"]


runProcess[cmd_String]:=URLRead[
	HTTPRequest[
		"https://deploy.xxlun.com/external",
		Association[
			Method->"POST",
			"Query"->{"command"->cmd}
		]
	],
	"Body"
]


End[]


EndPackage[]
