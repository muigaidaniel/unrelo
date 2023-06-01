import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/core/theme.dart';
import 'package:unrelo/ui/screens/homescreen.dart';
import 'package:unrelo/ui/screens/login.dart';
import 'package:unrelo/ui/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        routes: {
          '/': (context) => const SignInPage(),
          '/signup': (context) => const SignupPage(),
          '/signin': (context) => const SignInPage(),
          '/home': (context) => const HomeScreen(sensors: []),
        },
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
