import 'package:answer_poc/app/modules/user/model/entities/user.dart';
import 'package:answer_poc/app/modules/user/model/exceptions/user_exception.dart';
import 'package:answer_poc/app/modules/user/model/repositories/get_user_repository.dart';
import 'package:answer_poc/app/core/answer.dart';

class GetUserViewModel {
  final GetUserRepository repository;

  GetUserViewModel({
    required this.repository,
  });

  Future<Answer<UserException, User>> getUser(String id) async {
    return await repository.getUser(id);
  }
}
