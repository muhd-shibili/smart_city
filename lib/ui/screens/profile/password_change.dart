import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/extensions/build_context_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/buttons/operation_button.dart';
import '../../widgets/textfield/profile_textfield.dart';


@RoutePage()
class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        title: Text(
          "Edit profile",
          style: AppTypography.labelLarge,
        ),
        actions: [IconButton(onPressed: () {

        }, icon: Icon(Icons.help))],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenPadding*1.1,vertical: context.screenPadding*2),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock_open,color: AppColors.buttonColor,size: 30,),
                Gap(20),
                Text("Create new password",style: AppTypography.titleLarge,),
                Gap(10),
                Text("Please enter your new password.\nPassword must be strong & consider following rules"),
                Gap(40),

                ProfileTextFeild(lbel: "Password", passHide: true,),

                Gap(AppDimensions.gapExtraLarge),
                ProfileTextFeild(lbel: "Confirm Password", passHide: true,),

                Gap(30),
                InkWellMaterial(onTap: () {

                },child: OperationButton(btnTxt: 'Reset Password')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Gap(20),
                        Text("Consider following things",style: AppTypography.labelMedium.copyWith(color: Colors.grey.shade500),),
                        Gap(10),
                        Text("Must contain a number",style: AppTypography.labelSmall.copyWith(color: Colors.grey.shade500)),
                        Text("Must contain 8 characters ",style: AppTypography.labelSmall.copyWith(color: Colors.grey.shade500)),
                        Text("Must conatin a special symbol\n",style: AppTypography.labelSmall.copyWith(color: Colors.grey.shade500)),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
