import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:github_profiles/core/core.dart';

import 'github_api.dart';


const baseUrl = "https://api.github.com";
const token = "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";

final _random = Random();

class GitHubApiImpl implements GitHubApi {
  Future<dynamic> _request(String resource) async {
    var response = await http.get(
      Uri.parse("$baseUrl/$resource"),
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw const NotFoundException();
      default:
        throw const ServerException();
    }
  }

  int _next() => 2000 + _random.nextInt(15000);

  @override
  Future<List<Map<String, dynamic>>> getUserRepositories(
      String userLoginId) async {
    List<dynamic> userReposList =
        await _request('users/$userLoginId/repos?per_page=250');
    return userReposList
        .map((user) => Map<String, dynamic>.from(user))
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserOrganisations(
      String userLoginId) async {
    List<dynamic> userOrgsList =
        await _request('users/$userLoginId/orgs?per_page=250');
    return userOrgsList.map((user) => Map<String, dynamic>.from(user)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getOrganisationsRepositories(
      String orgLoginId) async {
    List<dynamic> orgReposList =
        await _request('orgs/$orgLoginId/repos?per_page=250');
    return orgReposList.map((user) => Map<String, dynamic>.from(user)).toList();
  }

  @override
  Future<Map<String, dynamic>> getUserInformation(String userLoginId) async {
    var userInfo = await _request('users/$userLoginId');
    return Map<String, dynamic>.from(userInfo);
  }

  @override
  Future<List<Map<String, dynamic>>> getRandomUsers() async {
    List<dynamic> usersList = await _request('users?since=${_next()}');
    return usersList.map((user) => Map<String, dynamic>.from(user)).toList();
  }
}
