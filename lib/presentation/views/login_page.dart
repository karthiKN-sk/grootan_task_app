import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';
import 'package:grootan_task_app/presentation/controllers/auth/auth_binding.dart';
import 'package:grootan_task_app/presentation/views/otp_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app/core/size.dart';

import '../../app/utils/reusable.dart';
import '../controllers/auth/auth_controller.dart';
import '../widgets/buttonwidget.dart';
import '../widgets/main_ui.dart';
import '../widgets/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///
  AuthController authController = Get.put(AuthController());

  ///
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  ///
  final TextEditingController phonecontroller = TextEditingController();

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
        pageName: "LOGIN",
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSize.s100!,
            left: AppSize.s20!,
            right: AppSize.s20!,
          ),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                CustomTextFormFeild(
                  key: const Key("phoneField"),
                  fieldTitle: 'Phone Number',
                  themeData: themeData,
                  hintText: 'Enter Phone number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Phone Number";
                    } else if (!value.isValidPhone) {
                      return "Please Enter valid mobile number";
                    }
                    return null;
                  },
                  controller: phonecontroller,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                  onFieldSubmitted: (_) => onLoginSubmit(context),
                ),
                verticalSpace(AppSize.s80),
                ButtonWidget(
                  key: const Key("Login Button"),
                  themeData: themeData,
                  title: "Login",
                  onPress: () {
                    onLoginSubmit(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLoginSubmit(BuildContext context) {
    if (formkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.loaderOverlay.show();
      authController.signInWithPhone(context,
          phoneNumber: phonecontroller.text.trim(), verifyId: (id) {
        context.loaderOverlay.hide();
        Get.to(OtpPage(verificationId: id), binding: AuthBindings());
      });
    } else {
      isErrorSnackBar(context, message: "Please Enter the Phone Number");
    }
  }
}
