import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = HomeCubit.get(context);
        if (cubit.homeModel != null) {
          return ConditionalBuilder(
              condition: state is! HomeProductLoadingState,
              builder: (context) => GridView.builder(
                  itemCount: (cubit.homeModel!.content.isNotEmpty)
                      ? cubit.homeModel!.content.length
                      : 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1 / 1.6,
                      mainAxisExtent: 295),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, right: 5, left: 5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.contain,
                                    placeholder: 'assets/images/loading.gif',
                                    width: MediaQuery.of(context).size.width,
                                    height: 140,
                                    image:
                                        '${cubit.homeModel!.content[index].productImage}',
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${cubit.homeModel!.content[index].productNameAr}',
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${cubit.homeModel!.content[index].quantityType}',
                                  style: const TextStyle(
                                      color: AppColors.primaryColor),
                                ),
                                const Text('/'),
                                Text(
                                  '${cubit.homeModel!.content[index].price}',
                                  style: const TextStyle(
                                      color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            (!cubit.isAdded)
                                ? CustomButton(
                                    backgroundColor: AppColors.primaryColor,
                                    width: double.infinity,
                                    height: 35,
                                    onPressed: () {
                                      cubit.increaseAddToCart(id: cubit.homeModel!.content[index].id!);
                                    },
                                    child: const Text('Add'),
                                  )
                                : Card(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {},
                                              child: const SizedBox(
                                                  width: 20,
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  cubit.increaseAddToCart(id: cubit.homeModel!.content[index].id!);
                                                },
                                                child: const Icon(Icons.add)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            '1',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                cubit.decreaseAddToCart(id: cubit.homeModel!.content[index].id!);
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: const Icon(
                                                      Icons.minimize)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // Expanded(child: CustomButton(onPressed: (){}, child: const Icon(Icons.add),)),
                                          // Text('1'),
                                          // Expanded(child: CustomButton(onPressed: (){}, child: Container(
                                          //     margin: const EdgeInsets.only(bottom: 10),
                                          //     child: const Icon(Icons.minimize)),)),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
