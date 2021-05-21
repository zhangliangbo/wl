(* ::Package:: *)

BeginPackage["xxl`rabbitmq`Web`",{"xxl`github`Level0`"}]


rabbitWebInfo::usage="RabbitWebInfo[]\:8bbe\:7f6erabbitmq\:7684\:4fe1\:606f"


queues::usage="queues[]\:6240\:6709\:7684\:961f\:5217"


queueBindings::usage="queueBindings[queue]\:961f\:5217\:7684\:7ed1\:5b9a\:4fe1\:606f"


queueGet::usage="queueGet[queue,count,requeue]\:83b7\:53d6\:961f\:5217\:7684\:6570\:636e"


queueGetOne::usage="queueGetOne[queue]\:83b7\:53d6\:961f\:5217\:7684\:4e00\:6761\:6570\:636e"


exchanges::usage="exchanges[]\:83b7\:53d6\:6240\:6709\:4ea4\:6362\:673a"


exchangeBindings::usage="exchangeBindings[exchange]\:4ea4\:6362\:673a\:7684\:7ed1\:5b9a\:4fe1\:606f"


exchangePublish::usage="emptyExchangePublish[queue,data]\:76f4\:63a5\:5f80\:961f\:5217\:53d1\:4e00\:6761\:6570\:636e"


Begin["`Private`"]


ClearAll[rabbitWebInfo]


rabbitWebInfo[OptionsPattern[]]:=Association[
	"host"->OptionValue["host"],
	"port"->OptionValue["port"],
	"username"->OptionValue["username"],
	"password"->OptionValue["password"]
];


rabbitWebInfo[option_String,OptionsPattern[]]:=OptionValue[option];


Options[rabbitWebInfo]={
	"host"->"http://localhost",
	"port"->"15672",
	"username"->"mqtt",
	"password"->"mqtt"
};


ClearAll[queues]


queues[]:=URLRead[
		HTTPRequest[
			rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/queues/"<>URLEncode["/"],
			Association["Username"->rabbitWebInfo["username"],"Password"->rabbitWebInfo["password"]]
		],
		"Body"
]//xxl`github`Level0`toJson//Map[#["name"]&,#]&


ClearAll[queueBindings]


queueBindings[queue_String]:=URLRead[
	HTTPRequest[
		rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/queues/"<>URLEncode["/"]<>"/"<>queue<>"/bindings",
		Association["Username"->rabbitWebInfo["username"],"Password"->rabbitWebInfo["password"]]
	],
	"Body"
]//xxl`github`Level0`toJson


ClearAll[queueGet]


queueGet[queue_String,count_Integer,requeue:(True|False)]:=URLRead[
	HTTPRequest[
		rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/queues/"<>URLEncode["/"]<>"/"<>queue<>"/get",
		Association[
			"Username"->rabbitWebInfo["username"],
			"Password"->rabbitWebInfo["password"],
			Method->"POST",
			"Body"->ExportString[Association["count"->count,"requeue"->If[requeue,"true","false"],"ackmode"->If[requeue,"ack_requeue_true","ack_requeue_false"],"encoding"->"auto"],"JSON"],
			"ContentType"->"application/json"
		]
	],
	"Body"
]//xxl`github`Level0`toJson


ClearAll[queueGetOne]


queueGetOne[queue_String,requeue:(True|False)]:=queueGet[queue,1,requeue]//First[#,"none"]&


queueGetOne[queue_String]:=queueGetOne[queue,True]


ClearAll[exchangeBindings]


exchangeBindings[exchange_String]:=URLRead[
	HTTPRequest[
		rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/exchanges/"<>URLEncode["/"]<>"/"<>exchange<>"/bindings/source",
		Association["Username"->rabbitWebInfo["username"],"Password"->rabbitWebInfo["password"]]
	],
	"Body"
]//xxl`github`Level0`toJson


ClearAll[exchangePublish]


Options[exchangePublish]={"headers"->Association[]}


exchangePublish[exchange_String,routeKey_String,data_String,OptionsPattern[]]:=URLRead[
	HTTPRequest[
		rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/exchanges/"<>URLEncode["/"]<>"/"<>exchange<>"/publish",
		Association[
			"Username"->rabbitWebInfo["username"],
			"Password"->rabbitWebInfo["password"],
			Method->"POST",
			"Body"->ExportString[
				Association["properties"->Association["delivery_mode"->1,"headers"->OptionValue["headers"]],
				"routing_key"->routeKey,
				"payload"->data,
				"payload_encoding"->"string"],
				"JSON"
			],
			"ContentType"->"application/json"
		]
	],
	"Body"
]//xxl`github`Level0`toJson


exchangePublish[exchange_String,routeKey_String,data_Association|data_List,ops:OptionsPattern[]]:=exchangePublish[exchange,routeKey,ExportString[data,"JSON"],ops]


ClearAll[exchanges]


exchanges[]:=URLRead[
		HTTPRequest[
			rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/exchanges/"<>URLEncode["/"],
			Association["Username"->rabbitWebInfo["username"],"Password"->rabbitWebInfo["password"]]
		],
		"Body"
]//xxl`github`Level0`toJson//Map[#["name"]&,#]&


ClearAll[exchangeBindings]


exchangeBindings[exchange_String]:=URLRead[
	HTTPRequest[
		rabbitWebInfo["host"]<>":"<>rabbitWebInfo["port"]<>"/api/exchanges/"<>URLEncode["/"]<>"/"<>exchange<>"/bindings/source",
		Association["Username"->rabbitWebInfo["username"],"Password"->rabbitWebInfo["password"]]
	],
	"Body"
]//xxl`github`Level0`toJson


End[]


EndPackage[]
