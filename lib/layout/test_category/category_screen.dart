import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/test_category/category_product/category_product_screen.dart';
import 'package:surebaladi/modules/category/category_product/category_product_screen.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';

class TestCategoryScreen extends StatelessWidget {
  TestCategoryScreen({Key? key}) : super(key: key);
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {
      if (state is ChangeCategoryState) {
        context.read<HomeCubit>().isCategoryAdd;
        // print(context.read<HomeCubit>().isCategoryAdd.toString());
      }
    }, builder: (BuildContext context, Object? state) {
      var cubit = HomeCubit.get(context);
      print(context.read<HomeCubit>().isCategoryAdd.toString());
      return context.read<HomeCubit>().isCategoryAdd
          ? widget!
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  // cubit.getCategoryProduct(
                                  //   id: cubit
                                  //       .allCategoriesModel!.content[index].id!,
                                  // );
                                  widget = TestProductsScreen(
                                    id: cubit.allCategoriesModel!
                                        .content[index].id!,
                                    productTitle: cubit.allCategoriesModel!
                                        .content[index].categoryNameAr!,
                                  );
                                  cubit.getProduct();
                                  // context.read<HomeCubit>().getCategoryProduct(id: cubit.allCategoriesModel!.content[index].id!);

                                  // navigateTo(context: context, widget: ProductsScreen(id: cubit.allCategoriesModel!.content[index].id!,productTitle: cubit.allCategoriesModel!.content[index].categoryNameAr!,));
                                },
                                horizontalTitleGap: 50,
                                dense: true,
                                title: Text(
                                    '${cubit.allCategoriesModel!.content[index].categoryNameAr}'),
                                leading: const Icon(IconBroken.buy),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                              const Divider(
                                height: .1,
                                endIndent: 16,
                              )
                            ],
                          ),
                      itemCount: 10),
                ),
                const SizedBox(
                  height: 20.0,
                )
              ],
            );
    });
  }
}
