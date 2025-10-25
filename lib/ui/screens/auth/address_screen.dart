import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/provider/auth_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/textfield/reg_textfield.dart';

@RoutePage()
class AddressScreen extends StatefulWidget implements AutoRouteWrapper {
  const AddressScreen({
    required this.name,
    super.key, required this.number, required this.email, required this.passWord,
  });
// trial
  final String name;
  final String number;
  final String email;
  final String passWord;

  @override
  State<AddressScreen> createState() => _AddressScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<AuthProvider>(),
        child: this,
      );
}

class _AddressScreenState extends State<AddressScreen> {
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
                          'Set Home',
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(40),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const RegTextField(
                              hntext: 'Your State',
                              lbtext: "State",
                              icon: Icon(Icons.real_estate_agent),
                            ),
                            const Gap(10),
                            const RegTextField(
                              hntext: 'Your district',
                              lbtext: "District",
                              icon: Icon(Icons.area_chart),
                            ),
                            const Gap(10),
                            const RegTextField(
                              hntext: 'Your City',
                              lbtext: 'City',
                              icon: Icon(Icons.cell_tower),
                            ),
                            const Gap(10),
                            const RegTextField(
                              hntext: 'Your PinCode',
                              lbtext: "PinCode",
                              icon: Icon(Icons.numbers),
                            ),
                            const Gap(30),
                            PrimaryButton(
                              text: 'save',
                              onTap: () {
                                context.router.push(const LoginRoute());
                              },
                            ),
                          ],
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

  Future<void> _onSaveUser() async {
    await context.read<AuthProvider>().register(
          name: widget.name,
          number: '',
          email: '',
          passWord: '',
          // state: '',
          // district: '',
          // locationId: '',
        );
    if (mounted) {
      await context.read<AuthProvider>().startApp();
    }
  }
}
