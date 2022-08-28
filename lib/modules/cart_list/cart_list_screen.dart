import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/modules/cart_list/checkout.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getCartData();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {
        if(state is ErrorCartState){
          CacheHelper.clearData(token);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = HomeCubit.get(context);
        if(CacheHelper.getData(key: token) != null){
          if (cubit.cartModels != null) {
            return ConditionalBuilder(
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
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 140,
                                        imageUrl: cubit
                                            .cartModels!
                                            .cartItems[index]
                                            .product!
                                            .productImage!,
                                        placeholder: (context, url) =>
                                        const Center(
                                            child:
                                            CircularProgressIndicator()),
                                        errorWidget: (context, url,
                                            error) =>
                                        const Image(
                                            image: AssetImage(
                                                'assets/images/sure_logo.png')),
                                      ),

                                      // FadeInImage.assetNetwork(
                                      //   fit: BoxFit.contain,
                                      //   placeholder:
                                      //       'assets/images/loading.gif',
                                      //   width: 120,
                                      //   height: 140,
                                      //   image: cubit
                                      //       .cartModels!
                                      //       .cartItems[index]
                                      //       .product!
                                      //       .productImage
                                      //       .toString(),
                                      // ),
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
                                              .productName
                                              .toString()),
                                          Text('Price - per one'.tr()),
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
                                                  width:
                                                  MediaQuery.of(context)
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
                                                            cubit.decreaseAddToCart(
                                                                id: cubit
                                                                    .cartModels!
                                                                    .cartItems[
                                                                index]
                                                                    .product!
                                                                    .id!);
                                                          },
                                                          child: const Icon(
                                                              Icons.remove),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            '${cubit.cartModels!.cartItems[index].quantity}',
                                                            style:
                                                            const TextStyle(
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
                                                            cubit.increaseAddToCart(
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
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            )),
                        height: 75,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextButton(onPressed: (){
                                navigateTo(
                                    context: context,
                                    widget: CheckOut());
                              }, text: 'Proceed To Checkout'.tr(),
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              color: AppColors.primaryColor,
                              height: double.infinity,
                              width: 2.0,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${cubit.cartModels!.total}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    'SAR'.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) => Center(
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
                        'No Items in the cart, Please add some!'.tr(),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return  Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 100.0,),
                CircularProgressIndicator(),
              ],
            ),);
          }
        }else{
          return  Center(
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
                  'No Items in the cart, Please add some!'.tr(),
                  style: Theme.of(context).textTheme.caption!.copyWith(
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
  }
}
