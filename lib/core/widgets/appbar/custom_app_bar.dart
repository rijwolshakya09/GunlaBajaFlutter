import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mi.dart';

import '../../constants/colors/colors.dart';
import '../../constants/images/images.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1, 0),
      children: [
        Container(
          decoration: BoxDecoration(
              color: cMaroon, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Iconify(
                    Mi.menu,
                    color: cMaroon,
                    size: 26,
                  ),
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: cWhite, borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Stack(
                    children: [
                      Iconify(
                        Mi.notification,
                        color: cMaroon,
                        size: 26,
                      ),
                      // Positioned(
                      //   top: -4,
                      //   right: 0,
                      //   child: widget.unread_notification_count != 0
                      //       ? Container(
                      //           decoration: const BoxDecoration(
                      //               shape: BoxShape.circle, color: cRed),
                      //           padding: const EdgeInsets.all(4),
                      //           child: Text(
                      //             formatNotificationCount(
                      //                 widget.unread_notification_count),
                      //             style: fWhiteSemiBold12,
                      //           ),
                      //         )
                      //       : const SizedBox(),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: cWhite,
            maxRadius: 50,
            child: SvgPicture.asset(
              splashLogo,
              semanticsLabel: 'Splash Logo',
              // ignore: deprecated_member_use
              color: cBlack,
              fit: BoxFit.cover,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}
