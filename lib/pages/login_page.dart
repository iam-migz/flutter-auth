import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miggy/models/storage_item.dart';
import 'package:miggy/services/auth_service.dart';
import 'package:miggy/services/storage_service.dart';
import 'package:miggy/widgets/password_input.dart';
import 'package:miggy/widgets/primary_button.dart';
import 'package:miggy/widgets/text_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool obscurePassword = true;
  bool isLogginIn = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLogginIn,
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: 'Email Address',
                      hintText: 'enter your email address',
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
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Login',
                      iconData: Icons.login,
                      onPress: login,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.red),
                      label: const Text('Sign up with Google'),
                      onPressed: () {
                        googleSignIn();
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: const Text(
                            "Don't have an account? Sign up here.",
                            style: TextStyle(fontSize: 18.0),
                          )),
                    )
                  ],
                ),
              ),
            ),
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

  googleSignIn() async {
    try {
      setState(() {
        isLogginIn = true;
      });
      var user = await _authService.signInWithGoogle();

      var accessToken =
          StorageItem('accesstoken', user.credential?.accessToken as String);

      await _storageService.saveData(accessToken);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (err) {
      setState(() {
        errorMessage = 'Google Login Error: ${err.toString()}';
      });
    }
    setState(() {
      isLogginIn = true;
    });
  }

  login() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      setState(() {
        errorMessage = 'Please complete the form.';
      });
    }
    String res =
        await _authService.signIn(_email.text.trim(), _password.text.trim());
    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }
    setState(() {
      errorMessage = res;
    });
  }
}
