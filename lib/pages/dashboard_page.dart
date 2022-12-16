import 'package:flutter/material.dart';
// import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Object? parameters;
  @override
  Widget build(BuildContext context) {
    // parameters = ModalRoute.of(context)!.settings.arguments;
    // Map data = jsonDecode(jsonEncode(parameters));
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Dashboard Page'),
        ],
      )),
    );
  }
}
