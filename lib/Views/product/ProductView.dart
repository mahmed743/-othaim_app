import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:othaim/Controllers/productController.dart';
import 'package:othaim/Controllers/shoppingCartController.dart';
import 'package:othaim/Views/shoppingCart/ShoppingCartView.dart';
import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/ProductCard.dart';

import 'package:othaim/widgets/custom_txt.dart';
import 'package:badges/badges.dart' as badges;

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductController productController = Get.put(ProductController());
  final ShoppingCartController cartController =
      Get.put(ShoppingCartController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value || cartController.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        ));
      }
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: CustomTxt(
              text: "Product",
              fontSize: 20,
              color: Colors.white,
            ),
            actions: [
              Obx(() => cartController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ))
                  : badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: cartController.cart.isEmpty ? false : true,
                      ignorePointer: false,
                      onTap: () {
                        if (cartController.cart.isNotEmpty) {
                          Get.to(ShoppingCartView());
                        }
                      },
                      badgeContent: CustomTxt(
                        text: cartController.cartItemCount.toString(),
                        color: Colors.white,
                      ),
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: Colors.red,
                        padding: const EdgeInsets.all(3).r,
                        borderRadius: BorderRadius.circular(3).r,
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ))
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                await productController.getProduct();
              },
              child: SafeArea(
                  child: CustomScrollView(slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  title: Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              productController.searchProducts(value);
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(10).r),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(10).r),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20)
                                  .r,
                              hintText: "Search E.g iPhone X",
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5.0).r,
                            child: Container(
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: IconButton(
                                  icon: const Icon(
                                    Icons.filter_list,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    _showSortOptions();
                                  },
                                )))),
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final product = productController.filteredProducts[index];

                      return ProductCard(
                          product: product,
                          increment: () {
                            cartController.adjustProductQuantity(product, 1);
                          },
                          decrement: () {
                            cartController.adjustProductQuantity(product, -1);
                          },
                          addProductToCart: () {
                            cartController.adjustProductQuantity(product, 1);
                          });
                    },
                    childCount: productController.filteredProducts.value.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                ),
              ]))));
    });
  }

  void _showSortOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16).r,
        height: 300.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10).r,
                topRight: const Radius.circular(10).r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTxt(
                text: "Sort By", fontSize: 16.sp, fontWeight: FontWeight.bold),
            SizedBox(height: 10.h),
            ListTile(
              title: CustomTxt(text: "Price: Low to High"),
              onTap: () {
                productController.sortProducts("Price: Low to High");
                Get.back();
              },
            ),
            ListTile(
              title: CustomTxt(text: "Price: High to Low"),
              onTap: () {
                productController.sortProducts("Price: High to Low");
                Get.back();
              },
            ),
            ListTile(
              title: CustomTxt(text: "Alphabetically: A to Z"),
              onTap: () {
                productController.sortProducts("Alphabetically: A to Z");
                Get.back();
              },
            ),
            ListTile(
              title: CustomTxt(text: "Alphabetically: Z to A"),
              onTap: () {
                productController.sortProducts("Alphabetically: Z to A");
                Get.back();
              },
            ),
            ListTile(
              title: CustomTxt(text: "Clear Sort"),
              onTap: () {
                productController.clearSort();
                Get.back();
              },
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }
}
