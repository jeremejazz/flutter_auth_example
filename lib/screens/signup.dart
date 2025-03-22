import 'package:flutter/material.dart';
import 'package:flutter_auth_example/components/auth_button.dart';
import 'package:flutter_auth_example/components/auth_textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(backgroundColor: Colors.grey[300]),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Icon(Icons.create, size: 100),
              const SizedBox(height: 50.0),
              const Text('Create Account'),
              const SizedBox(height: 25),
              AuthTextField(
                label: 'Full Name',
                icon: Icons.person,
                controller: fullnameController,
              ),
              const SizedBox(height: 15),
              AuthTextField(
                label: 'Username',
                icon: Icons.login,
                controller: usernameController,
              ),
              const SizedBox(height: 15.0),
              AuthTextField(
                label: 'Password',
                icon: Icons.lock,
                controller: passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 25.0),
              AuthButton(
                onTap: () async {
                  try {
                    if (fullnameController.text.isEmpty ||
                        usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      throw Exception('All fields are required.');
                    }
                    await Future.delayed(const Duration(seconds: 2));
                    debugPrint('Sign Up Successful');
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        (SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Sign Up Failed: ${e.toString()}'),
                        )),
                      );
                    }
                  }
                },
                label: 'Create Account',
              ),
              const SizedBox(height: 50.0),

              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: .5, color: Colors.grey[400]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(
                      'or',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(thickness: .5, color: Colors.grey[400]),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
