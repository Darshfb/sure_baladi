import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/layout/test_category/category_screen.dart';
import 'package:surebaladi/modules/category/category_product/item_product.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';


class TestProductsScreen extends StatelessWidget {
  TestProductsScreen({Key? key, required this.id, required this.productTitle})
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
        if(state is ChangeCategoryState){
          context.read<HomeCubit>().isCategoryAdd;
          // print(context.read<HomeCubit>().isCategoryAdd.toString());
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ItemCategoryProduct(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (cubit.lastProduct == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          cubit.getCategoryProduct(
                              id: id, isRefresh: false);
                          // print(product.length.toString());
                        },
                        child: const Text(
                          'Load More',
                          style: TextStyle(
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
        );
      },
    ),
);
  }
}
