import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/auth/sign_in_screen.dart';
import 'package:booking_system_flutter/screens/chat/chat_list_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/booking_fragment.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/dashboard_fragment.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/profile_fragment.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/string_extensions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/voice_search_component.dart';
import '../../utils/app_configuration.dart';

const String _kDashboardSelectIndexKey = 'dashboardSelectIndex';

class DashboardScreen extends StatefulWidget {
  final bool? redirectToBooking;

  DashboardScreen({this.redirectToBooking});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  List<Widget> get pages {
    return [
      DashboardFragment(),
      appStore.isLoggedIn
          ? BookingFragment()
          : const SignInScreen(isFromDashboard: true),

      // if (appConfigurationStore.isEnableChat)
      //   appStore.isLoggedIn
      //       ?
      ChatListScreen(),
      // : const SignInScreen(isFromDashboard: true),

      ProfileFragment(),
    ];
  }

  @override
  void initState() {
    super.initState();

    if (widget.redirectToBooking.validate(value: false)) {
      currentIndex = 1;
    }

    LiveStream().on(_kDashboardSelectIndexKey, (value) {
      if (value is int && value >= 0 && value < pages.length) {
        currentIndex = value;
        setState(() {});
      }
    });

    init();
  }

  void init() async {
    await 3.seconds.delay;
    if (getIntAsync(FORCE_UPDATE_USER_APP).getBoolInt()) {
      showForceUpdateDialog(context);
    }
  }

  @override
  void dispose() {
    LiveStream().dispose(_kDashboardSelectIndexKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: language.lblBackPressMsg,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          height: 60,
          color: context.primaryColor.withValues(alpha: 0.15),
          buttonBackgroundColor: primaryColor,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            ic_home.iconImage(
                size: 28,
                color:
                    currentIndex == 0 ? Colors.white : appTextSecondaryColor),
            ic_ticket.iconImage(
                size: 28,
                color:
                    currentIndex == 1 ? Colors.white : appTextSecondaryColor),

            if (appConfigurationStore.isEnableChat)
              ic_chat.iconImage(
                  size: 28,
                  color:
                      currentIndex == 2 ? Colors.white : appTextSecondaryColor),
            Icon(Icons.person,
                color: currentIndex == 3 ? Colors.white : appTextSecondaryColor)
            // Observer(
            //   builder: (context) {
            //     return (appStore.isLoggedIn &&
            //         appStore.userProfileImage.isNotEmpty)
            //         ?       :    Icon(Icons.person);
            //

            // ImageBorder(
            //     src: appStore.userProfileImage,
            //     height: 28,
            //     width: 28)
            //     : ic_profile2.iconImage(
            //   size: 28,
            //   color: appTextSecondaryColor,
            // );
            // },
            // ),
          ],
        ),
        bottomSheet: Observer(
          builder: (context) {
            return VoiceSearchComponent().visible(appStore.isSpeechActivated);
          },
        ),
      ),
    );
  }
}
