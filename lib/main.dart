import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttet_hm10/routes/app_router.dart';
import 'package:fluttet_hm10/utils/vb10_shared.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

void main() async {
  if (kReleaseMode) {
    Logger.level = Level.nothing;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedManager.initSharedPrefences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR'), Locale('de', 'DE')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),//tasarım boyutları
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'AC CONTROLLER',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.deviceLocale,
      ),
    );
  }
}