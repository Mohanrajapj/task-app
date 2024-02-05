import 'package:equatable/equatable.dart';

abstract class GetUsersState extends Equatable {
  const GetUsersState();
  @override
  List<Object> get props => [];
}

class GetUsersLoading extends GetUsersState {}

class GetUsersLoaded extends GetUsersState {
  final List userList;

  const GetUsersLoaded({
    required this.userList,
  });

  @override
  List<Object> get props => [userList];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': userList,
    };
  }

  factory GetUsersLoaded.fromMap(Map<String, dynamic> map) {
    return GetUsersLoaded(
      userList: map["result"],
    );
  }
}

class GetUsersError extends GetUsersState {
  final String error;

  const GetUsersError({
    required this.error,
  });
}
