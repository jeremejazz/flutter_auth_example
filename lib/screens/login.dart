import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                labelText: "Username",
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.key),
                labelText: "Password",
              ),
            ),
            SizedBox(height: 15.0),
            ElevatedButton(onPressed: () {}, child: Text("Login")),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
