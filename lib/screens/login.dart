import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth_example/components/auth_button.dart';
import 'package:flutter_auth_example/components/auth_textfield.dart';
import 'package:flutter_auth_example/helpers/showsnackbar.dart';
import 'package:flutter_auth_example/screens/home.dart';
import 'package:flutter_auth_example/screens/signup.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showSnackBar(context, 'Please fill in all fields.', Colors.red);
      return;
    }

    if (password.length < 6) {
      showSnackBar(
        context,
        'Password must be at least 6 characters',
        Colors.red,
      );
      return;
    }

    final Map<String, String> loginData = {
      'username': username,
      'password': password,
    };

    try {
      var urlString = 'http://localhost:3000/auth/signin';

      if (Platform.isAndroid) {
        urlString = 'http://10.0.2.2:3000/auth/signin';
      }

      final url = Uri.parse(urlString);
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(loginData),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        if (context.mounted) {
          showSnackBar(context, 'Login successful!', Colors.black);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ?? 'Login failed.';

        if (context.mounted) showSnackBar(context, errorMessage, Colors.red);
      }
    } catch (error) {
      String errorMessage = 'An error occured during sign-up.';
      if (error is http.ClientException || error is SocketException) {
        errorMessage =
            'Failed to connect to the Server. Check your internet connection.';
      } else if (error is TimeoutException) {
        errorMessage = 'Connection timed out. Please try again later.';
      }

      debugPrint('Error ${error.toString()}');
      if (context.mounted) showSnackBar(context, errorMessage, Colors.red);
    }
  }

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
                  _login(context);
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
