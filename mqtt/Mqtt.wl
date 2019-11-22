(* ::Package:: *)

BeginPackage["xxl`mqtt`Mqtt`",{"JLink`","xxl`util`Date`"}];


connection::usage="a mqtt connection.";


subscribe::usage="subscribe a topic.";


publish::usage="publish a topic.";


disconnect::usage="disconnect a connection.";


Begin["`Private`"];


context=Context[];


ClearAll[connection,subscribe,publish,disconnect]


If[JavaLink[]===Null,InstallJava[]];
AddToClassPath[FileNameJoin[{$HomeDirectory,"xxl","jar"}]];


connection[host_String,id_String,user_String,pwd_String]:=JavaBlock[
	Module[
		{
			cb=ImplementJavaInterface["xxl.mqtt.Connection$OnConnectionListener",{"onConnected"->context<>"onConnected"}]
		},
		JavaNew["xxl.mqtt.Connection",host,id,user,pwd,cb]
	]
]


onConnected[mqtt_?JavaObjectQ]:=Print["mqtt connected."];


subscribe[conn_?JavaObjectQ,topic_String]:=JavaBlock[
	Module[
		{observer=ImplementJavaInterface["io.reactivex.Observer",{"onNext"->context<>"onNext"}]},
		(conn@subscribe[topic,2])@subscribe[observer];
		conn
	]
]


onNext[pair_?JavaObjectQ]:=JavaBlock[
	Print[
		nowString[]<>"-"<>JavaObjectToExpression[JavaNew["java.lang.String",(pair@getRight[])@getPayload[],"UTF8"]]
	]
];


publish[conn_?JavaObjectQ,topic_String,content_String]:=JavaBlock[
	Module[
		{
		m=JavaNew["org.eclipse.paho.client.mqttv3.MqttMessage",ToCharacterCode[content,"UTF8"]],
		observer=ImplementJavaInterface["io.reactivex.Observer",{"onNext"->context<>"onPublishNext"}]},
		(conn@publish[topic,m])@subscribe[observer];
		conn
	]
]


onPublishNext[token_?JavaObjectQ]:=JavaBlock[
	Module[
		{e=token@getException[]},
		If[e===Null,"publish succeed.","publish failed: "+e@getReasonCode[]]
	]
]


disconnect[conn_?JavaObjectQ]:=JavaBlock[
	Module[
	{observer=ImplementJavaInterface["io.reactivex.CompletableObserver",{"onComplete"->context<>"onComplete","onError"->context<>"onError"}]},
	(conn@disconnect[])@subscribe[observer];
	(*no response*)
	]
]


onComplete[]:=Print["mqtt disconnected."]


onError[e_?JavaObjectQ]:=JavaBlock[
		Print["mqtt disconnect failure: "+e@getMessage[]]
	]


End[];


EndPackage[];
