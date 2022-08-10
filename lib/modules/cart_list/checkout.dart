import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/models/cart_models/checkout_models.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_cubit.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/component/component.dart';

enum Menu { completed, favorite, delete }

class CheckOut extends StatelessWidget {
  CheckOut({Key? key}) : super(key: key);
  int? id;
  String? date;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CheckOutCubit()..getAddress(),
      child: BlocConsumer<CheckOutCubit, CheckOutStates>(
        listener: (BuildContext context, state) {
          if (state is SuccessCreateOrderState) {
            navigateTo(context: context, widget: SureLayout());
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = CheckOutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: TextButton(
                  onPressed: () {
                    cubit.getAddress();
                  },
                  child: Text('Hi')),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.vertical,
                    onStepContinue: () {
                      cubit.continueButton(
                        context,
                        AlertDialog(
                          title: Text("Are you sure!!".tr()),
                          content: Text("Order completed!".tr()),
                          actions: [
                            MaterialButton(
                              child: Text("Cancel".tr()),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: Text("Ok".tr()),
                              onPressed: () {
                                cubit.createOrder(
                                    id: id.toString(),
                                    date: cubit.dateController.text);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    onStepCancel: () {
                      cubit.cancelButton();
                    },
                    currentStep: cubit.currentStep,
                    steps: [
                      Step(
                          isActive: cubit.currentStep >= 0,
                          title: Text('Choose your Address'.tr()),
                          content: SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: ListView.builder(
                                  itemCount: cubit.list.length,
                                  itemBuilder: (context, index) {
                                    var item = cubit.list[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: cubit.currentIndex == index
                                              ? Colors.green
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: ListTile(
                                        textColor: cubit.currentIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        onTap: () {
                                          cubit.changeAddress(index: index);
                                          id = item['id'];
                                          print(item['id']);
                                        },
                                        title: Container(
                                          child: customText(
                                            text: item['street'] +
                                                ' ' +
                                                item['districtNameAr'] +
                                                ' ' +
                                                item['cityNameAr'].toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  }))),
                      Step(
                          isActive: cubit.currentStep >= 1,
                          title: Text('Choose your date'.tr()),
                          content: Column(
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              CustomTextFormField(
                                  validator: (value) {},
                                  controller: cubit.dateController,
                                  hintText: 'Select your date'.tr(),
                                  onTap: () {
                                    DateTime now = DateTime.now()
                                        .add(const Duration(days: 1));
                                    showDatePicker(
                                            context: context,
                                            initialDate: now,
                                            firstDate: now,
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 30)))
                                        .then((value) {
                                      cubit.dateController.text =
                                          DateFormat('yyyy-MM-dd').format(value!);
                                      print(cubit.dateController.text);
                                      // cubit.dateController.text as DateTime= value;
                                    }).catchError((error) {
                                      cubit.dateController.clear();
                                    });
                                  }),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          )),

                    ],
                    onStepTapped: (index) {
                      cubit.onStepTapped(index: index);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
