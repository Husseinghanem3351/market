
import 'package:market/features/rewards/data/models/rewards_model.dart';
import 'package:market/global/database.dart';

// each sale has one product invoice number
// each invoice has just id and dateTime
// so we get invoices, and then for each invoice we will get products

abstract class RewardsLocalDataSources {
  Future<void> addReward(RewardsModel rewardModel);

  Future<List<RewardsModel>?> getRewards();

  Future<void> deleteReward(int id);

  Future<void> updateReward(RewardsModel rewardModel);
}

class RewardsLocalDataSourcesImplementation implements RewardsLocalDataSources {
  @override
  Future<void> addReward(RewardsModel rewardModel) async {
    try {
      database.transaction(
        (txn) => txn.insert(
          'rewards',
          rewardModel.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteReward(int id) async {
    try {
      database.rawDelete(
        'delete from rewards where id =$id',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<RewardsModel>?> getRewards() async {
    try {
      final value = await database
          .rawQuery('select * from rewards');
      return value.map<RewardsModel>((e) => RewardsModel.fromJson(e)).toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updateReward(RewardsModel rewardModel) async {
    try {
      database.rawUpdate('update rewards set '
          'description=${rewardModel.description}'
          'where id=${rewardModel.id}');
    } catch (error) {
      print(error);
    }
  }
}
