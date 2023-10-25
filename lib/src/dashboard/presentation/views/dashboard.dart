import 'package:clean_architecture_tdd_flutter_template/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          'Dashboard',
          style: context.theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
