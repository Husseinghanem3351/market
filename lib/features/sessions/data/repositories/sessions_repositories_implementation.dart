import 'package:market/features/sessions/data/models/sessions_model.dart';

import '../../domain/repositories/sessions_repositories.dart';
import '../data_sources/sessions_local_data_sources.dart';

class SessionsRepositoriesImplementation extends SessionsRepositories {
  SessionsLocalDataSources sessionsLocalDataSources =
      SessionsLocalDataSourcesImplementation();

  @override
  Future<void> addSession(SessionsModel sessionsModel) async {
    sessionsLocalDataSources.addSession(sessionsModel);
  }

  @override
  Future<void> deleteSessions(int id) async{
   sessionsLocalDataSources.deleteSession(id);
  }

  @override
  Future<void> getSessions() async{
    sessionsLocalDataSources.getSessions();
  }

  @override
  Future<void> updateSession(SessionsModel sessionsModel) async {
    sessionsLocalDataSources.updateSession(sessionsModel);
  }
}
