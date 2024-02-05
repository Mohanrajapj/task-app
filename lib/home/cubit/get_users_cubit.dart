import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:task_app/home/cubit/get_users_state.dart';
import 'package:task_app/repository/api_reposiitory.dart';

class GetUsersCubit extends HydratedCubit<GetUsersState> {
  final ApiRepository apiRepository;

  GetUsersCubit(this.apiRepository) : super(GetUsersLoading());

  Future<void> fetchUsers() async {
    var res = await apiRepository.getUser();
    if (res['status']) {
      try {
        final postList = res['data'] as List;
        emit(GetUsersLoaded(userList: postList));
      } catch (err) {
        emit(GetUsersError(error: err.toString()));
        debugPrint("Error :$err");
      }
    }
  }

  @override
  GetUsersState? fromJson(Map<String, dynamic> json) {
    try {
      return GetUsersLoaded(userList: json['result']);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(GetUsersState state) {
    if (state is GetUsersLoaded) {
      return {'result': state.userList};
    } else {
      return null;
    }
  }
}
