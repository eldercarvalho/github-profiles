import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/repositories/repos/repo_repository.dart';

import 'repos_state.dart';

class ReposCubit extends Cubit<ReposState> {
  final RepoRepository repoRepository;

  ReposCubit({required this.repoRepository}) : super(InitialState());

  void fetchRepos(String userLoginId) async {
    emit(LoadingState());
    final resultEither = await repoRepository.getReposByUserLogin(userLoginId);

    resultEither.fold(
      (failure) => emit(FailureState(failure: failure)),
      (repos) => emit(SuccessState(repos: repos)),
    );
  }
}
