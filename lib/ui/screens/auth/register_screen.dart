import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


import '../../../utils/helper/custom_validators.dart';
import '../../../core/injection/injection.dart';
import '../../../core/provider/auth_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/textfield/reg_textfield.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget implements AutoRouteWrapper{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
    value: locator<AuthProvider>(),
    child: this,
  );

}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                context.router.back();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.screenPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Center(child: Text('SMART CITY')), ,
                      //Gap(10),
                      const Center(
                        child: Text(
                          'Register Now!!',
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(40),
                      Form(
                        key:_formKey,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              RegTextField(
                                controller: _nameController,
                                hntext: 'Your Full Name',
                                lbtext: "Name",
                                validator: CustomValidators.validateRequired,
                                icon: const Icon(Icons.person_2_outlined),

                              ),
                              const Gap(10),
                              RegTextField(
                                controller: _phoneController,
                                hntext: 'Your Mobile No.',
                                lbtext: "Mobile No.",
                                icon: const Icon(Icons.phone),
                                validator: (value) => CustomValidators.validatePhone(value),
                              ),
                              const Gap(10),
                              RegTextField(
                                controller: _emailController,
                                hntext: 'samplemailemail.com',
                                lbtext: "E-Mail",
                                icon: const Icon(Icons.email_outlined),
                                validator: (value) => CustomValidators.validateEmail(value),
                              ),
                              const Gap(10),
                              RegTextField(
                                controller: _passwordController,
                                hntext: 'Set password',
                                lbtext: "Password",
                                validator: CustomValidators.validatePassword,
                                icon: const Icon(Icons.lock),
                              ),
                              const Gap(10),
                              RegTextField(
                                controller: _confirmPasswordController,
                                hntext: 'confirm Password',
                                lbtext: 'Confirm',
                                validator: (p0) => CustomValidators.validateConfirmPassword(p0, password: _passwordController.text,),
                                icon: const Icon(Icons.lock),
                              ),
                              const Gap(30),
                              Selector<AuthProvider, bool>(
                                selector: (p0, p1) => p1.isBusy,
                                builder: (context, isLoading, _) {
                                  return PrimaryButton(
                                    isLoading: isLoading,
                                    text: 'save',
                                    onTap: _save,
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _save() async {
  //   if (_formKey.currentState!.validate()) {
  //     await context.router.replaceAll([const HomeTabRoute()]);
  //     return null;
  //   }

    Future<void> _save() async {
      if (_formKey.currentState!.validate()) {
        if (_passwordController.text == _confirmPasswordController.text) {
          await context.read<AuthProvider>().register(
            name: _nameController.text,
            number: _phoneController.text,
            email: _emailController.text,
            passWord: _passwordController.text,
          );

        }
      }
    }
  }

