// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:iba_resources_app/models/reward.dart';

class RewardLevelModel {
  const RewardLevelModel({
    required this.rewardLevel,
    required this.rewardLevelPoints,
    required this.rewardsList,
  });

  final int rewardLevel;
  final int rewardLevelPoints;
  final List<RewardModel> rewardsList;

  RewardLevelModel copyWith({
    int? rewardLevel,
    int? rewardLevelPoints,
    List<RewardModel>? rewardsList,
  }) {
    return RewardLevelModel(
      rewardLevel: rewardLevel ?? this.rewardLevel,
      rewardLevelPoints: rewardLevelPoints ?? this.rewardLevelPoints,
      rewardsList: rewardsList ?? this.rewardsList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rewardLevel': rewardLevel,
      'rewardLevelPoints': rewardLevelPoints,
      'rewardsList': rewardsList.map((x) => x.toMap()).toList(),
    };
  }

  factory RewardLevelModel.fromMap(Map<String, dynamic> map) {
    return RewardLevelModel(
      rewardLevel: map['rewardLevel'] as int,
      rewardLevelPoints: map['rewardLevelPoints'] as int,
      rewardsList: List<RewardModel>.from(
        (map['rewardsList']).map<RewardModel>(
          (x) => RewardModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardLevelModel.fromJson(String source) =>
      RewardLevelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
