import 'package:answer_poc/app/modules/user/view/get_user_controller.dart';
import 'package:answer_poc/app/modules/user/view/user_state.dart';
import 'package:flutter/material.dart';

class GetUserPage extends StatelessWidget {
  final GetUserController controller;
  const GetUserPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final textUserToSearch = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get User'),
      ),
      body: ValueListenableBuilder<UserState>(
        valueListenable: controller.state,
        builder: (context, state, child) {
          if (state is StateInitial) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Search User By id'),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: textUserToSearch,
                        decoration: const InputDecoration(
                          helperText: 'You can try "error" or "exception"',
                          helperStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'User Id',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.getUser(
                              textUserToSearch.text.toLowerCase().trim());
                        }
                      },
                      child: const Text('Get User'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is StateLoading) {
            return const Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is StateSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Success!'),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('User: ${state.user.name}'),
                  Text('Email: ${state.user.email}'),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.state.value = StateInitial();
                    },
                    child: const Text('Search Again'),
                  ),
                ],
              ),
            );
          } else if (state is StateDefaultError) {
            return Center(
              child: Column(
                children: [
                  Text('Error: ${state.exception.message}'),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      controller.state.value = StateInitial();
                    },
                    child: const Text('Search Again'),
                  ),
                ],
              ),
            );
          } else if (state is StateNotFoundError) {
            return Center(
              child: Column(
                children: [
                  Text('Error: ${state.exception.message}'),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                    ),
                    onPressed: () {
                      controller.state.value = StateInitial();
                    },
                    child: const Text('Search Again'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Unknown'),
            );
          }
        },
      ),
    );
  }
}
