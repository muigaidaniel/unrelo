import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sizer/sizer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[900]!,
              Colors.blue[500]!,
              Colors.blue[800]!,
            ],
          ),
        ),
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: 7.h, bottom: 15.h),
                child: Text('Sign in',
                    style: Theme.of(context).textTheme.bodyLarge)),
            Form(
              child: Column(
                children: [
                  CustomInputField(label: 'Email address'),
                  CustomInputField(label: 'Password'),
                ],
              ),
            ),
            CustomButton(
                buttonText: 'Sign in',
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                }),
            SizedBox(height: 3.h),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 3.h),
            const Text(
              'Or sign in with',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            SignInButton(Buttons.Google, onPressed: () {}),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/signup');
                  },
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
