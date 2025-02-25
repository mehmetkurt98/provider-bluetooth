import 'package:go_router/go_router.dart';
import 'package:fluttet_hm10/view/pages/home/home_view.dart';
import 'package:fluttet_hm10/view/pages/connect/ble_connect.dart';

/// Route path sabitleri
class AppRoutes {
  static const String home = '/home';
  static const String connect = '/connect';
  static const String initialRoute = connect;
}

/// Router sınıfı
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.initialRoute,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: AppRoutes.connect,
        name: 'connect',
        builder: (context, state) => const BleConnnectPage(),
      ),
    ],
  );
}

