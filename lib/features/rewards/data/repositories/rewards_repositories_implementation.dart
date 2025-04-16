import 'package:market/features/rewards/data/data_sources/rewards_local_data_sources.dart';
import 'package:market/features/rewards/data/models/rewards_model.dart';

import '../../domain/repositories/rewards_repositories.dart';

class RewardsRepositoriesImplementation extends RewardsRepositories {
  RewardsLocalDataSources rewardsLocalDataSources =
      RewardsLocalDataSourcesImplementation();

  @override
  Future<void> addReward(RewardsModel rewardModel) async {
    rewardsLocalDataSources.addReward(rewardModel);
  }

  @override
  Future<void> deleteReward(int id) async {
    rewardsLocalDataSources.deleteReward(id);
  }

  @override
  Future<void> getRewards() async {
    rewardsLocalDataSources.getRewards();
  }

  @override
  Future<void> updateReward(RewardsModel rewardModel) async {
    rewardsLocalDataSources.updateReward(rewardModel);
  }
}
