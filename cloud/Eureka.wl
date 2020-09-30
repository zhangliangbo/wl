(* ::Package:: *)

BeginPackage["xxl`cloud`Eureka`"]


apps::usage="apps[host] \:6240\:6709\:7684\:670d\:52a1ID"


instances::usae="instances[host,app] \:67e5\:8be2\:670d\:52a1app\:7684\:6240\:6709\:5b9e\:4f8bID"


offline::usage="offline[host,app,instance]\:4e0b\:7ebf\:67d0\:4e2a\:670d\:52a1\:7684\:67d0\:4e2a\:5b9e\:4f8b"


instance::usage="instance[host,app,instance] \:67d0\:4e2a\:5b9e\:4f8b\:7684\:4fe1\:606f"


outOfService::usage="outOfService[host,app,instance] \:66f4\:6539\:5b9e\:4f8b\:72b6\:6001\:4e3a\:4e0b\:7ebf"


up::usage="up[host,app,instance] \:66f4\:6539\:5b9e\:4f8b\:72b6\:6001\:4e3a\:4e0a\:7ebf"


Begin["`Private`"]


apps[host_String]:=Module[
	{},
	URLRead[
		HTTPRequest[
			host<>"/eureka/apps",
			Association[
			Method->"GET"
		]
	],
	"Body"
	]//ImportString[#,"XML"]&//Cases[#,XMLElement["application",_,{___,XMLElement["name",_,{x_}],___}]:>x,Infinity]&
]


instances[host_String,app_String]:=Module[
	{},
	URLRead[
		HTTPRequest[
			host<>"/eureka/apps/"<>app,
			Association[
				Method->"GET"
			]
	],
	"Body"
	]//ImportString[#,"XML"]&//Cases[#,XMLElement["instance",_,{___,XMLElement["instanceId",_,{x_}],___}]:>x,Infinity]&
]


offline[host_String,app_String,instance_String]:=Module[
	{},
	URLRead[
		HTTPRequest[host<>"/eureka/apps/"<>app<>"/"<>instance,
			Association[
				Method->"DELETE"
			]
		],
		"StatusCode"
	]
]


instance[host_String,app_String,instance_String]:=Module[
	{},
	URLRead[
		HTTPRequest[host<>"/eureka/apps/"<>app<>"/"<>instance,
			Association[
				Method->"GET"
			]
		],
		"Body"
	]
]


outOfService[host_String,app_String,instance_String]:=Module[
	{},
	URLRead[
		HTTPRequest[host<>"/eureka/apps/"<>app<>"/"<>instance<>"/status?value=OUT_OF_SERVICE",
			Association[
				Method->"PUT"
			]
		],
		"StatusCode"
	]
]


up[host_String,app_String,instance_String]:=Module[
	{},
	URLRead[
		HTTPRequest[host<>"/eureka/apps/"<>app<>"/"<>instance<>"/status?value=UP",
			Association[
				Method->"DELETE"
			]
		],
		"StatusCode"
	]
]


End[]


EndPackage[]
