import 'package:flutter/material.dart';
import 'package:miggy/services/storage_service.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final StorageService storageService = StorageService();
  var res = await storageService.readData('accesstoken');
  String myInitialRoute = res != null ? '/dashboard' : '/login';

  runApp(MaterialApp(
    initialRoute: myInitialRoute,
    routes: {
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignupPage(),
      '/dashboard': (context) => const DashboardPage(),
      '/settings': (context) => const SettingsPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
