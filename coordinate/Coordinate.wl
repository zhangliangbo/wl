(* ::Package:: *)

BeginPackage["xxl`coordinate`Coordinate`",{"JLink`"}];


toXYZ::usage="\:7ecf\:7eac\:5ea6\:8f6c\:5e73\:9762\:5750\:6807";


toBLH::usage="\:5e73\:9762\:5750\:6807\:8f6c\:7ecf\:7eac\:5ea6";


deleteClose::usage="\:5220\:9664\:8ddd\:79bb\:7279\:522b\:8fd1\:548c\:7279\:522b\:8fdc\:7684\:70b9";


Begin["`Private`"];


ClearAll[toXYZ,toBLH,deleteClose];


If[SameQ[JavaLink[],Null],InstallJava[]];
AddToClassPath[FileNameJoin[{$HomeDirectory,"xxl","jar"}]];


LoadJavaClass[#]&/@{"xxl.coordinate.CT","xxl.coordinate.NCS","xxl.coordinate.CodeType","java.util.Arrays","xxl.coordinate.GCJ"};


toXYZ[lon_Real,lat_Real]:=JavaBlock[
	Module[{xyz},
	xyz=xxl`coordinate`CT`blh2xyz[
		JavaNew["com.xxl.coordinate.BLH",lon,lat],
		JavaNew["com.xxl.coordinate.XYZ",com`xxl`coordinate`CodeType`THREE]
	];
	{xyz@getX[],xyz@getY[],If[xyz@getCodeType[]==com`xxl`coordinate`CodeType`THREE,3,6],xyz@getCodeNum[]}
]
]


toBLH[x_Real,y_Real,type_/;Or[type==3,type==6],num_Integer]:=JavaBlock[
	Module[{blh},
	blh=com`xxl`coordinate`CT`xyz2blh[
		JavaNew["com.xxl.coordinate.XYZ",com`xxl`coordinate`NCS`WGS84,If[type==3,com`xxl`coordinate`CodeType`THREE,com`xxl`coordinate`CodeType`SIX],num,x,y],
		JavaNew["com.xxl.coordinate.BLH",com`xxl`coordinate`NCS`WGS84]
	];
	{blh@getLongitude[],blh@getLatitude[]}
	]
]


deleteClose[list_List,min_Real,max_Real]:=JavaBlock[
	Module[
	{
		simple="com.xxl.coordinate.m.SimpleXYZ",
		f=JavaNew["com.xxl.coordinate.m.SimpleFunction"],
		src,
		res
	},
	src=java`util`Arrays`asList[
		MakeJavaObject[
			Map[JavaNew[simple,#[[1]],#[[2]],0.0]&,list,{1}]
		]
	];
	res=com`xxl`coordinate`CT`deleteDuplicate[src,f,min,max];
	Map[{#@getX[],#@getY[]}&,res@toArray[],{1}]
	]
];


End[];


EndPackage[];
