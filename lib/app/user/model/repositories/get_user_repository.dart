import 'package:answer_poc/app/user/model/data/get_user_data_source.dart';
import 'package:answer_poc/app/user/model/entities/user.dart';
import 'package:answer_poc/app/user/model/exceptions/rest_client_exception.dart';
import 'package:answer_poc/app/user/model/exceptions/user_exception.dart';
import 'package:answer_poc/app/core/answer.dart';

class GetUserRepository {
  final GetUserDataSource dataSource;

  GetUserRepository({
    required this.dataSource,
  });

  Future<Answer<UserException, User>> getUser(String id) async {
    try {
      final user = await dataSource.getUser(id);
      return Success(user);
    } on RestClientException catch (e) {
      if (e.code == 404) {
        return Failure(
          UserNotFoundException(
            message: 'User not found',
            code: e.code,
          ),
        );
      } else {
        return Failure(
          UserDefaultException(
            message: 'Something went wrong',
            code: e.code,
          ),
        );
      }
    }
  }
}
