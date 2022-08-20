import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final String? twitterUsername;
  final int publicRepos;
  final int followers;
  final int following;
  final String createdAt;

  const UserEntity({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.twitterUsername,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  bool get hasName => name != null;

  bool get hasCompany => company != null && company!.isNotEmpty;

  bool get hasBlog => blog != null && blog!.isNotEmpty;

  bool get hasLocation => location != null && location!.isNotEmpty;

  bool get hasEmail => email != null && email!.isNotEmpty;

  bool get hasBio => bio != null && bio!.isNotEmpty;

  bool get hasTwitterUsername => twitterUsername != null;

  bool get hasCreatedAt => createdAt.isNotEmpty;

  String? get readableCreatedAt {
    if (hasCreatedAt) {
      final date = DateTime.parse(createdAt);
      return DateFormat.y().format(date);
    }
    return null;
  }

  @override
  List<Object?> get props => [id, login];
}
