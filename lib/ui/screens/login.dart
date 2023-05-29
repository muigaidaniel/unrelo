// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/widgets/loading/loading_screen.dart';
import '../../services/auth.dart';
import '../../services/storage_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_snackbar.dart';
import 'homescreen.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

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
              key: formKey,
              child: Column(
                children: [
                  CustomInputField(
                    label: 'Email address',
                    controller: emailController,
                    keybordType: TextInputType.emailAddress,
                  ),
                  CustomInputField(
                    label: 'Password',
                    controller: passwordController,
                    keybordType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            CustomButton(
                buttonText: 'Sign in',
                onPressed: () async {
                  LoadingScreen.instance()
                      .show(context: context, text: 'Signing in');
                  var signupres = await authService.signInWithEmailAndPassword(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  List<Map<String, dynamic>> sensors =
                      await StorageService().fetchSensorList();
                  LoadingScreen.instance().hide();
                  if (signupres != null) {
                    CustomSnackbarWidget()
                        .showErrorSnackBar(context, signupres);
                    return;
                  } else {
                    CustomSnackbarWidget()
                        .showSuccessSnackBar(context, 'Sign in successful');
                    //Navigator.popAndPushNamed(context, '/home');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              sensors: sensors,
                            )));
                  }
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
