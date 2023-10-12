import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';

import '../core/app_themes.dart';
import '../core/size.dart';
import 'reusable.dart';

class Loading {
  ///>>>>>>>>>>>>>>>>NetWork Image ErrorBuilder
  static Widget buildErrorBuilder(
      BuildContext context, Object exception, StackTrace? stackTrace) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: AppSize.s10,
          color: Theme.of(context).colorScheme.error,
        ),
        verticalSpace(AppSize.s2),
        Text(
          "No Image".toTitleCase(),
          style: AppTheme.getTextStyle(
            Theme.of(context).textTheme.displayLarge!,
            color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.8),
            fontSize: AppSize.s8,
            fontWeight: 700,
            height: 1,
          ),
        )
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>NetWork Image FrameBuilder
  static Widget buildFrameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: child,
    );
  }

  ///>>>>>>>>>>>>>>>>NetWork Image Loading
  static Widget imageLoader(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppSize.s8!),
      height: AppSize.s60,
      width: AppSize.s60,
      child: Center(
        child: SizedBox(
          height: AppSize.s26,
          width: AppSize.s26,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      ),
    );
  }

  static Widget buildImageLoading(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  static Widget loading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppSize.s8!),
      height: AppSize.s60,
      width: AppSize.s60,
      child: Center(
        child: SizedBox(
          height: AppSize.s26,
          width: AppSize.s26,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  static loadingWidget({double height = 1.4}) {
    return SizedBox(
      height: Get.height / height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  static loadingScaffold(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  static loadingCircularProgressShadow(BuildContext context,
      {double height = 1.4}) {
    return Scaffold(
      body: SizedBox(
        height: Get.height / height,
        child: Center(
            child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            shape: BoxShape.circle,
            boxShadow: Reusable.boxshadow,
          ),
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        )),
      ),
    );
  }

  static loadingNormalCircularProgress(BuildContext context, {Color? color}) {
    return Center(
        child: CircularProgressIndicator(
      color: color ?? Theme.of(context).colorScheme.primary,
    ));
  }

  static loadingEmpty(ThemeData themeData,
      {required Widget icon, required String emptyText}) {
    return SizedBox(
      height: Get.height / 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            verticalSpace(AppSize.s10),
            Text(
              emptyText,
              style: AppTheme.getTextStyle(
                themeData.textTheme.displayLarge!,
                fontSize: AppSize.s16,
                fontWeight: 600,
                color: themeData.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
