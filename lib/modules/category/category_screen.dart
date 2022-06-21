import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290,
      child: SafeArea(
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            var cubit = HomeCubit.get(context);
            return Column(
              children: [
                Container(
                  height: 50,
                  color: AppColors.primaryColor,
                  width: double.infinity,
                  child: const Center(
                    child: Text('All Categories', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                        textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            onTap: () {},
                            horizontalTitleGap: 25,
                            dense: true,
                            title: Text('${cubit.allCategoriesModel!.content[index].categoryNameAr}'),
                            leading: const Icon(Icons.factory),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                          const Divider(height: .1,endIndent: 16,)
                        ],
                      ),
                      itemCount: 10),
                ),
              ],
            );
          },
        ),
              ),
    );
  }
}
