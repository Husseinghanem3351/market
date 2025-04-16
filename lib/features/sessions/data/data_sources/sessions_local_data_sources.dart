import 'package:market/global/database.dart';

import '../models/sessions_model.dart';

// each sale has one product invoice number
// each invoice has just id and dateTime
// so we get invoices, and then for each invoice we will get products

abstract class SessionsLocalDataSources {
  Future<void> addSession(SessionsModel sessionModel);

  Future<List<SessionsModel>?> getSessions();

  Future<void> deleteSession(int id);

  Future<void> updateSession(SessionsModel sessionModel);
}

class SessionsLocalDataSourcesImplementation
    implements SessionsLocalDataSources {
  @override
  Future<void> addSession(SessionsModel sessionsModel) async {
    try {
      database.transaction(
        (txn) => txn.insert(
          'sessions',
          sessionsModel.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteSession(int id) async {
    try {
      database.rawDelete(
        'delete from sessions where id =$id',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<SessionsModel>?> getSessions() async {
    try {
      final value = await database.rawQuery('select * from sessions');
      return value
          .map<SessionsModel>((e) => SessionsModel.fromJson(e))
          .toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updateSession(SessionsModel sessionModel) async {
    try {
      database.rawUpdate('update sessions set '
          'buyingAmount=${sessionModel.buyingAmount},'
          'sellingAmount=${sessionModel.sellingAmount}'
          'where id=${sessionModel.id}');
    } catch (error) {
      print(error);
    }
  }
}
