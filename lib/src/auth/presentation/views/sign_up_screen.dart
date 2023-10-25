import 'package:clean_architecture_tdd_flutter_template/core/common/app/providers/user_provider.dart';
import 'package:clean_architecture_tdd_flutter_template/core/common/widgets/gradient_background.dart';
import 'package:clean_architecture_tdd_flutter_template/core/common/widgets/rounded_button.dart';
import 'package:clean_architecture_tdd_flutter_template/core/res/fonts.dart';
import 'package:clean_architecture_tdd_flutter_template/core/res/media_res.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/core_utils.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/views/sign_in_screen.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/widgets/sign_up_form.dart';
import 'package:clean_architecture_tdd_flutter_template/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                      username: emailController.text.trim(),
                      password: passwordController.text.trim()),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.defaultBackground,
            child: SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const Text(
                      'TDD Flutter Template',
                      style: TextStyle(
                        fontFamily: Fonts.inter,
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sign up for an account',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SignInScreen.routeName,
                          );
                        },
                        child: const Text('Already have an account?'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SignUpForm(
                      usernameController: usernameController,
                      passwordController: passwordController,
                      formKey: formKey,
                      confirmPasswordController: confirmPasswordController,
                      nameController: nameController,
                      emailController: emailController,
                    ),
                    const SizedBox(height: 30),
                    if (state is AuthLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      RoundedButton(
                        text: 'Sign Up',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          FirebaseAuth.instance.currentUser?.reload();
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignUpEvent(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    username: usernameController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
