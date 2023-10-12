import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app/core/size.dart';

import '../../app/utils/reusable.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/generate_controller/binding.dart';
import '../widgets/buttonwidget.dart';
import '../widgets/main_ui.dart';
import '../widgets/textformfield.dart';
import 'qrcode_generator.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  const OtpPage({super.key, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  ///
  AuthController authController = Get.put(AuthController());
///
  GlobalKey<FormState> otpForm = GlobalKey<FormState>();
 ///
  final TextEditingController otpcontroller = TextEditingController();
///
  DateTime? currentBackPressTime;
  ///Back Button Tap
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

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: CustomWidget(
        themeData: themeData,
        pageName: "OTP",
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSize.s100!,
            left: AppSize.s20!,
            right: AppSize.s20!,
          ),
          child: Form(
            key: otpForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormFeild(
                      themeData: themeData,
                      fieldTitle: 'OTP',
                      hintText: 'Enter OTP',
                      autofocus: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter OTP Number";
                        }
                        return null;
                      },
                      controller: otpcontroller,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      maxLength: 6,
                      onFieldSubmitted: (_) => verifyOTP(context),
                    ),
                  ],
                ),
                verticalSpace(AppSize.s80),
                ButtonWidget(
                  themeData: themeData,
                  title: "Verify Otp",
                  onPress: () {
                    verifyOTP(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyOTP(BuildContext context) {
    if (otpForm.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.loaderOverlay.show();
      authController.verifyOTP(
        context: context,
        verificationId: widget.verificationId,
        userOtP: otpcontroller.text.trim(),
        onSuccess: () {
          context.loaderOverlay.hide();
          Get.offAll(const QRCodeGeneratorPage(),
              binding: NumberGenerateBindings());
        },
      );
    } else {
      isErrorSnackBar(context, message: "Please Enter 6 Digit Otp");
    }
  }
}
