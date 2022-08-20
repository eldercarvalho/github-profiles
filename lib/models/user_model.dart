import 'package:github_profiles/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.login,
    required super.id,
    required super.avatarUrl,
    super.name,
    super.company,
    super.blog,
    super.location,
    super.email,
    super.bio,
    super.twitterUsername,
    super.publicRepos,
    super.followers,
    super.following,
    super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json["login"],
      id: json["id"],
      avatarUrl: json["avatar_url"],
      name: json["name"],
      company: json["company"],
      blog: json["blog"],
      location: json["location"],
      email: json["email"],
      bio: json["bio"],
      twitterUsername: json["twitter_username"],
      publicRepos: json["public_repos"],
      followers: json["followers"],
      following: json["following"],
      createdAt: json["created_at"],
    );
  }
}
