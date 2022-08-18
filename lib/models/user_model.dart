import 'package:github_profiles/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.login,
    required super.id,
    required super.nodeId,
    required super.avatarUrl,
    required super.gravatarId,
    required super.url,
    required super.htmlUrl,
    required super.followersUrl,
    required super.followingUrl,
    required super.gistsUrl,
    required super.starredUrl,
    required super.subscriptionsUrl,
    required super.organizationsUrl,
    required super.reposUrl,
    required super.eventsUrl,
    required super.receivedEventsUrl,
    required super.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json["login"],
      id: json["id"],
      nodeId: json["node_id"],
      avatarUrl: json["avatar_url"],
      gravatarId: json["gravatar_id"],
      url: json["url"],
      htmlUrl: json["html_url"],
      followersUrl: json["followers_url"],
      followingUrl: json["following_url"],
      gistsUrl: json["gists_url"],
      starredUrl: json["starred_url"],
      subscriptionsUrl: json["subscriptions_url"],
      organizationsUrl: json["organizations_url"],
      reposUrl: json["repos_url"],
      eventsUrl: json["events_url"],
      receivedEventsUrl: json["received_events_url"],
      type: json["type"],
    );
  }
}
