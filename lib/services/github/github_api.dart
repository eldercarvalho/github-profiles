abstract class GitHubApi {
  Future<List<Map<String, dynamic>>> getUserRepositories(
    String userLoginId,
  );

  Future<List<Map<String, dynamic>>> getUserOrganisations(
    String userLoginId,
  );

  Future<List<Map<String, dynamic>>> getOrganisationsRepositories(
    String orgLoginId,
  );

  Future<Map<String, dynamic>> getUserInformation(
    String userLoginId,
  );

  Future<List<Map<String, dynamic>>> getRandomUsers();
}
