import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';

import 'cubit/cubit.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeCubit = getIt<HomeCubit>();
  List<AppContact>? _contacts;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _homeCubit.fetchContacts();
      _homeCubit.updateTime.listen((event) => _homeCubit.fetchUsers());
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => _homeCubit,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: BlocConsumer<HomeCubit, HomeState>(
          bloc: _homeCubit,
          listener: (context, state) {
            if (state is HomeContactsState) {
              setState(() => _contacts = state.contacts);
              // _homeCubit.fetchUsers();
            }
          },
          buildWhen: (oldState, state) => state is! HomeContactsState,
          builder: (context, state) {
            if (state is HomeSuccessState) {
              return HomeUsersList(
                users: state.users,
                contacts: _contacts,
              );
            }

            if (state is HomeFailureState) {
              return EmptyState(
                failure: state.failure,
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
