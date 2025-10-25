import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


import '../../../core/injection/injection.dart';
import '../../../core/provider/auth_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../../utils/helper/custom_validators.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/textfield/reg_textfield.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<AuthProvider>(),
        child: this,
      );
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passWordCtrl;
  final  _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _passWordCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        style: AppTypography.titleLarge
                            .copyWith(color: AppColors.buttonColor),
                        'SMART CITY',
                      ),
                    ),
                    const Gap(10),
                    RegTextField(
                      controller: _emailCtrl,
                      hntext: 'Enter your Email',
                      lbtext: 'E-mail',
                      validator: (value) =>
                          CustomValidators.validateEmail(value),
                      icon: const Icon(Icons.mail),
                    ),
                    const Gap(10),
                    RegTextField(
                      controller: _passWordCtrl,
                      hntext: 'Enter Password',
                      lbtext: "Password",
                      isPassword: true,
                      validator: (p0) => CustomValidators.validatePassword(p0),
                      icon: const Icon(Icons.lock),
                    ),
                    const Gap(20),
                    Consumer<AuthProvider>(builder: (context, provider, _) {
                      return PrimaryButton(
                        isLoading: provider.isBusy,
                        text: 'Login',
                        onTap: () => _login(),
                      );
                    }),
                    const Gap(20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: AppTypography.bodySmall,
                          ),
                          const Gap(5),
                          InkWellMaterial(
                            onTap: () =>
                                context.router.push(const RegisterRoute()),
                            child: Text(
                              "Sign up",
                              style: AppTypography.bodySmall
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passWordCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthProvider>().login(
            email: _emailCtrl.text,
            password: _passWordCtrl.text,
          );
    }
  }
}
