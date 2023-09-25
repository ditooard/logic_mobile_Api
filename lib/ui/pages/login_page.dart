import 'package:flutter/material.dart';
import 'package:testing_api/models/response_model.dart';
import 'package:testing_api/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _login() async {
    setState(() {
      _controller.isLoading = true;
    });

    MyResponse response = await _controller.login();

    setState(() {
      _controller.isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.message)));
    if (response.status == 200) {
      Navigator.of(context).pushNamed('/dashboard');
    } else {}
  }

  LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
