import 'package:flutter/material.dart';

import '../../core/constants/colors/colors.dart';
import '../../core/widgets/appbar/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height,
          child: const SingleChildScrollView(
            child: Column(
              children: [
                HomeAppBar(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
