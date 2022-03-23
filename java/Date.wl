(* ::Package:: *)

BeginPackage["xxl`java`Date`",{"xxl`java`Base`"}];


javaFormatDate::usage="javaFormatDate[s] \:683c\:5f0f\:5316\:65e5\:671f"


javaFormatTime::usage="javaFormatTime[s] \:683c\:5f0f\:5316\:65f6\:95f4"


javaFormatDateTime::usage="javaFormatDateTime[s] \:683c\:5f0f\:5316\:65e5\:671f\:65f6\:95f4"


javaFormatMillis::usage="javaFormatMillis[s] \:683c\:5f0f\:5316\:6beb\:79d2\:65f6\:95f4"


Begin["`Private`"]


JLink`LoadJavaClass[#]&/@
	{"java.time.format.DateTimeFormatter","java.time.LocalDate","java.time.LocalTime",
	"java.time.LocalDateTime","java.util.Date","java.time.ZoneId"};


ClearAll[javaFormatMillis];


javaFormatMillis[s_Integer,OptionsPattern[]]:=JLink`JavaBlock[
	Module[
		{date,obj},
		date=JavaNew["java.util.Date",s];
		obj=java`time`LocalDateTime`ofInstant[date@toInstant[],java`time`ZoneId`systemDefault[]];
		obj@format@java`time`format`DateTimeFormatter`ofPattern[OptionValue["pattern"]]
	]
];


Options[javaFormatMillis]={"pattern"->"yyyy-MM-dd HH:mm:ss.SSS"}


ClearAll[javaFormatDate];


javaFormatDate[s_String,OptionsPattern[]]:=JLink`JavaBlock[
	Module[
		{obj},
		If[s===Null||s==="",Return[Null]];
		obj=java`time`LocalDate`parse[JLink`MakeJavaObject[s],java`time`format`DateTimeFormatter`ofPattern[OptionValue["oldPattern"]]];
		obj@format@java`time`format`DateTimeFormatter`ofPattern[OptionValue["newPattern"]]
	]
];


Options[javaFormatDate]={"oldPattern"->"yyyy-MM-dd","newPattern"->"yyyy-MM-dd"}


ClearAll[javaFormatTime];


javaFormatTime[s_String,OptionsPattern[]]:=JLink`JavaBlock[
	Module[
		{obj},
		If[s===Null||s==="",Return[Null]];
		obj=java`time`LocalTime`parse[JLink`MakeJavaObject[s],java`time`format`DateTimeFormatter`ofPattern[OptionValue["oldPattern"]]];
		obj@format@java`time`format`DateTimeFormatter`ofPattern[OptionValue["newPattern"]]
	]
];


Options[javaFormatTime]={"oldPattern"->"HH:mm:ss","newPattern"->"HH:mm:ss"}


ClearAll[javaFormatDateTime];


javaFormatDateTime[s_String,OptionsPattern[]]:=JLink`JavaBlock[
	Module[
		{obj},
		If[s===Null||s==="",Return[Null]];
		obj=java`time`LocalDateTime`parse[JLink`MakeJavaObject[s],java`time`format`DateTimeFormatter`ofPattern[OptionValue["oldPattern"]]];
		obj@format@java`time`format`DateTimeFormatter`ofPattern[OptionValue["newPattern"]]
	]
];


Options[javaFormatDateTime]={"oldPattern"->"yyyy-MM-dd HH:mm:ss","newPattern"->"yyyy-MM-dd HH:mm:ss"}


End[];


EndPackage[];
