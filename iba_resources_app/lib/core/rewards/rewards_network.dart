import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/reward.dart';
import 'package:iba_resources_app/models/reward_level.dart';

class RewardFirestoreClient {
  final FirebaseFirestore firestore;
  RewardFirestoreClient({required this.firestore});

  Future<List<RewardLevelModel>> getAllRewards() async {
    // fetches all documents in the resources collection
    final rewards = await firestore.collection('rewardLevels').get();

    // rew.docs returns a list of QueryDocumentSnapshot
    // maps over the list, converts each document into a Resource, returns list of Resources
    List<RewardLevelModel> allFetchedRewards = rewards.docs.map((docSnapshot) {
      print(docSnapshot.data());
      return RewardLevelModel.fromMap(docSnapshot.data());
    }).toList();

    print(allFetchedRewards);

    return allFetchedRewards;
  }
}
