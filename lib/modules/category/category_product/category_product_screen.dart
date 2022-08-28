import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/modules/category/category_product/item_mob/item_product_mob.dart';
import 'package:surebaladi/modules/category/category_product/item_tab/item_product_tab.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';
import 'package:surebaladi/shared/utilis/responsive.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key, required this.id, required this.productTitle})
      : super(key: key);
  final String productTitle;
  final int id;
  final controller = ScrollController();

  void scrollUp() {
    double start = 0;
    controller.animateTo(start,
        duration: const Duration(seconds: 3), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // context.read<HomeCubit>().getCategoryProduct(id: id, isRefresh: false);
    return BlocProvider(
      create: (context) => HomeCubit()..getCategoryProduct(id: id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is ChangeCategoryState) {
            context.read<HomeCubit>().isCategoryAdd;
            // print(context.read<HomeCubit>().isCategoryAdd.toString());
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xff119744),
              toolbarHeight: 25.0,
              centerTitle: true,
              leading: const Text(''),
              title: Text(productTitle, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white,),),

            ),
            body: SingleChildScrollView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Responsive(
                    mobile: ItemCategoryProductMob(),
                    desktop: ItemCategoryProductTab(),
                    tablet: ItemCategoryProductTab(),
                  ),
                  // const ItemCategoryProduct(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (cubit.lastProduct == false)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.getCategoryProduct(id: id, isRefresh: false);
                              // print(product.length.toString());
                            },
                            child:  Text(
                              'Load More'.tr(),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      if (cubit.lastProduct == true)
                        FloatingActionButton.small(
                          onPressed: () {
                            scrollUp();
                          },
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(Icons.keyboard_double_arrow_up),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
