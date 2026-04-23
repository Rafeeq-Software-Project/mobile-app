import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/local_data/current_user.dart';

import 'package:rafeeq_app/core/routing/app_router.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await CurrentUser.init();
  await SharedPrefHelper.init();
  AppRouter.initRouter();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(MyApp());
}
