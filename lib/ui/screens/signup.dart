import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sizer/sizer.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                margin: EdgeInsets.symmetric(vertical: 5.h),
                child: Text('Sign up',
                    style: Theme.of(context).textTheme.bodyLarge)),
            Form(
              child: Column(
                children: [
                  Row(
                    children: const  [
                      Expanded(
                        child: CustomInputField(label: 'First Name'),
                      ),
                       SizedBox(width: 10),
                      Expanded(
                        child: CustomInputField(label: 'Last Name'),
                      ),
                    ],
                  ),
                  const CustomInputField(label: 'Email address'),
                  const CustomInputField(label: 'Password'),
                  const CustomInputField(label: 'Mobile Number'),
                ],
              ),
            ),
            CustomButton(
                buttonText: 'Sign up',
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                }),
            SizedBox(height: 3.h),
            const Text(
              'Or sign up with',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            SignInButton(Buttons.Google, onPressed: () {}),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text('Login',
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
