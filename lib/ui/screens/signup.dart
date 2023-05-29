// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/services/auth.dart';
import 'package:unrelo/services/storage_service.dart';
import 'package:unrelo/ui/widgets/loading/loading_screen.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';

class SignupPage extends HookWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final mobileNumberController = useTextEditingController();

    AuthService authService = AuthService();
    StorageService storageService = StorageService();

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
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                            label: 'First Name',
                            controller: firstNameController),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomInputField(
                            label: 'Last Name', controller: lastNameController),
                      ),
                    ],
                  ),
                  CustomInputField(
                      label: 'Email address',
                      controller: emailController,
                      keybordType: TextInputType.emailAddress),
                  CustomInputField(
                      label: 'Password',
                      controller: passwordController,
                      keybordType: TextInputType.visiblePassword),
                  CustomInputField(
                      label: 'Mobile Number',
                      keybordType: TextInputType.phone,
                      controller: mobileNumberController),
                ],
              ),
            ),
            CustomButton(
                buttonText: 'Sign up',
                onPressed: () async {
                  LoadingScreen.instance().show(
                    context: context,
                    text: 'Signing up...',
                  );
                  var signupres = await authService.signUpWithEmailAndPassword(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  LoadingScreen.instance().hide();
                  if (signupres != null) {
                    CustomSnackbarWidget()
                        .showErrorSnackBar(context, signupres);
                    return;
                  } else {
                    await storageService.addUser(
                      '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                      mobileNumberController.text.trim(),
                      emailController.text.trim(),
                    );
                    CustomSnackbarWidget()
                        .showSuccessSnackBar(context, 'Sign up successful');
                    Navigator.pushNamed(context, '/signin');
                  }
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
