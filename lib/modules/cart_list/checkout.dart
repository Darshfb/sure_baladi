import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_cubit.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/component/component.dart';

class CheckOut extends StatelessWidget {
  CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CheckOutCubit(),
      child: BlocConsumer<CheckOutCubit, CheckOutStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = CheckOutCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.vertical,
                    onStepContinue: () {
                      cubit.continueButton(
                        context,
                        AlertDialog(
                          title: const Text("Are you sure!!"),
                          content: const Text("Order completed!"),
                          actions: [
                            MaterialButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: const Text("Ok"),
                              onPressed: () {},
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
                          title: const Text('Choose your Address'),
                          content: Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  //buttonDecoration: BoxDecoration(color: Colors.green),
                                  barrierColor: Colors.transparent,
                                  iconDisabledColor: Colors.green,
                                  iconEnabledColor: Colors.green,
                                  focusColor: Colors.green,
                                  selectedItemHighlightColor: Colors.green,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    maxLines: 1,
                                  ),
                                  items: cubit.items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ))
                                      .toList(),
                                  value: cubit.selectedValue,
                                  onChanged: (value) {
                                    cubit.onChangeValue(value: value as String);
                                  },
                                  buttonHeight: 100,
                                  buttonWidth: double.infinity,
                                  itemHeight: 40,
                                ),
                              )
                            ],
                          )),
                      Step(
                          isActive: cubit.currentStep >= 1,
                          title: const Text('Choose your date'),
                          content: Column(
                            children: [
                              CustomTextFormField(
                                  validator: (value) {},
                                  controller: cubit.dateController,
                                  hintText: 'Select your date',
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050))
                                        .then((value) {
                                      cubit.dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                      // cubit.dateController.text as DateTime= value;
                                      print(value.toString());
                                    }).catchError((error) {
                                      cubit.dateController.clear();
                                      print(error.toString());
                                    });
                                  }),
                              const SizedBox(height: 20.0,),
                              CustomTextFormField(
                                  validator: (value) {},
                                  controller: cubit.timeController,
                                  hintText: 'Select Time',
                                  isDense: true,
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                        .then((value) {
                                      print(value.toString());
                                      cubit.timeController.text = value!.format(context);
                                    }).catchError((error) {
                                      cubit.timeController.clear();
                                    });
                                  }),
                            ],
                          )),
                      Step(
                          isActive: cubit.currentStep >= 2,
                          title: const Text('Add Notes'),
                          content: const Text('This content for Step 3')),
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
