import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/common/widgets/container_card.dart';
import '../../../../core/common/widgets/gradient_background.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/views/splash_screen.dart';
import '../../../dashboard/presentation/providers/dashboard_controller.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colours.primaryColour,
      ),
      backgroundColor: Colors.transparent,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is NotSignedIn) {
            final navigator = Navigator.of(context);
            unawaited(navigator.pushNamedAndRemoveUntil(
              SplashScreen.routeName,
              (route) => false,
            ));
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.colorBackground,
            child: ContainerCard(
              headerHeight: 62,
              padding: 10,
              header: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: (context.currentUser!.profileImg != null)
                    ? Image.network(
                        context.currentUser!.profileImg!,
                        width: 104,
                        height: 104,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 104,
                        height: 104,
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 24,
                          right: 24,
                          bottom: 24,
                        ),
                        color: Colours.profileBackgroundColour,
                        child: SvgPicture.asset(
                          MediaRes.profileIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              children: [
                Column(
                  children: [
                    const SizedBox(height: 82),
                    Text(
                      context.currentUser!.name,
                      style: const TextStyle(
                        color: Colours.primaryColour,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      context.currentUser!.role,
                      style: const TextStyle(
                        color: Colours.primaryColour,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push(BlocProvider(
                          create: (_) => sl<AuthBloc>(),
                          child: const EditProfileScreen(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(600, 96),
                        backgroundColor: Colours.primaryColour,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: SizedBox(
                        width: 200,
                        height: 96,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset(
                                      MediaRes.editIcon,
                                    ),
                                  )),
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Edit Profile',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: Fonts.inter),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        context.read<AuthBloc>().add(const SignOutEvent());
                        context.read<DashboardController>().resetIndex();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.primaryColour,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: SizedBox(
                        width: 200,
                        height: 96,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset(
                                      MediaRes.exitIcon,
                                    ),
                                  )),
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Keluar',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: Fonts.inter),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
