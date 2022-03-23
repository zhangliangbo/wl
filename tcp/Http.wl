(* ::Package:: *)

BeginPackage["xxl`tcp`Http`",{"xxl`Main`"}]


httpInfo::usage="httpInfo[]httpInfo\:4fe1\:606f"


http::usage="http[method,url]http\:8bf7\:6c42"


get::usage="get[path]get\:8bf7\:6c42"


post::usage="post[path]post\:8bf7\:6c42"


delete::usage="delete[path]delete\:8bf7\:6c42"


put::usage="put[path]put\:8bf7\:6c42"


Begin["`Private`"]


ClearAll[httpInfo];


httpInfo[OptionsPattern[]]:=Association[
	"gateway"->OptionValue["gateway"],
	"username"->OptionValue["username"],
	"password"->OptionValue["password"],
	"token"->OptionValue["token"],
	"appKey"->OptionValue["appKey"]
];


httpInfo[option_String,OptionsPattern[]]:=OptionValue[option];


Options[httpInfo]={"gateway"->"http://localhost:8080",
	"username"->"admin",
	"password"->"123456",
	"token"->Null,
	"appKey"->Null};


Clear[http];


http[method_String,url_String,o:OptionsPattern[]]:=URLRead[
	HTTPRequest[
		url,
		Association[
			Method->method,
			"Headers"->Union[{"Authorization"->httpInfo["token"],
				"userSession"->httpInfo["token"],
				"app-key"->httpInfo["appKey"],
				"accept"->"application/json;charset=UTF-8"},OptionValue["headers"]],
			"Query"->DeleteCases[OptionValue["query"],_->Null],
			"Body"->OptionValue["body"],
			"ContentType"->If[MemberQ[OptionValue["body"],_File,Infinity],Automatic,"application/json"]
		]
	],
	"Body",
	"VerifySecurityCertificates"->False
];


Options[http]={"headers"->{},"query"->{},"body"->{}};


ClearAll[get,post,delete,put]


get[url_String,o:OptionsPattern[]]:=http["GET",httpInfo["gateway"]<>url,o];


post[url_String,o:OptionsPattern[]]:=http["POST",httpInfo["gateway"]<>url,o];


delete[url_String,o:OptionsPattern[]]:=http["DELETE",httpInfo["gateway"]<>url,o];


put[url_String,o:OptionsPattern[]]:=http["PUT",httpInfo["gateway"]<>url,o];


End[]


EndPackage[]
