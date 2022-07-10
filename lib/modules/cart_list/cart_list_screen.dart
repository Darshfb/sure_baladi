import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return BlocConsumer<HomeCubit, HomeStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              var cubit = HomeCubit.get(context);
              if (cubit.cartModels != null &&
                  cubit.cartModels!.cartItems.isNotEmpty) {
                return ConditionalBuilder(
                  //This Condition here for the list to make the card still there
                  // if i click on decrease or increase
                    condition: cubit.cartModels!.cartItems.isNotEmpty,
                    builder: (context) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: cubit.cartModels!.cartItems.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  shadowColor: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  child: SizedBox(
                                    height: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: FadeInImage.assetNetwork(
                                            fit: BoxFit.contain,
                                            placeholder:
                                            'assets/images/loading.gif',
                                            width: 120,
                                            height: 140,
                                            image: cubit
                                                .cartModels!
                                                .cartItems[index]
                                                .product!
                                                .productImage
                                                .toString(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(cubit
                                                  .cartModels!
                                                  .cartItems[index]
                                                  .product!
                                                  .productNameAr
                                                  .toString()),
                                              const Text('Price - per one'),
                                              Text(cubit.cartModels!
                                                  .cartItems[index].price
                                                  .toString()),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Card(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5.0)),
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          3.2,
                                                      height: 30,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                            FloatingActionButton(
                                                              backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                              shape:
                                                              const RoundedRectangleBorder(
                                                                side:
                                                                BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                cubit
                                                                    .decreaseAddToCart(
                                                                    id: cubit
                                                                        .cartModels!
                                                                        .cartItems[
                                                                    index]
                                                                        .product!
                                                                        .id!);
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .remove),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                '${cubit
                                                                    .cartModels!
                                                                    .cartItems[index]
                                                                    .quantity}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                    15),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                            FloatingActionButton(
                                                              backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                              shape:
                                                              const RoundedRectangleBorder(
                                                                side:
                                                                BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                cubit
                                                                    .increaseAddToCart(
                                                                    id: cubit
                                                                        .cartModels!
                                                                        .cartItems[
                                                                    index]
                                                                        .product!
                                                                        .id!);
                                                              },
                                                              child: const Icon(
                                                                  Icons.add),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft:const Radius.circular(25.0), topRight:const Radius.circular(25.0),)),
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0, left: 10.0),

                                    child: InkWell(
                                      onTap: () {

                                      },
                                      child: const SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          child: Text(
                                            'Proceed To Checkout',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: double.infinity,
                                  width: 1.5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${cubit.cartModels!.total}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15.0,
                                        ),
                                        const Text(
                                          'ريال',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    fallback: (context) =>
                    const Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_rounded,
                        color: AppColors.primaryColor,
                        size: 75,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No Items in the cart, Please add some!',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        });
  }
}
