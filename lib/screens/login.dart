import 'package:flutter/material.dart';
import 'package:flutter_auth_example/components/auth_button.dart';
import 'package:flutter_auth_example/components/auth_textfield.dart';
import 'package:flutter_auth_example/screens/signup.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Icon(Icons.key, size: 100),
              const SizedBox(height: 50.0),
              const Text('Welcome back'),
              const SizedBox(height: 25),
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
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              AuthButton(
                onTap: () {
                  debugPrint('initiated tap');
                  debugPrint(usernameController.text);
                },
                label: 'Sign In',
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
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
