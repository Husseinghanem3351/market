import '../../data/models/rewards_model.dart';

abstract class RewardsRepositories {
  Future<void> addReward(RewardsModel rewardModel);

  Future<void> updateReward(RewardsModel rewardModel);

  Future<void> deleteReward(int id);

  Future<void> getRewards();
}
