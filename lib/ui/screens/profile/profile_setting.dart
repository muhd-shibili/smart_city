import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/provider/auth_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/constants/image_assets.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/buttons/operation_button.dart';
import '../../widgets/textfield/profile_textfield.dart';

@RoutePage()
class ProfileSettingScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<AuthProvider>(),
        child: this,
      );
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenPadding * 1.5,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Consumer<AuthProvider>(builder: (context, provider, _) {
              return Column(
                children: [
                  Gap(10),
                  Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.asset(
                        ImageAssets.profile,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Gap(AppDimensions.gapXXL),
                  ProfileTextFeild(
                    lbel: 'Name',
                    initVal: provider.user!.name,
                    passHide: false,
                  ),
                  Gap(AppDimensions.gapXXL),
                  ProfileTextFeild(
                    lbel: 'Email',
                    initVal: provider.user!.email,
                    passHide: false,
                  ),
                  Gap(AppDimensions.gapXXL),
                  ProfileTextFeild(
                    lbel: 'Phone',
                    initVal: provider.user!.contact,
                    passHide: false,
                  ),
                  Gap(AppDimensions.gapXXL),
                  ProfileTextFeild(
                    lbel: 'DOB',
                    initVal: provider.user!.name,
                    passHide: false,
                  ),
                  Gap(AppDimensions.gapXXL),
                  ProfileTextFeild(
                    lbel: 'Gender',
                    initVal: "Male",
                    passHide: false,
                  ),
                  // Gap(AppDimensions.gapRegular),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Need to change password ?",
                  //       style: AppTypography.labelSmall,
                  //     ),
                  //     Gap(5),
                  //     InkWellMaterial(
                  //         onTap: () {
                  //           context.router.push(PasswordManager());
                  //         },
                  //         child: Text(
                  //           "Click here",
                  //           style: AppTypography.labelMedium
                  //               .copyWith(color: Colors.blue),
                  //         ))
                  //   ],
                  // ),
                  // Gap(AppDimensions.gapXXL),
                  // InkWellMaterial(
                  //     onTap: () {},
                  //     child: OperationButton(
                  //       btnTxt: "Update profile",
                  //     )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
