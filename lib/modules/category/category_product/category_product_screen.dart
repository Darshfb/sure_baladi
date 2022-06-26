import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/modules/category/category_product/item_product.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getCategoryProduct(id: id)..getCartData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          children: const [
            Expanded(child: ItemCategoryProduct()),
          ],
        ),
      ),
    );
  }
}
