(* ::Package:: *)

BeginPackage["xxl`github`Level1`",{"JLink`","xxl`github`Level0`","xxl`cloud`Eureka`"}]


dataSource::usage="dataSource[url,username,password] \:6570\:636e\:6e90"


dataSource::usage="dataSource[url,username,password,sshHost,sshPort,sshUser,sshPwd] \:5e26\:8df3\:677f\:7684\:6570\:636e\:6e90"


sqlSelect::usage="sqlSelect[sql,params] \:9009\:62e9"


sqlUpdate::usage="sqlUpdate[sql,params] \:66f4\:65b0"


sqlDatabases::usage="sqlDatabases[] \:5217\:51fa\:6570\:636e\:5e93"


sqlTables::usage="sqlTables[database] \:5217\:51fa\:8868\:683c"


sqlColumns::usage="sqlColumns[database,table] \:8868\:683c\:5143\:4fe1\:606f"


sqlBatch::usage="sqlBatch[sql,params] \:6279\:91cf\:4fee\:6539"


myBatisPlusGenerate::usage="myBatisPlusGenerate[tables] \:751f\:6210mybatis plus\:4fe1\:606f"


Begin["`Private`"]


If[JLink`JavaLink[]===Null,JLink`InstallJava[]];


JLink`AddToClassPath["D:\\level\\level1\\build\\libs\\level1-1.0.0-all.jar"];


If[FreeQ[LoadedJavaClasses[],JavaClass[#,___]],LoadJavaClass[#]]&/@
	{"xxl.jdbc.JdbcSource","xxl.jdbc.SQLExecute"};


ClearAll[dataSource]


dataSource[url_String,username_String,password_String]:=xxl`jdbc`JdbcSource`use[url,username,password]


dataSource[url_String,username_String,password_String,sshHost_String,sshPort_Integer,sshUser_String,sshPwd_String]:=
	xxl`jdbc`JdbcSource`use[url,username,password,sshHost,JLink`MakeJavaObject[sshPort],sshUser,sshPwd]


ClearAll[sqlSelect]


sqlSelect[sql_String,params_]:=xxl`jdbc`SQLExecute`sqlSelect[sql,Map[MakeJavaObject,params,{1}]]//JLink`JavaObjectToExpression


ClearAll[sqlUpdate]


sqlUpdate[sql_String,params_]:=xxl`jdbc`SQLExecute`sqlUpdate[sql,Map[MakeJavaObject,params,{1}]]//JLink`JavaObjectToExpression


ClearAll[sqlDatabases]


sqlDatabases[]:=xxl`jdbc`SQLExecute`sqlDatabases[]//JLink`JavaObjectToExpression


ClearAll[sqlTables]


sqlTables[database_String]:=xxl`jdbc`SQLExecute`sqlTables[database]//JLink`JavaObjectToExpression


ClearAll[sqlColumns]


sqlColumns[database_String,table_String]:=xxl`jdbc`SQLExecute`sqlColumns[database,table]//JLink`JavaObjectToExpression


sqlColumns[table_String]:=xxl`jdbc`SQLExecute`sqlColumns[MakeJavaObject[Null],table]//JLink`JavaObjectToExpression


ClearAll[sqlBatch]


sqlBatch[sql_String,params_]:=xxl`jdbc`SQLExecute`sqlBatch[sql,Map[MakeJavaObject,params,{2}]]//JLink`JavaObjectToExpression


(*mybatis plus*)


If[FreeQ[LoadedJavaClasses[],JavaClass[#,___]],LoadJavaClass[#]]&/@
	{"xxl.mybatisPlus.Generator"};


ClearAll[myBatisPlusGenerate]


myBatisPlusGenerate[tables_List,OptionsPattern[]]:=xxl`mybatisPlus`Generator`generate[
	OptionValue["author"],
	OptionValue["outputDir"],
	OptionValue["entitySuffix"],
	OptionValue["url"],
	OptionValue["driver"],
	OptionValue["username"],
	OptionValue["password"],
	OptionValue["parent"],
	OptionValue["entity"],
	OptionValue["mapper"],
	OptionValue["xml"],
	OptionValue["service"],
	OptionValue["serviceImpl"],
	OptionValue["controller"],
	OptionValue["tablePrefix"],
	tables
]


Options[myBatisPlusGenerate]={
"author"->"zlb",
"outputDir"->"D:\\codeGen",
"entitySuffix"->"Po",
"url"->"",
"driver"->"com.mysql.cj.jdbc.Driver",
"username"->"",
"password"->"",
"parent"->"",
"entity"->"output",
"mapper"->"output",
"xml"->"output",
"service"->"output",
"serviceImpl"->"output",
"controller"->"output",
"tablePrefix"->"cs_"
};


End[]


EndPackage[]
