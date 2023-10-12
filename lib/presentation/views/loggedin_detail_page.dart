import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';

import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/lastlogin/lastlogin_controller.dart';
import '../widgets/main_ui.dart';
import 'loggedin_detail_tabbarview.dart';

class LastLoginPage extends StatefulWidget {
  const LastLoginPage({super.key});

  @override
  State<LastLoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LastLoginPage> {
  ///
  LastLoginController lastLoginController = Get.put(LastLoginController());

  ///
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    ///CommanDesign Widgets
    return CustomWidget(
      themeData: themeData,
      backButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.all(AppSize.s6!),
            constraints: const BoxConstraints(),
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: AppSize.s25,
            ),
          ),
          InkWell(
            onTap: () {
              authController.logout();
            },
            child: Padding(
              padding: EdgeInsets.all(AppSize.s6!),
              child: Text(
                'Logout',
                style: AppTheme.getTextStyle(
                  themeData.textTheme.displayLarge!,
                  fontSize: AppSize.s18,
                  color: themeData.colorScheme.background,
                  fontWeight: 700,
                ),
              ),
            ),
          ),
        ],
      ),
      pageName: "LAST LOGIN".toTitleCase(),
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSize.s30!,
          left: AppSize.s10!,
          right: AppSize.s10!,
        ),

        ///TabbarView Widgets
        child: TabbarViewwidget(
          lastLoginController: lastLoginController,
          authController: authController,
        ),
      ),
    );
  }
}
