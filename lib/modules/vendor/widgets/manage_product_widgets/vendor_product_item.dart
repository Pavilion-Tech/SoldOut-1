import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../widgets/image_net.dart';
import '../../screens/manage_product/edit_product.dart';
import '../../screens/manage_product/vendor_product_screen.dart';

class VProductItem extends StatelessWidget {


  VProductItem({
    required this.productModel,
  });

  ProductModel productModel;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            navigateTo(context, VProductScreen(productModel: productModel,));
          },
          child: Container(
            height: size!.height * .18,
            width: size!.width * .5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                color: defaultColorTwo,
                borderRadius: BorderRadiusDirectional.circular(14),
                border: Border.all(
                    color: Colors.blue.shade100.withOpacity(.5)
                )
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size!.height * .11,
                  width: size!.width * .5,
                  child: ImageNet(image: productModel.images![0].image!,),
                ),
                if(size!.height>670)
                SizedBox(height: size!.height * .009,),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                            fontSize: size!.height>670 ?14:12,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: size!.height > 670 ? size!.height * .05:size!.height * .06,
                            width: size!.width * .25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  initialRating: productModel.rate!.toDouble(),
                                  itemSize: 10,
                                  direction: Axis.horizontal,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  allowHalfRating: true,
                                  unratedColor: HexColor('#FFE000'),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, index) {
                                    if (productModel.rate! > index) {
                                      return Image.asset(BuyerImages.fullStar);
                                    } else {
                                      return const Icon(
                                        Icons.star_border, size: 16,);
                                    }
                                  },
                                  onRatingUpdate: (rating) {},
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${productModel.salePrice??productModel.regularPrice}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: defaultColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if(productModel.salePrice !=null)
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          '${productModel.regularPrice}',
                                          style:const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 7,
                                              decoration: TextDecoration.lineThrough
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () =>
                                navigateTo(
                                  context,
                                  EditProduct(
                                      productModel: productModel
                                  ),
                                ),
                            child: SizedBox(
                              height: 45,
                              width: 45,
                              child: ClipPolygon(
                                sides: 4,
                                borderRadius: 15,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color: defaultColor,
                                  child: const Icon(
                                    Icons.edit,
                                    color: defaultColorTwo, size: 12,
                                  ),
                                ),
                              ),
                            ),
                          )
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
    );
  }
}
