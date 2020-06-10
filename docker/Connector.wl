(* ::Package:: *)

BeginPackage["xxl`docker`Connector`"]


containerId::usage="containerId[image] \:6839\:636e\:955c\:50cf\:83b7\:53d6\:5bb9\:5668ID"


redisCli::usage="redisCli[] \:6253\:5f00redis\:63a7\:5236\:53f0"


mongoCli::usage="mongoCli[] \:9ed8\:8ba4\:5bc6\:7801\nmongoCli[user,pwd] \:4f7f\:7528\:7528\:6237\:540d\:548c\:5bc6\:7801"


mysqlCli::usage="mysqlCli[] \:9ed8\:8ba4\:5bc6\:7801\nmysqlCli[user,pwd] \:4f7f\:7528\:7528\:6237\:540d\:548c\:5bc6\:7801"


Begin["`Private`"]


dockerExec[]=Switch[$OperatingSystem,"Windows","docker.exe","Unix","docker",_,"docker"]


containerId[image_String]:=RunProcess[{xxl`docker`Connector`Private`dockerExec[],"container","ls"},"StandardOutput"]/.
in_String:>StringCases[in,"\n"~~x:WordCharacter..~~Whitespace~~image<>":":>x]/.
in_String:>RunProcess[{"docker.exe","inspect",in},"StandardOutput"]/.
in_String:>StringCases[in,"Id\": \""~~Shortest[x__]~~"\"":>x]//Flatten//First


redisCli[]:=xxl`docker`Connector`containerId["redis"]/.
in_String:>Run[xxl`docker`Connector`Private`dockerExec[]<>" exec -it "<>in<>" redis-cli"]


mongoCli[user_String,pwd_String]:=xxl`docker`Connector`containerId["mongo"]/.
in_String:>Run[xxl`docker`Connector`Private`dockerExec[]<>" exec -it "<>in<>" mongo -u "<>user<>" -p "<>pwd]


mongoCli[]:=xxl`docker`Connector`mongoCli["root","civic"]


mysqlCli[user_String,pwd_String]:=xxl`docker`Connector`containerId["mysql"]/.
in_String:>Run[xxl`docker`Connector`Private`dockerExec[]<>" exec -it "<>in<>" mysql -u "<>user<>" -p"<>pwd]


mysqlCli[]:=xxl`docker`Connector`mysqlCli["root","civic"]


End[]


EndPackage[]
