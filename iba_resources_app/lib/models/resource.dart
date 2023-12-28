// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ResourceModel {
  const ResourceModel({
    required this.resourceId,
    required this.resourceTitle,
    required this.resourceFiles,
    required this.resourceDescription,
    required this.resourceType,
    required this.uploader,
    required this.uploaderAvatar,
    required this.courseName,
    required this.teacherName,
    required this.relevantFields,
    required this.semester,
    required this.year,
    required this.likes,
    required this.dislikes,
    required this.reportCount,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String resourceId;

  final String resourceTitle;
  final String uploader;
  final String uploaderAvatar;

  final String teacherName;
  final String courseName;

  final String resourceDescription;
  final String resourceType;

  final List<dynamic>? resourceFiles;

  final List<dynamic>? relevantFields;
  final String semester;
  final String year;

  final int likes;
  final int dislikes;
  final int reportCount;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  factory ResourceModel.fromJson(Map<String, dynamic> resourceData) {
    return ResourceModel(
      resourceId: resourceData['resourceId'],
      resourceTitle: resourceData['resourceTitle'],
      resourceFiles: resourceData['resourceFiles'],
      resourceDescription: resourceData['resourceDescription'],
      resourceType: resourceData['resourceType'],
      uploader: resourceData['uploader'],
      uploaderAvatar: resourceData['uploaderAvatar'],
      teacherName: resourceData['teacherName'],
      courseName: resourceData['courseName'],
      relevantFields: resourceData['relevantFields'],
      semester: resourceData['semester'],
      year: resourceData['year'],

      likes: resourceData['likes'],
      dislikes: resourceData['dislikes'],
      reportCount: resourceData['reportCount'],

      isActive: resourceData['isActive'],
      isDeleted: resourceData['isDeleted'],

      // firestore converts DateTime to Timestamps, so we need to convert it back to DateTime upon fetching
      createdAt: (resourceData['createdAt'] as Timestamp).toDate(),
      updatedAt: (resourceData['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'resourceId': resourceId,
      'resourceTitle': resourceTitle,
      'uploader': uploader,
      'uploaderAvatar': uploaderAvatar,
      'teacherName': teacherName,
      'courseName': courseName,
      'resourceDescription': resourceDescription,
      'resourceType': resourceType,
      'resourceFiles': resourceFiles,
      'relevantFields': relevantFields,
      'semester': semester,
      'year': year,
      'likes': likes,
      'dislikes': dislikes,
      'reportCount': reportCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  ResourceModel copyWith({
    String? resourceId,
    String? resourceTitle,
    String? uploader,
    String? uploaderAvatar,
    String? teacherName,
    String? courseName,
    String? resourceDescription,
    String? resourceType,
    List<dynamic>? resourceFiles,
    List<dynamic>? relevantFields,
    String? semester,
    String? year,
    int? likes,
    int? dislikes,
    int? reportCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return ResourceModel(
      resourceId: resourceId ?? this.resourceId,
      resourceTitle: resourceTitle ?? this.resourceTitle,
      uploader: uploader ?? this.uploader,
      uploaderAvatar: uploaderAvatar ?? this.uploaderAvatar,
      teacherName: teacherName ?? this.teacherName,
      courseName: courseName ?? this.courseName,
      resourceDescription: resourceDescription ?? this.resourceDescription,
      resourceType: resourceType ?? this.resourceType,
      resourceFiles: resourceFiles ?? this.resourceFiles,
      relevantFields: relevantFields ?? this.relevantFields,
      semester: semester ?? this.semester,
      year: year ?? this.year,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      reportCount: reportCount ?? this.reportCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
