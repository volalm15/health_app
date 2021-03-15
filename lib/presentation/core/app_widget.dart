import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_app/presentation/routes/router.gr.dart';

import '../../theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        home: Container(),
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        builder: ExtendedNavigator(
          router: MyRouter(),
        ),
      ),
    );
  }
}
