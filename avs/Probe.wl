(* ::Package:: *)

BeginPackage["xxl`avs`Probe`"]


libraryVersions::usage="\:5e93\:7684\:7248\:672c"


programVersion::usage="\:7a0b\:5e8f\:7248\:672c"


pixelFormats::usage="\:50cf\:7d20\:683c\:5f0f"


sections::usage="\:6240\:6709\:90e8\:5206"


streams::usage="streams[file] \:97f3\:89c6\:9891\:6587\:4ef6\:7684\:6240\:6709\:6d41"


streamTypes::usage="streamTypes[file] \:6309\:987a\:5e8f\:8fd4\:56de\:6bcf\:4e2a\:6d41\:7684\:4fe1\:606f"


format::usage="format[file] \:6587\:4ef6\:7684\:683c\:5f0f"


packets::usage="packets[file,specifier] \:663e\:793a\:67d0\:4e2a\:6587\:4ef6\:67d0\:4e2a\:6d41\:7684\:6240\:6709\:5305\:4fe1\:606f"


frames::usage="frames[file,specifier] \:663e\:793a\:67d0\:4e2a\:6587\:4ef6\:67d0\:4e2a\:6d41\:7684\:6240\:6709\:5e27\:4fe1\:606f"


packetCount::usage="packetCount[file,specifier] \:6587\:4ef6\:6307\:5b9a\:5305\:7684\:6570\:91cf"


frameCount::usage="frameCount[file,specifier] \:6587\:4ef6\:6307\:5b9a\:5e27\:7684\:6570\:91cf"


Begin["`Private`"]


ffprobeExec=Switch[$OperatingSystem,"Windows","ffprobe.exe","Unix","ffprobe",_,"ffprobe"]


show[item_String,file_String:Null]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-of", "json","-show_"<>item<>If[file===Null,""," "<>file]},"StandardOutput"]/.
in_String:>ImportString[in,"JSON"]/.
in_Rule:>(item/.in)//
First


libraryVersions[]:=xxl`avs`Probe`Private`show["library_versions"]


programVersion[]:=xxl`avs`Probe`Private`show["program_version"]


pixelFormats[]:=xxl`avs`Probe`Private`show["pixel_formats"]


sections[]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-sections","-print_format", "json"},"StandardOutput"]


streams[file_String]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-of" ,"json" ,"-show_streams",file},"StandardOutput"]/.
in_String:>("streams"/.ImportString[in,"JSON"])


streamTypes[file_String]:={"index","codec_type","start_time","duration","nb_frames","codec_tag_string","time_base"}/.xxl`avs`Probe`streams[file]


format[file_String]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-of","json","-show_format",file},"StandardOutput"]/.
in_String:>("format"/.ImportString[in,"JSON"])


packets[file_String,specifier_String]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-of", "json", "-select_streams", specifier, "-show_packets", file},"StandardOutput"]/.
in_String:>("packets"/.ImportString[in,"JSON"])


frames[file_String,specifier_String]:=RunProcess[{xxl`avs`Probe`Private`ffprobeExec,"-of", "json", "-select_streams", specifier, "-show_frames", file},"StandardOutput"]/.
in_String:>("frames"/.ImportString[in,"JSON"])


packetCount[file_String,specifier_String]:=xxl`avs`Probe`packets[file,specifier]//Length


frameCount[file_String,specifier_String]:=xxl`avs`Probe`frames[file,specifier]//Length


End[]


EndPackage[]
