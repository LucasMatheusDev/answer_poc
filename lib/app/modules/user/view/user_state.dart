import 'package:answer_poc/app/modules/user/model/entities/user.dart';
import 'package:answer_poc/app/modules/user/model/exceptions/user_exception.dart';

abstract class UserState {}

class StateInitial extends UserState {}

class StateLoading extends UserState {}

class StateSuccess extends UserState {
  final User user;

  StateSuccess(this.user);
}

class StateDefaultError extends UserState {
  final UserException exception;

  StateDefaultError(this.exception);
}

class StateNotFoundError extends UserState {
  final UserException exception;

  StateNotFoundError(this.exception);
}
