import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: HomeTabRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'home-screen',
              initial: true,
            ),
            AutoRoute(
              page: CartRoute.page,
              path: 'cart-screen',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile-screen',
            ),
            AutoRoute(
              page: FavouriteRoute.page,
              path: 'favourite-screen',
            ),
          ],
        ),
        AutoRoute(
      page: CategoryRoute.page,
      path: '/category-screen',
    ),
        AutoRoute(
          page: RegisterRoute.page,
          path: '/registration-screen',
        ),
        AutoRoute(
          page: OrderDetailsRoute.page,
          path: '/order-details-screen',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login-screen',
        ),
        AutoRoute(
          page: ShopRoute.page,
          path: '/Shop-screen',
        ),
        AutoRoute(
          page: ProductRoute.page,
          path: '/Product-screen',
        ),
        AutoRoute(
          page: ProfileSettingRoute.page,
          path: '/profile-setting-screen',
        ),
        AutoRoute(
          page: PasswordChangeRoute.page,
          path: '/change-password-screen',
        ),
        AutoRoute(
          page: AddressRoute.page,
          path: '/address-setting-screen',
        ),
        AutoRoute(
          page: SetAddressRoute.page,
          path: '/set-address-setting-screen',
        ),
        AutoRoute(
          page: NotificationRoute.page,
          path: '/notification-screen',
        ),
        AutoRoute(
          page: OrdersRoute.page,
          path: '/orders-screen',
        ),
        AutoRoute(
          page: ConfirmRoute.page,
          path: '/BUy-Now-screen',
        ),
        AutoRoute(
          page: AboutRoute.page,
          path: '/about-screen',
        ),
      ];
}
