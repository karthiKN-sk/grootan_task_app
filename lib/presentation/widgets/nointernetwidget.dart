import 'package:flutter/material.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';
import 'package:grootan_task_app/presentation/widgets/buttonwidget.dart';
import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s20!),
              child: Image.asset(
                "assets/images/nointernet.gif",
                fit: BoxFit.fill,
                height: AppSize.screenHeight / 2.8,
                width: AppSize.screenWidth / 1.2,
              ),
            ),
            verticalSpace(AppSize.s10),
            Text(
              'no internet'.toTitleCase(),
              style: AppTheme.getTextStyle(
                themeData.textTheme.displayLarge!,
                fontSize: AppSize.s20,
                fontWeight: 800,
                color: themeData.colorScheme.tertiary,
              ),
            ),
            Text(
              'Please check your internet connection! &'.toTitleCase(),
              style: AppTheme.getTextStyle(
                themeData.textTheme.displayLarge!,
                fontSize: AppSize.s14,
                fontWeight: 800,
                color: themeData.colorScheme.onTertiary,
              ),
            ),
            verticalSpace(AppSize.s30),
            ButtonWidget(
              width: AppSize.screenWidth / 2,
              themeData: themeData,
              title: "Try Again",
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
