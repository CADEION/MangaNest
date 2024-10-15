// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    Message? message;

    HomeModel({
        this.message,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
    };
}

class Message {
    String? type;
    String? service;
    String? version;
    Result? result;

    Message({
        this.type,
        this.service,
        this.version,
        this.result,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: json["type"],
        service: json["service"],
        version: json["version"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "service": service,
        "version": version,
        "result": result?.toJson(),
    };
}

class Result {
    GenreTabList? genreTabList;

    Result({
        this.genreTabList,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        genreTabList: json["genreTabList"] == null ? null : GenreTabList.fromJson(json["genreTabList"]),
    );

    Map<String, dynamic> toJson() => {
        "genreTabList": genreTabList?.toJson(),
    };
}

class GenreTabList {
    List<GenreTab>? genreTabs;
    int? count;

    GenreTabList({
        this.genreTabs,
        this.count,
    });

    factory GenreTabList.fromJson(Map<String, dynamic> json) => GenreTabList(
        genreTabs: json["genreTabs"] == null ? [] : List<GenreTab>.from(json["genreTabs"]!.map((x) => GenreTab.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "genreTabs": genreTabs == null ? [] : List<dynamic>.from(genreTabs!.map((x) => x.toJson())),
        "count": count,
    };
}

class GenreTab {
    String? name;
    int? index;
    String? iconImage;
    String? code;

    GenreTab({
        this.name,
        this.index,
        this.iconImage,
        this.code,
    });

    factory GenreTab.fromJson(Map<String, dynamic> json) => GenreTab(
        name: json["name"],
        index: json["index"],
        iconImage: json["iconImage"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "index": index,
        "iconImage": iconImage,
        "code": code,
    };
}
