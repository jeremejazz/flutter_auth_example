import 'package:flutter/material.dart';
import 'package:flutter_auth_example/components/auth_textfield.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.key, size: 100),
              const SizedBox(height: 50.0),
              const Text('Welcome back'),
              const SizedBox(height: 25),
              AuthTextField(
                label: 'Username',
                icon: Icons.get_app_rounded,
                controller: usernameController,
              ),
              const SizedBox(height: 15.0),
              AuthTextField(
                label: 'Password',
                icon: Icons.lock,
                controller: passwordController,
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
              ElevatedButton(onPressed: () {}, child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
