import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/tab_navigator.dart';
import '../../../../core/common/views/persistent_view.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  // I want to get role user from ContextExtensions on BuildContext

  late List<Widget> _screens = [];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void getScreens(String role) {
    if (role == 'employee') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
      ];
    } else if (role == 'agent') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
      ];
    } else if (role == 'security') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const Placeholder(),
                  ),
                ),
            child: const PersistentView()),
      ];
    }

    screens.add(
      ChangeNotifierProvider(
          create: (_) => TabNavigator(
                TabItem(
                  child: const Placeholder(),
                ),
              ),
          child: const PersistentView()),
    );
  }

  void changeIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
