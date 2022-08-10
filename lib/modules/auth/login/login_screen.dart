import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/modules/auth/login/cubit/login_cubit.dart';
import 'package:surebaladi/modules/auth/register/register.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/utilis/asset_manager.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';
import 'package:surebaladi/shared/utilis/constant/app_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<LoginCubit, LoginStates>(
              listener: (BuildContext context, state) {
                if (state is LoginSuccessState) {
                  CacheHelper.saveData(key: token, value: state.token)
                      .then((value) {
                    loginToken = state.token;
                    showToast(
                        text: 'Login Successfully'.tr(),
                        state: ToastStates.SUCCESS);
                    navigateAndFinish(
                      context: context,
                      widget: SureLayout(),
                    );
                  });
                } else if (state is LoginErrorState) {
                  showToast(
                      text: 'An error happened, please try again'.tr(),
                      state: ToastStates.ERROR);
                }
              },
              builder: (BuildContext context, Object? state) {
                var cubit = LoginCubit.get(context);
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(ImageAsset.logoImage),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      AppStrings.welcome,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(
                                          0xff119477,
                                        ),
                                        fontSize: 36.0,
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      AppStrings.userData,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    const SizedBox(height: 15.0),
                                    CustomTextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: userNameController,
                                      hintText: AppStrings.enterYourEmail,
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      hintText: AppStrings.enterYourPassword,
                                      prefixIcon: Icons.lock,
                                      suffixIcon: cubit.suffixIcon,
                                      pressedSuffixIcon: () {
                                        cubit.changeVisibility();
                                      },
                                      isDense: true,
                                      obscureText: cubit.secureText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings
                                              .plzEnterYourPassword;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 7.0),
                                    ConditionalBuilder(
                                        condition: state is! LoginLoadingState,
                                        builder: (context) => CustomButton(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              textColor: Colors.white,
                                              width: double.infinity,
                                              height: 40.0,
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  cubit.userLogin(
                                                      userName:
                                                          userNameController
                                                              .text,
                                                      password:
                                                          passwordController
                                                              .text);
                                                }
                                              },
                                              child: Text(AppStrings.login),
                                            ),
                                        fallback: (context) => const Center(
                                            child:
                                                CircularProgressIndicator())),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppStrings.forgotPassword,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CustomTextButton(
                                            onPressed: () {},
                                            text: AppStrings.resetHere,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.dontHaveAccount,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomTextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context: context,
                                            widget: RegisterScreen());
                                      },
                                      text: AppStrings.registerNow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.privacy_tip_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppStrings.rights,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            CustomTextButton(onPressed: () {}, text: 'SureBaladi'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
