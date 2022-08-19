import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/repositories/users/user_repository.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;
  final ContactsService contactsService;
  List<UserEntity> _cachedUsers = [];
  late Timer _timer;

  final StreamController<DateTime> _controller = StreamController();
  Stream<DateTime> get updateTime => _controller.stream;

  HomeCubit({
    required this.userRepository,
    required this.contactsService,
  }) : super(HomeInitialState()) {
    _timer = Timer.periodic(
      const Duration(seconds: 15),
      (timer) => _controller.add(DateTime.now()),
    );
  }

  void fetchUsers({bool cached = false}) async {
    emit(HomeLoadingState());

    if (cached) {
      emit(HomeSuccessState(users: _cachedUsers));
      return;
    }

    final usersEither = await userRepository.getUsers();

    usersEither.fold(
      (failure) => emit(HomeFailureState(failure: failure)),
      (users) {
        _cachedUsers = users;
        emit(HomeSuccessState(users: users));
      },
    );
  }

  void fetchUserInfo(String userLoginId) async {
    emit(HomeLoadingState());
    final userEither = await userRepository.getUserInfo(userLoginId);

    userEither.fold(
      (failure) => emit(HomeFailureState(failure: failure)),
      (user) => emit(HomeSuccessState(users: [user])),
    );
  }

  Future<void> fetchContacts() async {
    final contacts = await contactsService.fetchContacts();
    fetchUsers();
    emit(HomeContactsState(contacts: contacts));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    _controller.close();
    return super.close();
  }
}
