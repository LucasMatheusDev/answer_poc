import 'package:answer_poc/app/user/model/data/get_user_data_source.dart';
import 'package:answer_poc/app/user/model/repositories/get_user_repository.dart';
import 'package:answer_poc/app/user/view/get_user_controller.dart';
import 'package:answer_poc/app/user/view/get_user_page.dart';
import 'package:answer_poc/app/user/view_model/get_user_view_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetUserPage(
        controller: GetUserController(
          viewModel: GetUserViewModel(
            repository: GetUserRepository(
              dataSource: GetUserDataSource(),
            ),
          ),
        ),
      ),
    );
  }
}
