import '../cubit/auth_cubit.dart';
import '../widgets/create_user_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_loader.dart';
import '../widgets/user_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUsers() {
    context.read<AuthCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AutheticationErrorState) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(state.message),
              actions: const [Text("jewel")],
            ),
          );
        } else if (state is UserCreatedState) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Users"),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(context: context, builder: (context) => CreateUserDialogWidget());
              }),
          body: state is GettingUsersState
              ? const CustomLoader()
              : state is CreatingUserState
                  ? const CustomLoader()
                  : state is UserLoadedState
                      ? state.users.isEmpty
                          ? const EmptyWidget()
                          : ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                return UserItemWidget(
                                  user: state.users[index],
                                );
                              },
                            )
                      : const SizedBox(),
        );
      },
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Data Found!"),
    );
  }
}
