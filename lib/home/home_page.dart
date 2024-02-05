import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/home/cubit/get_users_cubit.dart';
import 'package:task_app/home/cubit/get_users_state.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetUsersCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("All Users"),
        ),
        body: BlocBuilder<GetUsersCubit, GetUsersState>(
          builder: (context, state) {
            if (state is GetUsersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetUsersError) {
              return Center(child: Text(state.error));
            }
            if (state is GetUsersLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.userList.length,
                itemBuilder: (context, index) {
                  final user = state.userList[index] as Map<String, dynamic>;
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Column(
                      children: user.entries.map((MapEntry entry) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entry.key[0].toUpperCase() +
                                  entry.key.substring(1) +
                                  " :    "),
                              Expanded(
                                child: Text(
                                  "${entry.value}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
