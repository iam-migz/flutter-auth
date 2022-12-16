import 'package:flutter/material.dart';
import 'package:miggy/services/auth_service.dart';
import 'package:miggy/widgets/password_input.dart';
import 'package:miggy/widgets/primary_button.dart';
import 'package:miggy/widgets/text_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text('Create an Account', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 30),
              CustomTextField(
                labelText: 'Email Address',
                hintText: 'enter your email',
                controller: _email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomPasswordField(
                obscureText: obscurePassword,
                onTap: handleObscurePassword,
                labelText: 'Password',
                hintText: 'enter your password',
                controller: _password,
              ),
              const SizedBox(height: 20),
              CustomPasswordField(
                obscureText: obscureConfirmPassword,
                onTap: handleObscureConfirmPassword,
                labelText: 'Confirm Password',
                hintText: 'confirm your password',
                controller: _confirmPassword,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Signup',
                iconData: Icons.login,
                onPress: () {
                  signup();
                  // Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Already have an account? Login here",
                      style: TextStyle(fontSize: 18.0),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  handleObscureConfirmPassword() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  signup() async {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _confirmPassword.text.isEmpty) {
      setState(() {
        errorMessage = 'Please complete the form.';
      });
    }

    String res =
        await _authService.signUp(_email.text.trim(), _password.text.trim());

    if (res == 'success') {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }
    setState(() {
      errorMessage = res;
    });
  }
}
