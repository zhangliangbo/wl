(* ::Package:: *)

BeginPackage["xxl`cloud`Nacos`"]


nacosServer::usage="nacosServer[] nacos\:670d\:52a1\:5668"


nacosServerToken::usage="nacosServerToken[] nacos\:670d\:52a1\:5668token"


nacosServerUpload::usage="nacosServerUpload[] nacos\:670d\:52a1\:5668\:4e0a\:4f20\:914d\:7f6e\:6587\:4ef6"


Begin["`Private`"]


ClearAll[nacosServer,nacosServerToken,nacosServerUploadFile,nacosServerUploadDirectory,nacosServerUpload];


nacosServer[]:=Options[nacosServer];


nacosServer[option_String,OptionsPattern[]]:=OptionValue[option];


Options[nacosServer]={"host"->"http://localhost:8848",
"username"->"nacos","password"->"nacos","group"->"DEFAULT_GROUP","namespace"->"local","type"->"yaml","extension"->"yml","idSuffix"->""};


nacosServerToken[]:=URLRead[
HTTPRequest[
nacosServer["host"]<>"/nacos/v1/auth/login",
Association[
Method->"POST",
"Query"->{"username"->nacosServer["username"],"password"->nacosServer["password"]}
]
],
"Body"
]//ImportString[#,"RawJSON"]&//#[["accessToken"]]&;


nacosServerUploadFile[file_String]:={
FileBaseName[file],
URLRead[
	HTTPRequest[
		nacosServer["host"]<>"/nacos/v1/cs/configs",
		Association[
			Method->"POST",
			"Query"->{"accessToken"->nacosServerToken[],"dataId"->(FileBaseName[file]<>nacosServer["idSuffix"]),"group"->nacosServer["group"],"content"->Import[file,"Text"],"type"->nacosServer["type"],"tenant"->nacosServer["namespace"],"namespaceId"->nacosServer["namespace"]}
		]
	],
	"Body"
]};


nacosServerUploadDirectory[dir_String]:=Map[nacosServerUploadFile,FileNames["*"<>nacosServer["extension"],dir,1],{1}];


nacosServerUpload[file_String]:=If[DirectoryQ[file],nacosServerUploadDirectory[file],nacosServerUploadFile[file]]


End[]


EndPackage[]
