// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
    int courseId;
    String courseTitle;
    String courseSubtitle;
    String courseCategory;
    String courseThumbnail;
    double totalDuration;
    int numberOfVideos;
    double courseProgress;
    int? numberOfUsers;
    List<String>? enrolledUserImages;
    List<SectionModel> sections;

    CourseModel({
        required this.courseId,
        required this.courseTitle,
        required this.courseSubtitle,
        required this.courseCategory,
        required this.courseThumbnail,
        required this.totalDuration,
        required this.numberOfVideos,
        required this.courseProgress,
        this.numberOfUsers,
        this.enrolledUserImages,
        required this.sections,
    });

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["courseId"],
        courseTitle: json["courseTitle"],
        courseSubtitle: json["courseSubtitle"],
        courseCategory: json["courseCategory"],
        courseThumbnail: json["courseThumbnail"],
        totalDuration: json["totalDuration"],
        numberOfVideos: json["numberOfVideos"],
        courseProgress: json["courseProgress"]?.toDouble(),
        numberOfUsers: json["numberOfUsers"],
        enrolledUserImages: List<String>.from(json["enrolledUserImages"].map((x) => x)),
        sections: List<SectionModel>.from(json["sections"].map((x) => SectionModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseTitle": courseTitle,
        "courseSubtitle": courseSubtitle,
        "courseCategory": courseCategory,
        "courseThumbnail": courseThumbnail,
        "totalDuration": totalDuration,
        "numberOfVideos": numberOfVideos,
        "courseProgress": courseProgress,
        "numberOfUsers": numberOfUsers,
        "enrolledUserImages": List<dynamic>.from(enrolledUserImages!.map((x) => x)),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
    };
}

class SectionModel {
    int sectionId;
    String sectionTitle;
    String sectionDescription;
    List<VideoModel> videos;

    SectionModel({
        required this.sectionId,
        required this.sectionTitle,
        required this.sectionDescription,
        required this.videos,
    });

    factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        sectionId: json["sectionId"],
        sectionTitle: json["sectionTitle"],
        sectionDescription: json["sectionDescription"],
        videos: List<VideoModel>.from(json["videos"].map((x) => VideoModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sectionId": sectionId,
        "sectionTitle": sectionTitle,
        "sectionDescription": sectionDescription,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

class VideoModel {
    int videoId;
    String videoTitle;
    String videoDescription;
    String videoUrl;
    String videoThumbnail;
    double videoDuration;
    int lastWatchedPosition;

    VideoModel({
        required this.videoId,
        required this.videoTitle,
        required this.videoDescription,
        required this.videoUrl,
        required this.videoThumbnail,
        required this.videoDuration,
        required this.lastWatchedPosition,
    });

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoId: json["videoId"],
        videoTitle: json["videoTitle"],
        videoDescription: json["videoDescription"],
        videoUrl: json["videoUrl"],
        videoThumbnail: json["videoThumbnail"],
        videoDuration: json["videoDuration"],
        lastWatchedPosition: json["lastWatchedPosition"],
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "videoTitle": videoTitle,
        "videoDescription": videoDescription,
        "videoUrl": videoUrl,
        "videoThumbnail": videoThumbnail,
        "videoDuration": videoDuration,
        "lastWatchedPosition": lastWatchedPosition,
    };
}


