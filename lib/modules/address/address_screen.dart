import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_cubit.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/component/component.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);
  int? cityId;
  int? districtId;
  String? districtName;
  final commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CheckOutCubit()
        ..getAddress()
        ..getAllCity(),
      child: BlocConsumer<CheckOutCubit, CheckOutStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = CheckOutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Address'.tr()),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Form(
              key: _formKey,
              child: ConditionalBuilder(
                  condition: cubit.cityModel.isNotEmpty,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: Text('Add Address'.tr()),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: 'Choose City'.tr(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      items: cubit.cityModel
                                          .asMap()
                                          .map(
                                            (key, value) => MapEntry(
                                              key,
                                              DropdownMenuItem(
                                                value: value['cityName'],
                                                child: Text(
                                                  value['cityName'],
                                                ),
                                              ),
                                            ),
                                          )
                                          .values
                                          .toList(),
                                      onChanged: (value) {
                                        // selectedREMINDER = int.parse(value.toString());
                                        for (var element in cubit.cityModel) {
                                          if (element['cityName'] == value) {
                                            cityId = element['id'];
                                          }
                                        }
                                        context
                                            .read<CheckOutCubit>()
                                            .getAllDistrict(cityId: cityId!);
                                        debugPrint('$value');
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    if (cityId != null)
                                      if (state is SuccessGetDistrictState)
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: 'Choose District'.tr(),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          items: cubit.district
                                              .asMap()
                                              .map(
                                                (key, value) => MapEntry(
                                                  key,
                                                  DropdownMenuItem(
                                                    value:
                                                        value['districtName'],
                                                    child: Text(
                                                      value['districtName'],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                          onChanged: (value) {
                                            districtName = value as String?;
                                            for (var element
                                                in cubit.district) {
                                              if (element['districtName'] ==
                                                  value) {
                                                districtId = element['id'];
                                              }
                                            }
                                            debugPrint('$districtName');
                                          },
                                        ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    CustomTextFormField(
                                        validator: (value) {
                                          if(value!.isEmpty){
                                            return 'Please add more details about your address.'.tr();
                                          }else if(cityId == null)
                                          {
                                            return 'Please choose your city'.tr();
                                          }else if(districtId ==null)
                                          {
                                           return 'Please choose your district'.tr();
                                          }
                                          return null;
                                        },
                                        controller: commentController,
                                        hintText: 'Your Comment'.tr(),
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        onChanged: (value) {}),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    CustomButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if(districtId != null){
                                            cubit.addNewAddress(
                                              id: districtId.toString(),
                                              street: commentController.text,
                                              context: context,
                                              widget: SureLayout(),
                                            );
                                          }
                                          navigateAndFinish(
                                              context: context,
                                              widget: SureLayout());
                                        }
                                      },
                                      child: Text(
                                        'Add Address'.tr(),
                                      ),
                                      backgroundColor: Colors.blue,
                                      width: double.infinity,
                                      height: 40.0,
                                      textColor: Colors.white,
                                      elevation: 5,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  Container(
                                      height: 100,
                                      color: Colors.white,
                                      width: 3),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.list.length,
                              itemBuilder: (context, index) {
                                var item = cubit.list[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25.0)),
                                  elevation: 5,
                                  clipBehavior:
                                  Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    color: Colors.green,
                                    height: 200,
                                    width: 350,
                                    child: ListTile(
                                      textColor: Colors.white,
                                      title: Column(
                                        children: [
                                          customText(
                                              text: item['street'] +
                                                  ' ' +
                                                  item['districtName'] +
                                                  ' ' +
                                                  item['cityName']
                                                      .toString(),
                                              fontWeight:
                                              FontWeight.w800),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          customText(
                                              text: item['country'],
                                              fontWeight:
                                              FontWeight.w800)
                                        ],
                                      ),
                                      leading: IconButton(
                                          onPressed: () {
                                            cubit.removeAddress(
                                                addressId: item['id']);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          );
        },
      ),
    );
  }
}
