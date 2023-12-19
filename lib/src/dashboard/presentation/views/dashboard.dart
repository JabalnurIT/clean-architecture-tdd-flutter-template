import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/media_res.dart';
import '../providers/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardController>().getScreens(context.currentUser!.role);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(builder: (_, controller, __) {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: controller.screens,
        ),
        bottomNavigationBar: (controller.currentIndex == 1 &&
                context.currentUser!.role == "security")
            ? null
            : Container(
                decoration: BoxDecoration(
                  color: Colours.secondaryColour,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SafeArea(
                  child: BottomNavigationBar(
                    currentIndex: controller.currentIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onTap: controller.changeIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: controller.currentIndex == 0
                                    ? Colours.primaryColour
                                    : Colors.transparent,
                                width: 5.0,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: SvgPicture.asset(
                            controller.currentIndex == 0
                                ? MediaRes.homeBold
                                : MediaRes.homeLight,
                            height: 32,
                            width: 32,
                          ),
                        ),
                        label: 'Home',
                      ),
                      if (context.currentUser!.role == 'security')
                        BottomNavigationBarItem(
                          icon: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: controller.currentIndex == 1
                                      ? Colours.primaryColour
                                      : Colors.transparent,
                                  width: 5.0,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: SvgPicture.asset(
                              controller.currentIndex == 1
                                  ? MediaRes.scanBold
                                  : MediaRes.scanLight,
                              height: 32,
                              width: 32,
                            ),
                          ),
                          label: 'Scan',
                          backgroundColor: Colors.white,
                        )
                      else
                        BottomNavigationBarItem(
                          icon: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: controller.currentIndex == 1
                                      ? Colours.primaryColour
                                      : Colors.transparent,
                                  width: 5.0,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: SvgPicture.asset(
                              controller.currentIndex == 1
                                  ? MediaRes.addBold
                                  : MediaRes.addLight,
                              height: 32,
                              width: 32,
                            ),
                          ),
                          label: 'Add',
                          backgroundColor: Colors.white,
                        ),
                      BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: controller.currentIndex == 2
                                    ? Colours.primaryColour
                                    : Colors.transparent,
                                width: 5.0,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: SvgPicture.asset(
                            controller.currentIndex == 2
                                ? MediaRes.profileBold
                                : MediaRes.profileLight,
                            height: 32,
                            width: 32,
                          ),
                        ),
                        label: 'Profile',
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
