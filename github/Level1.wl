(* ::Package:: *)

BeginPackage["xxl`github`Level1`",{"JLink`","xxl`github`Level0`"}]


dataSource::usage="dataSource[url,username,password] \:6570\:636e\:6e90"


dataSource::usage="dataSource[url,username,password,sshHost,sshPort,sshUser,sshPwd] \:5e26\:8df3\:677f\:7684\:6570\:636e\:6e90"


sqlSelect::usage="sqlSelect[sql,params] \:9009\:62e9"


sqlUpdate::usage="sqlUpdate[sql,params] \:66f4\:65b0"


sqlDatabases::usage="sqlDatabases[] \:5217\:51fa\:6570\:636e\:5e93"


sqlTables::usage="sqlTables[database] \:5217\:51fa\:8868\:683c"


sqlColumns::usage="sqlColumns[database,table] \:8868\:683c\:5143\:4fe1\:606f"


sqlBatch::usage="sqlBatch[sql,params] \:6279\:91cf\:4fee\:6539"


myBatisPlusGenerate::usage="myBatisPlusGenerate[tables] \:751f\:6210mybatis plus\:4fe1\:606f"


redisSource::usage="redisSource[uri]\:8bbe\:7f6eredis\:6e90"


redisMemory::usage="redisMemory[key]\:67e5\:8be2\:5185\:5b58\:5927\:5c0f"


redisSet::usage="redisStringSet[key,value]\:8bbe\:7f6e"


redisGet::usage="redisStringGet[key]\:83b7\:53d6"


redisScan::usage="redisStringScan[patten]\:626b\:63cf"


redisKeys::usage="redisKeys[patten]\:626b\:63cf"


redisDelete::usage="redisDelete[keys]\:5220\:9664\:952e"


redisPipelineSet::usage="redisPipelineSet[kvs]pipeline\:8bbe\:7f6e\:591a\:4e2a\:952e"


redisPipelineGet::usage="redisPipelineGet[kvs]pipeline\:83b7\:53d6\:591a\:4e2a\:952e"


redisMSet::usage="redisMSet[kvs]\:8bbe\:7f6e\:591a\:4e2a\:952e"


redisMGet::usage="redisMGet[keys]\:83b7\:53d6\:591a\:4e2a\:952e"


redisHashKeys::usage="redisHashKeys[key]\:83b7\:53d6hash\:8868\:7684\:6240\:6709\:952e"


redisHashLen::usage="redisHashLen[key]\:83b7\:53d6hash\:8868\:7684\:5927\:5c0f"


redisHashMSet::usage="redisHashPut[key,hashKey,hashValue]\:653e\:5165hash\:8868\:6570\:636e"


redisHashMGet::usage="redisHashGet[key,hashKey]\:83b7\:53d6hash\:8868\:7684\:6570\:636e"


redisHashDel::usage="redisHashDel[key,hashKey]\:5220\:9664\:591a\:4e2a\:952e"


redisHashScan::usage="redisHashScan[key,patten]hash\:6a21\:7cca\:5339\:914d"


redisExpire::usage="redisExpire[key,expire]\:8bbe\:7f6e\:8fc7\:671f\:65f6\:95f4"


redisTtl::usage="redisTtl[key]\:83b7\:53d6\:8fc7\:671f\:65f6\:95f4"


redisSetAdd::usage="redisSetAdd[key,values]\:5f80\:96c6\:5408\:6dfb\:52a0\:6570\:636e"


redisSetMembers::usage="redisSetMembers[key]\:83b7\:53d6\:96c6\:5408\:7684\:6570\:636e"


redisSetRemove::usage="redisSetRemove[key,values]\:79fb\:9664\:96c6\:5408\:7684\:6570\:636e"


redisSetCard::usage="redisSetCard[key]\:96c6\:5408\:5927\:5c0f"


redisSetDiff::usage="redisSetDiff[keys]\:8865\:96c6"


