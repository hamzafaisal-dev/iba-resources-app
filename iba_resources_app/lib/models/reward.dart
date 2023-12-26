// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RewardModel {
  const RewardModel({
    required this.rewardName,
    required this.rewardPoints,
  });

  final String rewardName;
  final int rewardPoints;

  RewardModel copyWith({
    String? rewardName,
    int? rewardPoints,
  }) {
    return RewardModel(
      rewardName: rewardName ?? this.rewardName,
      rewardPoints: rewardPoints ?? this.rewardPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rewardName': rewardName,
      'rewardPoints': rewardPoints,
    };
  }

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    return RewardModel(
      rewardName: map['rewardName'] as String,
      rewardPoints: map['rewardPoints'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardModel.fromJson(String source) =>
      RewardModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
