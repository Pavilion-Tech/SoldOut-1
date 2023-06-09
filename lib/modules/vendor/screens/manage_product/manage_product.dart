import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../buyer/widgets/sort/suffix.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/manage_product_widgets/vendor_product_item.dart';

class VendorManageProductList extends StatelessWidget {

  Suffix? suffix;



  @override
  Widget build(BuildContext context) {
    var currentAspectRatio =  size!.height > 670 ?2.1:1.8;
    suffix = Suffix(apply: () {
      VendorCubit.get(context).getProducts(
          text: VendorCubit.get(context).searchController.text.trim(),
          sort: suffix!.sort!.sortValue,
          page: VendorCubit.get(context).pageProduct,
      );
      Navigator.pop(context);
    });
    return Scaffold(
      body: BlocConsumer<VendorCubit, VendorStates>(
        listener: (context, state) {
          if(isConnect!=null)checkNet(context);
        },
        builder: (context, state) {
          var cubit = VendorCubit.get(context);
          return SingleChildScrollView(
            controller: cubit.scrollController,
            child: InkWell(
              onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Stack(
                children: [
                  myAppBar(
                      context: context,
                      title: tr('manage_products'),
                      isArrowBack: true,
                    arrowTap: (){
                        cubit.pageProduct = 1;
                        cubit.scrollController.removeListener(() {});
                        Navigator.pop(context);
                    }
                  ),
                  ConditionalBuilder(
                    condition: cubit.listProductModel != null,
                    fallback: (context) => GridViewLoading(),
                    builder: (context) {
                      cubit.getMoreForProducts();
                      return MyContainer(
                          noSize: true,
                               Column(
                                  children: [
                                    defaultTextField(
                                        controller: cubit.searchController,
                                        hint: tr('search_by_product'),
                                        suffix:suffix,
                                        onChanged: (String? value) {
                                          if (value!.length > 1) {
                                            cubit.pageProduct = 1;
                                            cubit.getProducts(text: value,);
                                          }
                                          if(value.length < 2)
                                          {
                                            cubit.pageProduct = 1;
                                            cubit.getProducts();
                                          }
                                        }
                                    ),
                                    cubit.listProductModel!.data!.products!.isNotEmpty?
                                    GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      childAspectRatio: size!.width / (size!.height / currentAspectRatio),
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2,
                                      children: List.generate(
                                        cubit.listProductModel!.data!.products!.length,
                                        (index) => VProductItem(
                                          productModel: cubit.listProductModel!.data!.products![index],
                                        ),
                                      ),
                                    ): Column(
                                      children: [
                                        SizedBox(
                                          height: size!.height * .3,
                                        ),
                                        Text(tr('no_items_yet')),
                                      ],
                                    ),
                                    if(state is GetProductLoadingState)
                                      const CircularProgressIndicator(),
                                    const SizedBox(height: 40,),
                                    defaultButton(
                                        onTap: () {
                                          Navigator.pop(context);
                                          VendorCubit.get(context).changeIndex(2);
                                        },
                                        text: tr('add_new'))
                                  ],
                                )
                              );
                    },
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
