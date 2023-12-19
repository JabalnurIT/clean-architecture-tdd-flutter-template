import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/app/providers/user_provider.dart';
import '../../../../core/common/widgets/gradient_background.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../dashboard/presentation/views/dashboard.dart';
import '../../data/models/user_model.dart';
import '../bloc/auth_bloc.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const SignInWithCredentialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as UserModel);
            await Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, Dashboard.routeName);
            });
          } else if (state is NotSignedIn) {
            await Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            });
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.splashBackground,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontFamily: Fonts.inter,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(MediaRes.flutterIcons),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
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
