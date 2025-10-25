import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';

enum _BottomTabEnum {
  home(
      name: 'Home',
      icon: Icons.home,
      width: 28,
      height: 28,
      route: HomeRoute()),
  cart(
      name: 'Cart',
      icon: Icons.shopping_cart,
      width: 28,
      height: 28,
      route: CartRoute()),
  favourite(
      name: 'favourite',
      icon: Icons.favorite,
      width: 28,
      height: 28,
      route: FavouriteRoute()),
  profile(
      name: 'Profile',
      icon: Icons.person_2_outlined,
      width: 28,
      height: 28,
      route: ProfileRoute()
      );

  const _BottomTabEnum({
    required this.icon,
    required this.route,
    required this.name,
    this.width,
    this.height,
  });

  final IconData icon;
  final String name;
  final PageRouteInfo route;
  final double? width;
  final double? height;
}

@RoutePage()
class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) => AutoRouter(
    builder: (context, content) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: content,
          ),
          Positioned(
            bottom: 30,
            left: context.screenPadding,
            right: context.screenPadding,
            child: const _GBottomNav(),
          ),
        ],
      ),
    ),
  );
}

class _GBottomNav extends StatelessWidget {
  const _GBottomNav();

  @override
  Widget build(BuildContext context) {
    final activeRoute = AutoRouter.of(context, watch: true)
        .stack
        .reversed
        .firstOrNull
        ?.routeData
        .name;
    return Container(
      height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: GNav(
              // key: Key(activeRoute.toString()),
              gap: 8,
              selectedIndex: _BottomTabEnum.values.indexWhere(
                    (element) => element.route.routeName == activeRoute,
              ),
              backgroundColor: AppColors.buttonColor,
              color: Colors.white,
              activeColor: AppColors.buttonColor,
              tabBackgroundColor: Colors.white,
              padding: EdgeInsets.all(16),
              tabs: List.generate(
                _BottomTabEnum.values.length,
                    (index) => GButton(
                  // active: activeRoute ==
                  //     _BottomTabEnum.values[index].route.routeName,
                  icon: _BottomTabEnum.values[index].icon,
                  text: _BottomTabEnum.values[index].name,
                  onPressed: () => context.router.push(
                    _BottomTabEnum.values[index].route,
                  ),
                      padding: EdgeInsets.all(10),
                ),
              ),
            ),
            ),
        );
    }
}
