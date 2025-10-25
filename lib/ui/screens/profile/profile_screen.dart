import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


import '../../../core/injection/injection.dart';
import '../../../core/model/user/user_model.dart';
import '../../../core/provider/auth_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/constants/image_assets.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget implements AutoRouteWrapper {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style:
              AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenPadding,
                vertical: context.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppDimensions.gapRegular),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(-10, 8),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            ImageAssets.profile,
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const Gap(AppDimensions.gapXXL),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.screenPadding),
                          child: Selector<AuthProvider, UserModel>(
                            selector: (p0, p1) => p1.user!,
                            builder: (context, user, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: AppTypography.titleLarge,
                                  ),
                                  const Gap(5),
                                  Text(
                                    user.email,
                                    style: AppTypography.bodyMedium,
                                  ),
                                  const Gap(5),
                                  Text(
                                    user.contact,
                                    style: AppTypography.bodyMedium,
                                  ),
                                  const Gap(10),
                                ],
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(AppDimensions.gapXXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWellMaterial(
                      onTap: () {},
                      child: Container(
                        height: 90,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: InkWellMaterial(
                          onTap: () {
                            context.router.push(const FavouriteRoute());
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite),
                              Text("Favourite"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            )
                          ]),
                      child: InkWellMaterial(
                        onTap: () => context.router.push(OrdersRoute()),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list_alt),
                            Text("Orders"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(AppDimensions.gapXXL),
                _ProfileButtons(
                  onTap: () {
                    context.router.push(const ProfileSettingRoute());
                  },
                  btnTxt: "View profile",
                  btnIcon: Icons.person,
                ),
                const Gap(AppDimensions.gapRegular),
                _ProfileButtons(
                  btnTxt: "About us",
                  btnIcon: Icons.info_outline,
                  onTap: () {
                    context.router.push(const AboutRoute());
                  },
                ),
                const Gap(AppDimensions.gapRegular),
                const Gap(AppDimensions.gapXXL),
                InkWellMaterial(
                  onTap: () => context.read<AuthProvider>().logout(),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC6011F),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "LogOut",
                      style:
                          AppTypography.labelLarge.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<AuthProvider>()..getUser(),
        child: this,
      );
}

class _ProfileButtons extends StatelessWidget {
  const _ProfileButtons({
    required this.btnTxt,
    required this.btnIcon,
    required this.onTap,
  });

  final String btnTxt;
  final VoidCallback onTap;
  final IconData btnIcon;

  @override
  Widget build(BuildContext context) {
    return InkWellMaterial(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                offset: const Offset(0, 4),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Icon(btnIcon),
              const Gap(10),
              Text(
                btnTxt,
                style: AppTypography.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
