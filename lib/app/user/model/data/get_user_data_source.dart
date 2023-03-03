import 'package:answer_poc/app/user/model/entities/user.dart';
import 'package:answer_poc/app/user/model/exceptions/rest_client_exception.dart';

class GetUserDataSource {
  Future<User> getUser(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    if (id == 'error') {
      throw RestClientException(message: 'User not found', code: 404);
    } else if (id == 'exception') {
      throw RestClientException(message: 'User not found', code: 500);
    } else {
      return User(name: 'John', email: 'john@gmail.com');
    }
  }
}
