import 'dart:developer';

import 'package:answer_poc/app/user/view/user_state.dart';
import 'package:answer_poc/app/user/view_model/get_user_view_model.dart';
import 'package:flutter/cupertino.dart';

class GetUserController {
  final ValueNotifier<UserState> state = ValueNotifier(StateInitial());

  final GetUserViewModel viewModel;

  GetUserController({
    required this.viewModel,
  });

  Future<void> getUser(String id) async {
    state.value = StateLoading();

    final userAnswer = await viewModel.getUser(id);

    userAnswer.deal(
      onFail: (error) {
        log('Error: ${error.message}');
        state.value = StateDefaultError(error);
      },
      onSuccess: (user) {
        log('User: ${user.name}');

        state.value = StateSuccess(user);
      },
    );

  //    Other Way to deal with Answer
  //     if (userAnswer.isSuccess) {
  //       log('User: ${userAnswer.asSuccess.name}');
  //       state.value = StateSuccess(userAnswer.asSuccess);
  //     } else {
  //       log('Error: ${userAnswer.asFailure.message}');
  //       state.value = StateDefaultError(userAnswer.asFailure);
  //     }
  }
}
