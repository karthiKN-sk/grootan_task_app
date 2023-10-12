import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan_task_app/app/extension/date_extension.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';
import 'package:grootan_task_app/app/utils/loader.dart';
import 'package:grootan_task_app/app/utils/reusable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';
import '../../data/models/number_gen_model.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/lastlogin/lastlogin_controller.dart';
import '../widgets/buttonwidget.dart';

class TabbarViewwidget extends StatefulWidget {
  final LastLoginController lastLoginController;
  final AuthController authController;
  const TabbarViewwidget(
      {super.key,
      required this.lastLoginController,
      required this.authController});

  @override
  State<TabbarViewwidget> createState() => _TabbarViewwidgetState();
}

class _TabbarViewwidgetState extends State<TabbarViewwidget>
    with TickerProviderStateMixin {
  ///
  late TabController tabController;

  ///
  int index = 0;

  ///
  List<String> tabs = ["Today", "Yesterday", "Other"];

  ///
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        index = tabController.index;
      });
    });
    super.initState();
  }

  ///
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        ///
        Container(
          color: themeData.colorScheme.background,
          margin: EdgeInsets.all(AppSize.s8!),
          child: TabBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            controller: tabController,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(AppSize.s4!),
              borderSide: BorderSide(
                width: 4.0,
                color: themeData.colorScheme.primary,
              ),
            ),
            tabs: [
              /// List of Tabs
              ...tabs.map(
                (e) => Tab(
                  child: Text(
                    e,
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.displayLarge!,
                      fontSize: AppSize.s16,
                      color: themeData.colorScheme.onTertiary,
                      fontWeight: 600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              ///Today Tabbar Data
              StreamBuilder(
                stream: widget.lastLoginController
                    .readAllData(userID: widget.authController.isSignedUserID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ///Looping Only Today Data
                    List<NumGenerateModel> dataToday = [];
                    for (var element in snapshot.data!) {
                      if (DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse(element.date!)
                          .isToday) {
                        dataToday.add(element);
                      }
                    }

                    return dataToday.isNotEmpty

                        ///List Builder Card
                        ? listBuilderCards(dataToday, themeData)
                        : Loading.loadingEmpty(themeData,
                            icon: const Icon(Icons.hourglass_empty),
                            emptyText:
                                "please Add some data to view".toTitleCase());
                  } else if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 600,
                      ),
                    );
                  } else {
                    return Loading.loadingWidget(height: 3);
                  }
                },
              ),

              ///Yesterday Tabbar Data
              StreamBuilder(
                stream: widget.lastLoginController
                    .readAllData(userID: widget.authController.isSignedUserID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ///Looping Only Yesterday Data
                    List<NumGenerateModel> dataYesterday = [];
                    for (var element in snapshot.data!) {
                      if (DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse(element.date!)
                          .isYesterday) {
                        dataYesterday.add(element);
                      }
                    }
                    return dataYesterday.isNotEmpty

                        ///List Builder Card
                        ? listBuilderCards(dataYesterday, themeData)
                        : Loading.loadingEmpty(
                            themeData,
                            icon: const Icon(Icons.hourglass_empty),
                            emptyText: "Yesterday List are Empty".toTitleCase(),
                          );
                  } else if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 600,
                      ),
                    );
                  } else {
                    return Loading.loadingWidget(height: 3);
                  }
                },
              ),

              ///Others Tabbar Data
              StreamBuilder(
                stream: widget.lastLoginController
                    .readAllData(userID: widget.authController.isSignedUserID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ///Looping Only Others Data
                    List<NumGenerateModel> dataOthers = [];
                    for (var element in snapshot.data!) {
                      if (DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse(element.date!)
                          .isOthers) {
                        dataOthers.add(element);
                      }
                    }

                    return dataOthers.isNotEmpty

                        ///List Builder Card
                        ? listBuilderCards(dataOthers, themeData)
                        : Loading.loadingEmpty(
                            themeData,
                            icon: const Icon(Icons.hourglass_empty),
                            emptyText: "Others List are Empty".toTitleCase(),
                          );
                  } else if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 600,
                      ),
                    );
                  } else {
                    return Loading.loadingWidget(height: 3);
                  }
                },
              ),
            ],
          ),
        ),
        ButtonWidget(
          themeData: themeData,
          title: 'Save',
          onPress: () {},
        ),
        verticalSpace(AppSize.s30!),
      ],
    );
  }

  ///Comman List Builder Card
  ListView listBuilderCards(
      List<NumGenerateModel> listData, ThemeData themeData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: listData.length,
      // padding: EdgeInsets.only(top: AppSize.s20!),
      itemBuilder: (BuildContext context, int index) {
        NumGenerateModel model = listData[index];
        return LoginCardWidgets(
          model: model,
          themeData: themeData,
        );
      },
    );
  }
}

///Comman Card in Last Login Page
class LoginCardWidgets extends StatelessWidget {
  final NumGenerateModel model;
  final ThemeData themeData;
  const LoginCardWidgets({
    super.key,
    required this.themeData,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final dateToCheck = DateFormat("yyyy-MM-dd HH:mm:ss").parse(model.date!);
    String time = DateFormat.jm().format(dateToCheck);
    return Padding(
      padding: EdgeInsets.only(top: AppSize.s25!),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.all(AppSize.s10!),
            padding: EdgeInsets.all(AppSize.s10!),
            height: Get.height / 8,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10!),
              color: themeData.colorScheme.secondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 600,
                        height: 1,
                      ),
                    ),
                    Text(
                      'IP:${model.ipAddress}',
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 700,
                        height: 1,
                      ),
                    ),
                    Text(
                      model.location!,
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.displayLarge!,
                        fontSize: AppSize.s16,
                        color: themeData.colorScheme.background,
                        fontWeight: 600,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///Barcode Position
          Positioned(
            right: AppSize.s20,
            top: -20,
            child: Container(
              padding: EdgeInsets.all(AppSize.s4!),
              height: AppSize.s100,
              width: AppSize.s100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10!),
                color: themeData.colorScheme.background,
                boxShadow: Reusable.boxshadow,
              ),
              child: SfBarcodeGenerator(
                value: model.generatedNum,
                symbology: QRCode(),
                showValue: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
