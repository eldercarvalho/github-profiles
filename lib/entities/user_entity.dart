import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final String? twitterUsername;
  final int? publicRepos;
  final int? followers;
  final int? following;
  final String? createdAt;

  const UserEntity({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.twitterUsername,
    this.publicRepos,
    this.followers,
    this.following,
    this.createdAt,
  });

  bool get hasName => name != null;
  bool get hasBlog => blog != null;
  bool get hasLocation => name != null;
  bool get hasEmail => email != null;
  bool get hasBio => bio != null;
  bool get hasTwitterUsername => twitterUsername != null;
  bool get hasPublicRepos => publicRepos != null;
  bool get hasFollowers => followers != null;
  bool get hasFollowing => following != null;
  bool get hasCreatedAt => createdAt != null;

  String? get readableCreatedAt {
    if (hasCreatedAt) {
      final date = DateTime.parse(createdAt!);
      return DateFormat.yMEd().format(date);
    }
    return null;
  }

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