redisSetUnion::usage="redisSetUnion[keys]\:5e76\:96c6"


redisSetUnionStore::usage="redisSetUnionStore[dstKey,keys]\:5e76\:96c6\:8f6c\:5b58"


redisSetInter::usage="redisSetInter[keys]\:4ea4\:96c6"


redisSetScan::usage="redisSetScan[key,pattern]set\:6a21\:7cca\:5339\:914d"


redisSetRandom::usage="redisSetRandom[key,count]set\:968f\:673a\:6210\:5458"


redisListLen::usage="redisListLen[key]list\:5927\:5c0f"


redisListRange::usage="redisListRange[key,start,stop]list\:7684\:503c"


redisListIndex::usage="redisListIndex[key,index]list\:6307\:5b9a\:4f4d\:7f6e\:7684\:503c"


redisListPosition::usage="redisListPosition[key,pattern]list\:6307\:5b9a\:503c\:7684\:4f4d\:7f6e"


Begin["`Private`"]


JLink`AddToClassPath["D:\\level\\level1\\build\\libs\\level1-1.0.0-all.jar"];


JLink`LoadJavaClass[#]&/@
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


If[FreeQ[LoadedJavaClasses[],JavaClass[#,___]],LoadJavaClass[#]]&/@
	{"xxl.redis.RedisSource","xxl.redis.RedisString","xxl.redis.RedisHash","xxl.redis.RedisSet","xxl.redis.RedisList"};


ClearAll[redisSource]


redisSource[uri_String]:=xxl`redis`RedisSource`use[uri]


redisSource[uri_String,password_String]:=xxl`redis`RedisSource`use[uri,password]


redisSource[uri_String,password_String,sshHost_String,sshPort_Integer,sshUser_String,sshPwd_String]:=
	xxl`redis`RedisSource`use[uri,password,sshHost,JLink`MakeJavaObject[sshPort],sshUser,sshPwd]


ClearAll[redisMemory]


redisMemory[key_String]:=xxl`redis`RedisString`memory[key]


ClearAll[redisSet]


redisSet[key_String,value_String]:=xxl`redis`RedisString`set[key,value]


ClearAll[redisGet]


redisGet[key_String]:=xxl`redis`RedisString`get[key]


ClearAll[redisScan]


redisScan[patten_String]:=xxl`redis`RedisString`scan[patten]//JLink`JavaObjectToExpression


redisScan[patten_String,count_Integer]:=xxl`redis`RedisString`scan[patten,count]//JLink`JavaObjectToExpression


ClearAll[redisKeys]


redisKeys[patten_String]:=xxl`redis`RedisString`keys[patten]//JLink`JavaObjectToExpression


ClearAll[redisDelete]


redisDelete[keys_List]:=xxl`redis`RedisString`delete[Map[ToString,keys,{1}]]


redisDelete[keys_List,size_Integer]:=Map[redisDelete[#]&,Partition[keys,UpTo[size]],{1}]


ClearAll[redisPipelineSet]


redisPipelineSet[kvs_List]:=xxl`redis`RedisString`pipelineSet[Map[ToString,kvs//Flatten,{1}]]


ClearAll[redisPipelineGet]


redisPipelineGet[keys_List]:=xxl`redis`RedisString`pipelineGet[Map[ToString,keys,{1}]]//JLink`JavaObjectToExpression


ClearAll[redisMSet]


redisMSet[kvs_List]:=xxl`redis`RedisString`mSet[Map[ToString,kvs//Flatten,{1}]]


ClearAll[redisMGet]


redisMGet[keys_List]:=xxl`redis`RedisString`mGet[Map[ToString,keys,{1}]]//JLink`JavaObjectToExpression


ClearAll[redisHashKeys]


redisHashKeys[key_String]:=xxl`redis`RedisHash`keys[key]//JLink`JavaObjectToExpression


ClearAll[redisHashLen]


redisHashLen[key_String]:=xxl`redis`RedisHash`len[key]


ClearAll[redisHashMSet]


redisHashMSet[key_String,kvs_]:=xxl`redis`RedisHash`mSet[key,kvs]


ClearAll[redisHashMGet]


redisHashMGet[key_String,hashKey_]:=xxl`redis`RedisHash`mGet[key,hashKey]//JLink`JavaObjectToExpression


ClearAll[redisHashDel]


redisHashDel[key_String,hashKey_]:=xxl`redis`RedisHash`del[key,hashKey]


ClearAll[redisHashScan]


redisHashScan[key_String,pattern_String]:=xxl`redis`RedisHash`scan[key,pattern]//JLink`JavaObjectToExpression


redisHashScan[key_String,pattern_String,count_Integer]:=xxl`redis`RedisHash`scan[key,pattern,count]//JLink`JavaObjectToExpression


ClearAll[redisExpire]


redisExpire[key_String,expire_Integer]:=xxl`redis`RedisString`expire[key,expire]


ClearAll[redisTtl]


redisTtl[key_String]:=xxl`redis`RedisString`ttl[key]


ClearAll[redisSetAdd]


redisSetAdd[key_String,values_]:=xxl`redis`RedisSet`add[key,values]


ClearAll[redisSetMembers]


redisSetMembers[key_String]:=xxl`redis`RedisSet`members[key]//JLink`JavaObjectToExpression


ClearAll[redisSetRemove]


redisSetRemove[key_String,values_]:=xxl`redis`RedisSet`remove[key,values]


ClearAll[redisSetCard]


redisSetCard[key_String]:=xxl`redis`RedisSet`card[key]


ClearAll[redisSetDiff]


redisSetDiff[keys_]:=xxl`redis`RedisSet`diff[keys]//JLink`JavaObjectToExpression


ClearAll[redisSetUnion]


redisSetUnion[keys_]:=xxl`redis`RedisSet`union[keys]//JLink`JavaObjectToExpression


ClearAll[redisSetUnionStore]


redisSetUnionStore[dstKey_String,keys_]:=xxl`redis`RedisSet`unionStore[dstKey,keys]


ClearAll[redisSetInter]


redisSetInter[keys_]:=xxl`redis`RedisSet`inter[keys]//JLink`JavaObjectToExpression


ClearAll[redisSetScan]


redisSetScan[key_String,pattern_String]:=xxl`redis`RedisSet`scan[key,pattern]//JLink`JavaObjectToExpression


redisSetScan[key_String,pattern_String,count_Integer]:=xxl`redis`RedisSet`scan[key,pattern,count]//JLink`JavaObjectToExpression


ClearAll[redisSetRandom]


redisSetRandom[key_String,count_Integer]:=xxl`redis`RedisSet`random[key,count]//JLink`JavaObjectToExpression


ClearAll[redisListLen]


redisListLen[key_String]:=xxl`redis`RedisList`len[key]


ClearAll[redisListRange]


redisListRange[key_String,start_Integer,stop_Integer]:=xxl`redis`RedisList`range[key,start,stop]//JLink`JavaObjectToExpression


ClearAll[redisListIndex]


redisListIndex[key_String,index_Integer]:=xxl`redis`RedisList`index[key,index]


ClearAll[redisListPosition];


redisListPosition[key_String,pattern_String]:=Module[
	{len=redisListLen[key],size=1000,page,start,end,pageResult,res={}},
	page=If[Mod[len,size]==0,IntegerPart[len/size],IntegerPart[len/size]+1];
	Do[
		start=(i-1)*size;end=If[i==page,len-1,start+size-1];pageResult=redisListRange[key,start,end];
		Do[
			If[Length[StringCases[pageResult[[j]],pattern]]>0,AppendTo[res,start+j-1]],
			{j,1,Length[pageResult]}
		],
		{i,1,page}
	];

res
]


End[]


EndPackage[]
