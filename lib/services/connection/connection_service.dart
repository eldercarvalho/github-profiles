abstract class ConnectionService {
  Stream<bool> get connectionChange;
  void dispose();
  Future<bool> checkConnection();
}
