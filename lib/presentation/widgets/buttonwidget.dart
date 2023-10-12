import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final double? width;
  final ThemeData themeData;
  final GestureTapCallback onPress;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onPress,
    required this.themeData,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: themeData.colorScheme.primary,
      shape:
          OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s10!)),
      height: AppSize.s50,
      minWidth: width ?? Get.width,
      onPressed: onPress,
      child: Text(
        title,
        style: AppTheme.getTextStyle(
          themeData.textTheme.displayLarge!,
          fontSize: AppSize.s20,
          color: themeData.colorScheme.background,
          fontWeight: 600,
        ),
      ),
    );
  }
}
