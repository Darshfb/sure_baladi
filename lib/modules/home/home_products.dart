import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var product = HomeCubit.get(context).content;
        if (cubit.homeModel != null) {
          return ConditionalBuilder(
              condition: product.isNotEmpty,
              builder: (context) => Column(
                    children: [
                      GridView.builder(
                          itemCount: product.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.1 / 1.6,
                                  mainAxisExtent: 295),
                          itemBuilder: (context, index) {
                            var itemInCart =
                                cubit.isProductInCard(product[index]);
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, bottom: 3, right: 5, left: 5),
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context).size.width,
                                            height: 140,
                                            imageUrl: product[index].productImage!,
                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => const Image(image: AssetImage('assets/images/sure_logo.png')),
                                          ),

                                          // FadeInImage.assetNetwork(
                                          //   fit: BoxFit.contain,
                                          //   placeholder:
                                          //       'assets/images/loading.gif',
                                          //   width: MediaQuery.of(context)
                                          //       .size
                                          //       .width,
                                          //   height: 140,
                                          //   image:
                                          //       '${product[index].productImage}',
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${product[index].productName}',
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemSize: 18,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        if (kDebugMode) {
                                          print(rating);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${product[index].quantityType}',
                                          style: const TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                        const Text('/'),
                                        Text(
                                          '${product[index].price}',
                                          style: const TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    (itemInCart == null)
                                        ? CustomButton(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            width: double.infinity,
                                            height: 35,
                                            onPressed: () {
                                              cubit.increaseAddToCart(
                                                  id: product[index].id!);
                                            },
                                            child: Text('Add'.tr()),
                                          )
                                        : Row(
                                          children: [
                                            FloatingActionButton.small(
                                              elevation: 5,
                                              backgroundColor: Colors.red,
                                              onPressed: () {
                                                cubit.removeFromCart(
                                                    id: product[index]
                                                        .id!);
                                              },
                                              child: const Icon(
                                                IconBroken.delete, color: Colors.white,),
                                            ),
                                            Expanded(
                                              child: Card(
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
                                                            id: product[index]
                                                                .id!
                                                        );
                                                      },
                                                      child: const Icon(
                                                          Icons.remove),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        itemInCart.quantity
                                                            .toString(),
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
                                                        cubit
                                                            .increaseAddToCart(
                                                            id: product[
                                                            index]
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
                                            ),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (cubit.last == false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                onPressed: () {
                                  cubit.getHomeProductData(isRefresh: false, context: context);
                                  // print(product.length.toString());
                                },
                                child: Text(
                                  'Load More'.tr(),
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          if (cubit.last!)
                          FloatingActionButton.small(
                            onPressed: onPressed,
                            backgroundColor: AppColors.primaryColor,
                            child: const Icon(Icons.keyboard_double_arrow_up),
                          )
                        ],
                      )
                    ],
                  ),
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 600.0,),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              ));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 600.0,),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }
      },
    );
  }
}
