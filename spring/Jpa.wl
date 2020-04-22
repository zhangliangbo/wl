(* ::Package:: *)

BeginPackage["xxl`spring`Jpa`"]


generateBeanAndJpa::usage="generateBeanAndJpa[cls_String]\:751f\:6210Bean\:6587\:4ef6\:548cJpa\:6587\:4ef6";


generateDocAndMongo::usage="generateDocAndMongo[cls_String]\:751f\:6210Doc\:6587\:4ef6\:548cMongo\:6587\:4ef6";


generateQueryBean::usage="generateQueryBean[cls,properties]\:751f\:6210\:67e5\:8be2Bean";


generateCtr::usage="generateCtr[cls]\:751f\:6210\:63a7\:5236\:7c7b";


Begin["`Private`"]


Options[generateBeanAndJpa]={"dir"->$HomeDirectory,"pkg"->"xxl"}


generateBeanAndJpa[cls_String,OptionsPattern[]]:=Module[
	{
		dir=OptionValue["dir"],
		pkg=OptionValue["pkg"],
		beanDir=FileNameJoin[{OptionValue["dir"],"bean"}],
		jpaDir=FileNameJoin[{OptionValue["dir"],"jpa"}],
		beanFile=FileNameJoin[{OptionValue["dir"],"bean",cls<>".java"}],
		jpaFile=FileNameJoin[{OptionValue["dir"],"jpa",cls<>"Jpa.java"}]
	},
	If[!FileExistsQ[beanDir],CreateDirectory[beanDir]];
	If[!FileExistsQ[jpaDir],CreateDirectory[jpaDir]];
	If[
		!FileExistsQ[beanFile],
		Export[beanFile,
		"package "<>pkg<>".bean;

import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@ApiModel
@Setter
@Getter
@ToString
@Entity
public class "<>cls<>" {

  @Id
  @GeneratedValue
  private Long id;
  
}
","Text"]
	];
	If[
		!FileExistsQ[jpaFile],
		Export[jpaFile,
		"package "<>pkg<>".jpa;

import org.springframework.data.jpa.repository.support.JpaRepositoryImplementation;
import org.springframework.stereotype.Repository;
import "<>pkg<>".bean."<>cls<>";

@Repository
public interface "<>cls<>"Jpa extends JpaRepositoryImplementation<"<>cls<>", Long> {

}
","Text"]
	];
	"Done"
]


Options[generateQueryBean]={"dir"->$HomeDirectory,"pkg"->"xxl"}


generateQueryBean[cls_String,properties_List,OptionsPattern[]]:=Module[
	{
		dir=OptionValue["dir"],
		pkg=OptionValue["pkg"],
		filedString=StringRiffle[
		Map["@ApiModelProperty(value = \"\", required = true, example = \"\")
  private String "<>#<>";"&,properties],"\n  "]
	},
	If[!FileExistsQ[dir],CreateDirectory[dir]];
	Export[
		FileNameJoin[{dir,"Q"<>cls<>".java"}],
		"package "<>pkg<>";

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@ApiModel
public class Q"<>cls<>" {

  "<>filedString<>"

}
",
		"Text",
		OverwriteTarget->False
		]
]


Options[generateCtr]={"dir"->$HomeDirectory,"pkg"->"xxl"}


generateCtr[cls_String,OptionsPattern[]]:=Module[
	{
		dir=OptionValue["dir"],
		pkg=OptionValue["pkg"]
	},
	If[!FileExistsQ[dir],CreateDirectory[dir]];
	Export[
		FileNameJoin[{dir,cls<>"Ctr.java"}],
		"package "<>pkg<>";

import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = \"\")
@RestController
@RequestMapping(value = \"\")
public class "<>cls<>"Ctr {
  
}
","Text"]
	
]


Options[generateDocAndMongo]={"dir"->$HomeDirectory,"pkg"->"xxl"}


generateDocAndMongo[cls_String,OptionsPattern[]]:=Module[
	{
		dir=OptionValue["dir"],
		pkg=OptionValue["pkg"],
		docDir=FileNameJoin[{OptionValue["dir"],"doc"}],
		mongoDir=FileNameJoin[{OptionValue["dir"],"mongo"}],
		docFile=FileNameJoin[{OptionValue["dir"],"doc",cls<>".java"}],
		mongoFile=FileNameJoin[{OptionValue["dir"],"mongo",cls<>"Mongo.java"}]
	},
	If[!FileExistsQ[docDir],CreateDirectory[docDir]];
	If[!FileExistsQ[mongoDir],CreateDirectory[mongoDir]];
	If[
		!FileExistsQ[docFile],
		Export[docFile,
		"package "<>pkg<>".doc;

import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@ApiModel
@Setter
@Getter
@ToString
@Document
public class "<>cls<>" {

  @Id
  private String id;
  
}
","Text"]
	];
	If[
		!FileExistsQ[mongoFile],
		Export[mongoFile,
		"package "<>pkg<>".mongo;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import "<>pkg<>".doc."<>cls<>";

@Repository
public interface "<>cls<>"Mongo extends MongoRepository<"<>cls<>", String> {

}
","Text"]
	];
	"Done"
]


End[]


EndPackage[]
