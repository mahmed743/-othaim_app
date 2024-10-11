// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:othaim/Models/productModel.dart';

import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_btn.dart';
import 'package:othaim/widgets/custom_txt.dart';
import 'package:othaim/widgets/decrementAndincrement.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function increment;
  final Function decrement;
  final Function addProductToCart;
  const ProductCard(
      {super.key,
      required this.product,
      required this.increment,
      required this.decrement,
      required this.addProductToCart});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Card(
        elevation: 2.0,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0).r,
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 5.r),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: const Radius.circular(12.0).r),
                  child: CachedNetworkImage(
                    height: 80.h,
                    imageUrl: product.image,
                    placeholder: (context, url) => const Center(
                        child:
                            CircularProgressIndicator()), // Show a loader while fetching
                    errorWidget: (context, url, error) => const Icon(Icons
                        .error), // Show an error widget if the image can't be loaded
                    cacheKey: product
                        .image, // Optional, to ensure the same key is used for this image
                    fit: BoxFit
                        .cover, // To make sure the image fits well in the UI
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTxt(
                      text: product.title,
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                  SizedBox(height: 4.0.h),
                  CustomTxt(
                    text: '\$${product.price.toStringAsFixed(2)}',
                    fontSize: 11.0.sp,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8.0.h),
                  product.qty > 0
                      ? DecrementAndIncrement(
                          canDelete: product.qty == 1,
                          increment: () => increment(),
                          decrement: () => decrement(),
                          productQuantity: product.qty)
                      : Align(
                          alignment: Alignment.center,
                          child: CustomBtn(
                              label: 'Add to Cart',
                              onPressed: () => addProductToCart()))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
