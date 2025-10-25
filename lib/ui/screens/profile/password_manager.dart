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
class PasswordManager extends StatelessWidget {
  const PasswordManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Icon(Icons.lock_outline,color: AppColors.buttonColor,size: 30,),
                Gap(20),
                Text("Reset Password",style: AppTypography.titleLarge,),
                Gap(10),
                Text("Enter the email & mobile number\nassociated with your account to reset password"),
                Gap(40),
                ProfileTextFeild(lbel: "Email", passHide: false,),
                Gap(AppDimensions.gapExtraLarge),
                ProfileTextFeild(lbel: "Mobile number",initVal: "+91 ", passHide: false,),
                Gap(30),
                InkWellMaterial(onTap: () {
                  // context.router.push(PasswordChange());
                },child: OperationButton(btnTxt: 'Validate')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
