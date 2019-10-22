(* ::Package:: *)

BeginPackage["xxl`util`Date`",{"JLink`"}];


longDate::usage="convert long to date.";


now::usage="current time in millis";


formatLong::usage="format long date to String";


nowString::usage="current time string";


getLong::usage="get long time inMillis";


Begin["`Private`"]


ClearAll[longDate,now,formatLong,nowString];


(*\:9700\:8981\:5b89\:88ddJava\:624d\:80fd\:8fd0\:884c*)
If[SameQ[JavaLink[],Null],InstallJava[]];


(*\:5c06Java\:7684\:6beb\:79d2\:503c\:8f6c\:5316\:6210Mathematica\:65f6\:95f4\:5bf9\:8c61*)
longDate[l_Integer]:=JavaBlock[
	Module[
		{calendar},
		LoadJavaClass["java.util.Calendar"];
		calendar=java`util`Calendar`getInstance[];
		calendar@setTimeInMillis[l];
		DateObject[{
			calendar@get[java`util`Calendar`YEAR],
			calendar@get[java`util`Calendar`MONTH]+1,
			calendar@get[java`util`Calendar`DAYUOFUMONTH],
			calendar@get[java`util`Calendar`HOURUOFUDAY],
			calendar@get[java`util`Calendar`MINUTE],
			calendar@get[java`util`Calendar`SECOND]
		}]
	]
]


(*\:73b0\:5728\:65f6\:95f4\:7684\:6beb\:79d2\:503c*)
now[]:=JavaBlock[
	Module[
	{},
	LoadJavaClass["java.util.Calendar",StaticsVisible->True];
	java`util`Calendar`getInstance[]@getTimeInMillis[]]
];


formatLong[l_Integer,p_String]:=JavaBlock[
	Module[
	{},
	JavaNew["java.text.SimpleDateFormat",p]@format[JavaNew["java.util.Date",l]]
	]
]


nowString[]:=formatLong[now[],"yyyy-MM-dd HH:mm:ss"]


getLong[date_TimeObject]:=JavaBlock[
	Module[
		{calendar},
		LoadJavaClass["java.util.Calendar"];
		calendar=java`util`Calendar`getInstance[];
		calendar@set[java`util`Calendar`HOURUOFUDAY,DateValue[date,"Hour"]];
		calendar@set[java`util`Calendar`MINUTE,DateValue[date,"Minute"]];
		calendar@set[java`util`Calendar`SECOND,DateValue[date,"Second"]];
		calendar@getTimeInMillis[]
	]
]


End[];


EndPackage[];
