// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/utils/loader.dart';
import 'package:grootan_task_app/app/utils/reusable.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';
import '../../app/utils/date_utils.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/generate_controller/num_generate_controller.dart';
import '../controllers/location/location_controller.dart';
import '../widgets/buttonwidget.dart';
import '../widgets/main_ui.dart';
import 'loggedin_detail_page.dart';

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  ///
  AuthController authController = Get.put(AuthController());

  ///
  NumGenerateController numGenerateController =
      Get.put(NumGenerateController());

  ///
  late bool isLoading = true;

  ///
  final locationController = Get.put(LocationController());
  //
  String? ipAddress;
  String? loca;
  String? genrateNumber;

  @override
  void initState() {
    super.initState();
    gettingIP();
  }

  ///
  getRefresh() {
    Timer(const Duration(seconds: 2), (() {
      setState(() {
        isLoading = false;
      });
    }));
  }

  ///
  gettingIP() async {
    String location = await locationController.getCurrentPosition(context);
    getRefresh();
    if (location.isNotEmpty) {
      final info = NetworkInfo();
      var hostAddress = await info.getWifiIP();
      String numG = idGenerator();
      setState(() {
        ipAddress = hostAddress;
        loca = location;
        genrateNumber = numG;
      });
    }
  }

  ///
  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString().substring(10, 16);
  }

  ///
  DateTime? currentBackPressTime;

  ///
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      toastMsg(text: "Tap Again to Exit");
      return Future.value(false);
    }
    SystemNavigator.pop();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  ///
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: CustomWidget(
        themeData: themeData,
        backButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
        pageName: "PLUGIN",
        child: isLoading
            ? ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s40!),
                  topRight: Radius.circular(AppSize.s40!),
                ),
                child: Loading.loadingScaffold(context),
              )
            : QRCodeGenerator(
                themeData: themeData,
                numGenerateController: numGenerateController,
                authController: authController,
                idGenerator: genrateNumber!,
                ipAddress: ipAddress!,
                location: loca!,
              ),
      ),
    );
  }
}

///
class QRCodeGenerator extends StatelessWidget {
  final ThemeData themeData;
  final String idGenerator;
  final String ipAddress;
  final String location;
  final NumGenerateController numGenerateController;
  final AuthController authController;

  const QRCodeGenerator({
    super.key,
    required this.themeData,
    required this.idGenerator,
    required this.ipAddress,
    required this.location,
    required this.authController,
    required this.numGenerateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(AppSize.s150!),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: Get.height / 3.8,
              width: Get.width / 1.4,
              margin: EdgeInsets.all(AppSize.s10!),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20!),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    themeData.colorScheme.primary,
                    themeData.colorScheme.secondary,
                    themeData.colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Generated Number',
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.displayLarge!,
                      fontSize: AppSize.s28,
                      color: themeData.colorScheme.background,
                      fontWeight: 700,
                    ),
                  ),
                  verticalSpace(AppSize.s15),
                  Text(
                    idGenerator,
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.displayLarge!,
                      fontSize: AppSize.s25,
                      color: themeData.colorScheme.error,
                      fontWeight: 800,
                    ),
                  ),
                  verticalSpace(AppSize.s12),
                ],
              ),
            ),
            Positioned(
              top: -100,
              left: 45,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.background,
                    borderRadius: BorderRadius.circular(AppSize.s20!),
                    boxShadow: Reusable.boxshadow,
                  ),
                  height: AppSize.s200,
                  width: AppSize.s200,
                  child: SfBarcodeGenerator(
                    value: idGenerator,
                    symbology: QRCode(),
                    showValue: false,
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(AppSize.s40),
        // Text(
        //   '$location\n$ipAddress',
        //   style: AppTheme.getTextStyle(
        //     themeData.textTheme.displayLarge!,
        //     fontSize: AppSize.s14,
        //     color: themeData.colorScheme.primary,
        //     fontWeight: 500,
        //   ),
        // ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: AppSize.s40!, right: AppSize.s40!),
            child: Column(
              children: [
                authController.isSignedDate != null
                    ? InkWell(
                        onTap: () {
                          Get.to(const LastLoginPage());
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: themeData.colorScheme.onTertiary,
                            borderRadius: BorderRadius.circular(AppSize.s10!),
                            boxShadow: Reusable.boxshadow,
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Last login at ${checkDateTime(authController.isSignedDate)}',
                              style: AppTheme.getTextStyle(
                                themeData.textTheme.displayLarge!,
                                fontSize: AppSize.s14,
                                color: themeData.colorScheme.background,
                                fontWeight: 500,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                verticalSpace(AppSize.s40),
                ButtonWidget(
                  themeData: themeData,
                  title: "Save",
                  onPress: () {
                    numGenerateController.sendDetails(
                      context: context,
                      userID: authController.isSignedUserID,
                      idGenerator: idGenerator,
                      ipAddress: ipAddress,
                      location: location,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
