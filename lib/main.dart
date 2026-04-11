import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/gatekeeper_screen.dart';

void main() {
  runApp(const MeAppForHer());
}

class MeAppForHer extends StatelessWidget {
  const MeAppForHer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me & You',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const GatekeeperScreen(),
    );
  }
}
