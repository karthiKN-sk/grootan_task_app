import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grootan_task_app/app/utils/loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'firebase_options.dart';

import 'app/core/app_themes.dart';
import 'app/core/size.dart';
import 'app/services/store_theme.dart';
import 'presentation/views/splash_screen.dart';
import 'presentation/widgets/nointernetwidget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///Get Device Size
    AppSize().init(context);

    return GetMaterialApp(
      builder: (context, child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.grey.withOpacity(0.6),
          overlayWidget: Loading.loadingNormalCircularProgress(context),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent),
              child: SafeArea(
                child: OfflineBuilder(
                  connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                  ) {
                    if (connectivity == ConnectivityResult.none) {
                      return const NoInternetWidget();
                    }
                    return child;
                  },
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      title: 'Grootan Task App',
      themeMode: ThemeService().getThemeMode(),
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
