// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/utils/reusable.dart';
import 'package:grootan_task_app/presentation/views/login_page.dart';
import 'package:grootan_task_app/presentation/views/qrcode_generator.dart';
import 'package:local_auth/local_auth.dart';
import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';
import '../controllers/auth/auth_binding.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/generate_controller/binding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ThemeData themeData;

  ///
  AuthController authController = Get.put(AuthController());

  ///
  final LocalAuthentication auth = LocalAuthentication();

  ///
  @override
  void initState() {
    super.initState();

    ///
    navigation();
  }

  navigation() async {
    ///
    await authController.checkSignIn();

    ///
    Timer(
      const Duration(seconds: 5),
      () {
        ///
        if (authController.isSignedIn &&
            authController.isSignedUserID != null) {
          ///Biometric
          appBiometric();
        } else {
          ///LoginPage
          Get.offAll(const LoginPage(), binding: AuthBindings());
        }
      },
    );
  }

  ///
  appBiometric() async {
    ///
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    ///
    if (canAuthenticate) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      ///
      if (availableBiometrics.isEmpty) {
        isErrorSnackBar(context,
            message: "Biometerics Not Available In this Device");
      }
      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.weak) ||
          availableBiometrics.contains(BiometricType.fingerprint)) {
        // Specific types of biometrics are available.
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show Plugin Page',
            options: const AuthenticationOptions(biometricOnly: true));

        ///
        if (didAuthenticate) {
          Get.offAll(const QRCodeGeneratorPage(),
              binding: NumberGenerateBindings());
        } else {
          Get.offAll(const LoginPage(), binding: AuthBindings());
        }
      }
    } else {
      isErrorSnackBar(context,
          message: "Biometerics Not Supported In this Device");
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeData.colorScheme.background,
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s10!),
                    child: Image.asset(
                      "assets/images/splash.png",
                      width: AppSize.s250,
                      height: AppSize.s250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  verticalSpace(AppSize.s20),
                  Text(
                    'Grootan Task App',
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.headlineSmall!,
                      fontSize: AppSize.s30,
                      color: themeData.colorScheme.primary,
                      fontWeight: 600,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Task Done By',
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.displayLarge!,
                          fontSize: AppSize.s16,
                          color: themeData.colorScheme.error,
                          fontWeight: 600,
                        ),
                      ),
                      horizontalSpace(AppSize.s6),
                      Text(
                        'Karthikeyan',
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.displayLarge!,
                          fontSize: AppSize.s16,
                          color: themeData.colorScheme.primary,
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(AppSize.s20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
