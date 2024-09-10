import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample/features/authentication/screens/PeopleList/PeopleList.dart';
import 'package:sample/features/authentication/screens/signup/signupScreen.dart';
import 'package:sample/utils/constants/api_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../API/API_Methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen() : super();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showUsernameError = false;
  bool _showPasswordError = false;
  commonApi apiRequest = commonApi();

  // Make API request
  void call_login_API(String username, String password) async {
    final parameters = {
      'email': username,
      'password': password,
    };
    final result = await apiRequest.fetch_Api_Response(ApiUrl.base + ApiUrl.login, HttpType.POST, parameters);

    if (result.success) {

      // Navigate to PeopleList page if the login is successful
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PeopleList()),
        );
      }
    } else {
      print(result.message);
      if (result.responseBody != null) {
        print('Error Response: ${result.responseBody}');
        // You can also show a dialog or a snackbar to notify the user of the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message ?? 'Login failed')),
        );
        Fluttertoast.showToast(
            msg: "Username or password not valid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Header Section
  Widget _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  /// Text Fields
  Widget _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          onChanged: (value) {
            setState(() {
              _showUsernameError = value.isEmpty;
            });
          },
          maxLength: 30,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
            errorText: _showUsernameError ? 'Username cannot be empty' : null,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          onChanged: (value) {
            setState(() {
              _showPasswordError = value.isEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            errorText: _showPasswordError ? 'Password cannot be empty' : null,
          ),
          obscureText: !_showPassword,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showUsernameError = _usernameController.text.isEmpty;
              _showPasswordError = _passwordController.text.isEmpty;
            });

            if (!_showUsernameError && !_showPasswordError) {
              call_login_API(_usernameController.text, _passwordController.text);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  /// Forgot Password
  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  /// Signup Page
  Widget _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: const Text("Sign Up", style: TextStyle(color: Colors.purple)),
        )
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
