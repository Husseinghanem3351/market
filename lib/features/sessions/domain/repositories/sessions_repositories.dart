import '../../data/models/sessions_model.dart';

abstract class SessionsRepositories {
  Future<void> addSession(SessionsModel sessionsModel);

  Future<void> updateSession(SessionsModel sessionsModel);

  Future<void> deleteSessions(int id);

  Future<void> getSessions();
}
