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
  final _focusNode = FocusNode();
  final _debounce = Debounce(const Duration(milliseconds: 400));
  List<AppContact>? _contacts;
  final bool _isSearch = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _homeCubit.fetchContacts();
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
              return const Center(
                child: Text('Deu pau'),
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
