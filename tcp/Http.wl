(* ::Package:: *)

BeginPackage["xxl`tcp`Http`",{"xxl`Main`"}]


httpInfo::usage="httpInfo[]httpInfo\:4fe1\:606f"


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
	"token"->OptionValue["token"]
];


httpInfo[option_String,OptionsPattern[]]:=OptionValue[option];


Options[httpInfo]={"gateway"->"http://localhost:8080","username"->"admin","password"->"123456","token"->Null};


Clear[http];


http[method_String,url_String,o:OptionsPattern[]]:=URLRead[
	HTTPRequest[
		url,
		Association[
			Method->method,
			"Headers"->{"Authorization"->httpInfo["token"],"accept"->"application/json;charset=UTF-8","Content-Type"->"application/json"},
			"Query"->OptionValue["query"],
			"Body"->OptionValue["body"],
			"ContentType"->"application/json"
		]
	],
	"Body",
	"VerifySecurityCertificates"->False
];


Options[http]={"query"->{},"body"->{}};


ClearAll[get,post,delete,put]


get[url_String,o:OptionsPattern[]]:=http["GET",httpInfo["gateway"]<>url,o];


post[url_String,o:OptionsPattern[]]:=http["POST",httpInfo["gateway"]<>url,o];


delete[url_String,o:OptionsPattern[]]:=http["DELETE",httpInfo["gateway"]<>url,o];


put[url_String,o:OptionsPattern[]]:=http["PUT",httpInfo["gateway"]<>url,o];


End[]


EndPackage[]