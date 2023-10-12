import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/utils/reusable.dart';

import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';
import '../../app/services/store_theme.dart';

class CustomWidget extends StatelessWidget {
  final ThemeData themeData;
  final Widget child;
  final String pageName;
  final Widget? backButton;
  const CustomWidget(
      {super.key,
      required this.child,
      required this.pageName,
      this.backButton,
      required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: AppSize.s50,
              width: Get.width,
              padding: EdgeInsets.only(
                  top: AppSize.s10!, left: AppSize.s8!, right: AppSize.s8!),
              child: backButton ?? const SizedBox.shrink(),
            ),
            verticalSpace(AppSize.s50),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.85,
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s40!),
                      topRight: Radius.circular(AppSize.s40!),
                    ),
                  ),
                  child: child,
                ),
                Positioned(
                  top: -30,
                  left: Get.width / 2.8,
                  child: Container(
                    height: AppSize.s50,
                    padding: EdgeInsets.only(
                        left: AppSize.s20!, right: AppSize.s20!),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeData.colorScheme.primary,
                        boxShadow: Reusable.boxshadow),
                    child: Center(
                      child: Text(
                        pageName,
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.headlineSmall!,
                          fontSize: AppSize.s20,
                          color: themeData.colorScheme.background,
                          fontWeight: 700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ThemeService().changeThemeData();
        },
        backgroundColor: themeData.colorScheme.tertiary,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
        label: themeData.brightness == Brightness.dark
            ? Row(
                children: [
                  const Icon(
                    Icons.light_mode,
                    color: Colors.white,
                  ),
                  horizontalSpace(AppSize.s8),
                  Text(
                    'Light Mode',
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.headlineSmall!,
                      fontSize: AppSize.s16,
                      color: themeData.colorScheme.background,
                      fontWeight: 500,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  const Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                  ),
                  horizontalSpace(AppSize.s8),
                  Text(
                    'Dark Mode',
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.headlineSmall!,
                      fontSize: AppSize.s16,
                      color: themeData.colorScheme.background,
                      fontWeight: 500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
