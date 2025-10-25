import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/provider/auth_provider.dart';

import '../../../utils/extensions/build_context_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/buttons/operation_button.dart';
import '../../widgets/textfield/profile_textfield.dart';

@RoutePage()
class SetAddressScreen extends StatelessWidget {
  const SetAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Address",
          style: AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(CupertinoIcons.left_chevron),onPressed: () => context.router.maybePop(),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenPadding * 1.5,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Consumer<AuthProvider>(
              builder: (context,provider,_) {
                return Column(
                  children: [
                    Gap(AppDimensions.gapXXL),
                    ProfileTextFeild(
                      lbel: 'House',
                      initVal: "House Name", passHide: false,
                    ),
                    Gap(AppDimensions.gapXXL),
                    ProfileTextFeild(
                      lbel: 'Street',
                      initVal: "street name", passHide: false,
                    ),
                    Gap(AppDimensions.gapXXL),
                    ProfileTextFeild(
                      lbel: 'Street No.',
                      initVal: "Street Number", passHide: false,
                    ),
                    Gap(AppDimensions.gapXXL),
                    ProfileTextFeild(
                      lbel: 'Phone',
                      initVal: "+91 000000000 ", passHide: false,
                    ),
                    Gap(AppDimensions.gapXXL),
                    ProfileTextFeild(
                      lbel: 'Gender',
                      initVal: "Male", passHide: false,
                    ),
                    Gap(AppDimensions.gapXXL),
                    InkWellMaterial(onTap: () {

                    },child: OperationButton(btnTxt: "Set Home",)),

                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

