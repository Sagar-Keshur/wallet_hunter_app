import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/stores/auth_store/auth_store.dart';
import '../../core/widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Dashboard'),
            AppButton(
              text: 'Logout',
              onPressed: () => context.read<AuthStore>().logout(),
            ),
          ],
        ),
      ),
    );
  }
}
