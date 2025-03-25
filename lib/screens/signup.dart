import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth_example/components/auth_button.dart';
import 'package:flutter_auth_example/components/auth_textfield.dart';
import 'package:flutter_auth_example/helpers/showsnackbar.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final fullnameController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      showSnackBar(context, 'Sign-Up Failed', Colors.red);
      return;
    }

    final String fullName = fullnameController.text.trim();
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    // if (fullName.isEmpty || username.isEmpty || password.isEmpty) {
    //   showSnackBar(context, 'Please fill in all fields.', Colors.red);
    //   return;
    // }

    // if (password.length < 6) {
    //   showSnackBar(
    //     context,
    //     'Password must be at least 6 characters',
    //     Colors.red,
    //   );
    //   return;
    // }

    final Map<String, String> signUpData = {
      'fullName': fullName,
      'username': username,
      'password': password,
    };

    try {
      var urlString = 'http://localhost:3000/auth/signup';

      if (Platform.isAndroid) {
        urlString = 'http://10.0.2.2:3000/auth/signup';
      }

      final url = Uri.parse(urlString);
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(signUpData),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        if (context.mounted) {
          showSnackBar(context, 'Sign-up successful!', Colors.black);
          Navigator.pop(context);
        }
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ?? 'Sign-up failed.';

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
      appBar: AppBar(backgroundColor: Colors.grey[300]),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.create, size: 100),
                const SizedBox(height: 50.0),
                const Text('Create Account'),
                const SizedBox(height: 25),
                AuthTextField(
                  label: 'Full Name',
                  icon: Icons.person,
                  controller: fullnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                AuthTextField(
                  label: 'Username',
                  icon: Icons.login,
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    if (value.toString().length < 6) {
                      return 'Username must be 6 or more characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                AuthTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  isObscured: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.toString().length < 6) {
                      return 'Password must be 6 or more characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                AuthButton(
                  onTap: () => _signUp(context),
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
      ),
    );
  }
}
