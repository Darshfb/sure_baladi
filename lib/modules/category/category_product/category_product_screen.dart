import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/modules/category/category_product/item_product.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';


class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key, required this.id, required this.productTitle}) : super(key: key);
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
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getCategoryProduct(id: id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
              title: Text(productTitle),
            ),
            body: SingleChildScrollView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ItemCategoryProduct(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (cubit.lastProduct == false)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.getCategoryProduct(id: id,isRefresh: false);
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
                          onPressed: (){
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
