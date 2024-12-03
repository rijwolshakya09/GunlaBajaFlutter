import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/home/home_screen.dart';
import '../constants/colors/colors.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  final int initalIndex;
  const LayoutScreen({
    super.key,
    required this.initalIndex,
  });

  @override
  ConsumerState<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<String>? permissions;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initalIndex);
    _getDataFromSharedPref();
  }

  Future<void> _getDataFromSharedPref() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      permissions = prefs.getStringList('permissions');
      setState(() {});
    } catch (e) {
      debugPrint("Error getting data from SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) async {
      //   if (didPop) {
      //     return;
      //   }
      //   final bool? shouldExit = await exitModel(context, () {
      //     SystemNavigator.pop();
      //     exit(0);
      //   });
      //   if (shouldExit ?? false) {
      //     SystemNavigator.pop();
      //     exit(0);
      //   }
      // },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: cWhite,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Iconify(Octicon.home_16, color: cMaroon),
        inactiveIcon: const Iconify(Octicon.home_16, color: cDarkGray),
        title: "Home",
        activeColorPrimary: cMaroon,
        inactiveColorPrimary: cDarkGray,
      ),
      PersistentBottomNavBarItem(
        icon:
            const Iconify(MaterialSymbols.play_lesson_outline, color: cMaroon),
        inactiveIcon: const Iconify(MaterialSymbols.play_lesson_outline,
            color: cDarkGray),
        title: "Lessons",
        activeColorPrimary: cMaroon,
        inactiveColorPrimary: cDarkGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Iconify(Ic.outline_insert_chart, color: cMaroon),
        inactiveIcon: const Iconify(Ic.outline_insert_chart, color: cDarkGray),
        title: "Stats",
        activeColorPrimary: cMaroon,
        inactiveColorPrimary: cDarkGray,
      ),
      PersistentBottomNavBarItem(
        icon: const Iconify(Bi.person, color: cMaroon),
        inactiveIcon: const Iconify(Bi.person, color: cDarkGray),
        title: "Profile",
        activeColorPrimary: cMaroon,
        inactiveColorPrimary: cDarkGray,
      ),
    ];
  }
}
