import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othaim/Controllers/shoppingCartController.dart';

import 'package:othaim/Views/shoppingCart/orderConfirmationView.dart';
import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_btn.dart';
import 'package:othaim/widgets/custom_txt.dart';
import 'package:othaim/widgets/decrementAndincrement.dart';
import 'package:othaim/widgets/helper.dart';

class ShoppingCartView extends StatelessWidget {
  final ShoppingCartController cartController =
      Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTxt(
          text: 'Shopping Cart',
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            if (cartController.cart.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  confirmationDialog(
                      title: "Clear Cart",
                      textBody:
                          "Are you sure you want to clear the entire cart?",
                      onConfirm: () {
                        cartController.clearCart();
                        Get.back();
                      });
                },
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              if (cartController.cart.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTxt(
                          text: 'Your cart is empty',
                          color: Colors.red,
                          fontSize: 16.sp,
                        ),
                        SizedBox(height: 10.h),
                        CustomBtn(
                          label: 'Continue Shopping',
                          btnColor: kPrimaryColor,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if (cartController.cart.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10.w),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: cartController.cart.length,
                    itemBuilder: (context, index) {
                      final product = cartController.cart.keys.toList()[index];
                      final quantity = cartController.cart[product] ?? 0;

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.r),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            placeholder: (context, url) => Container(
                              width: 50.w,
                              height: 50.h,
                              color: Colors.grey[200],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 50.w,
                              height: 50.h,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.red),
                            ),
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: CustomTxt(
                          text: product.title,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        subtitle: CustomTxt(
                          text: 'Price: \$${product.price.toStringAsFixed(2)}',
                          fontSize: 10.sp,
                        ),
                        trailing: SizedBox(
                          width: 60.w,
                          child: DecrementAndIncrement(
                            canDelete: quantity == 1,
                            increment: () {
                              cartController.adjustProductQuantity(product, 1);
                            },
                            decrement: () {
                              cartController.adjustProductQuantity(product, -1);
                            },
                            productQuantity: quantity,
                          ),
                        ),
                        onLongPress: () {
                          confirmationDialog(
                              title: "Remove Product",
                              textBody:
                                  "Are you sure you want to remove this product from the cart?",
                              onConfirm: () {
                                cartController.removeProductFromCart(product);
                                Get.back();
                              });
                        },
                      );
                    },
                  ),
                ),
              if (cartController.cart.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTxt(
                            text: 'Total Price:',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          Obx(() => CustomTxt(
                                text:
                                    '\$${cartController.totalPrice.value.toStringAsFixed(2)}',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomBtn(
                        label: 'Checkout',
                        btnColor: kPrimaryColor,
                        onPressed: () {
                          Get.to(() => const OrderConfirmationView());
                        },
                      ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
