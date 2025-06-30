import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/stores/auth_store/auth_store.dart';
import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';
import '../../dependency_manager/dependency_manager.dart';
import '../../router/route_helper.dart';
import 'pages/family_tree_page.dart';
import 'pages/home_page.dart';
import 'store/dashboard_store.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardStore _dashboardStore;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _dashboardStore = context.read<DashboardStore>();
    unawaited(_dashboardStore.getFamilyModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppAppBar(
        titleWidget: Observer(
          builder: (_) {
            return Text(
              _dashboardStore.currentPageIndex == 0
                  ? 'Family Members'
                  : 'Family Tree',
              style: AppStyles.h3,
            );
          },
        ),
        centerTitle: true,
        actions: [
          Observer(
            builder: (_) {
              if (_dashboardStore.currentPageIndex == 1) {
                return const SizedBox.shrink();
              }

              return IconButton(
                onPressed: () {
                  unawaited(context.read<AuthStore>().logout());
                },
                icon: const Icon(Icons.logout, color: AppColors.familyPrimary),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt<RouteHelper>().showAddMemberScreen();
        },
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: _dashboardStore.currentPageIndex,
            onTap: (index) {
              _dashboardStore.currentPageIndex = index;
              pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: 'Tree View',
              ),
            ],
          );
        },
      ),

      body: SafeArea(
        child: PageView(
          allowImplicitScrolling: true,
          controller: pageController,
          onPageChanged: (index) {
            _dashboardStore.currentPageIndex = index;
          },
          children: const [HomePage(), FamilyTreeScreen()],
        ),
      ),
    );
  }
}
