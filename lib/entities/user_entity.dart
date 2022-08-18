import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final String name;

  const UserEntity({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.name,
  });

  @override
  List<Object?> get props => [id, login];
}


// "name": "monalisa octocat",
//   "company": "GitHub",
//   "blog": "https://github.com/blog",
//   "location": "San Francisco",
//   "email": "octocat@github.com",
//   "hireable": false,
//   "bio": "There once was...",
//   "twitter_username": "monatheoctocat",
//   "public_repos": 2,
//   "public_gists": 1,
//   "followers": 20,
//   "following": 0,
//   "created_at": "2008-01-14T04:33:35Z",
//   "updated_at": "2008-01-14T04:33:35Z",
//   "private_gists": 81,
//   "total_private_repos": 100,
//   "owned_private_repos": 100,