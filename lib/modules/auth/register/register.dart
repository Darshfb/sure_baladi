import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/modules/auth/login/login_screen.dart';
import 'package:surebaladi/modules/auth/register/cubit/register_cubit.dart';
import 'package:surebaladi/modules/auth/register/password.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/utilis/asset_manager.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';
import 'package:surebaladi/shared/utilis/constant/app_strings.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              )),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(ImageAsset.logoImage),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.2,
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            AppStrings.joinNow,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(
                                0xff119477,
                              ),
                              fontSize: 36.0,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            AppStrings.joinData,
                          ),
                          const SizedBox(height: 15.0),
                          CustomTextFormField(
                            keyboardType: TextInputType.name,
                            controller: userNameController,
                            hintText: AppStrings.enterYourName,
                            prefixIcon: Icons.person,
                            isDense: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.plzEnterYourEmail;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 7.0),
                          CustomTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            hintText: AppStrings.enterYourEmail,
                            prefixIcon: Icons.lock,
                            isDense: true,
                            validator: (value) {
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!) ||
                                  value.isEmpty) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 7.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  AppStrings.acceptAllThe,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomTextButton(
                                    onPressed: () {},
                                    text: AppStrings.termsConditions),
                                Checkbox(value: false, onChanged: (value) {}),
                              ],
                            ),
                          ),
                          CustomButton(
                            backgroundColor: AppColors.primaryColor,
                            textColor: Colors.white,
                            width: double.infinity,
                            height: 48.0,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                navigateTo(
                                    context: context,
                                    widget: PasswordScreen(
                                        email: emailController.text,
                                        phoneNumber: passwordController.text,
                                        username: userNameController.text,
                                        fullName: userNameController.text));
                              }
                            },
                            child: const Text(AppStrings.registerNow),
                          ),
                          const SizedBox(height: 7.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.AlreadyHaveAccount,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                    context: context, widget: LoginScreen());
                              },
                              text: AppStrings.loginHere)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
