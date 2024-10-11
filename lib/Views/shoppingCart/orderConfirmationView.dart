import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othaim/Controllers/shoppingCartController.dart';
import 'package:othaim/Models/productModel.dart';
import 'package:othaim/Views/homeView.dart';
import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_btn.dart';
import 'package:othaim/widgets/custom_txt.dart';

class OrderConfirmationView extends StatefulWidget {
  const OrderConfirmationView({super.key});

  @override
  _OrderConfirmationViewState createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  final ShoppingCartController cartController =
      Get.find<ShoppingCartController>();

  final List<String> paymentMethods = [
    "Credit Card",
    "Debit Card",
    "PayPal",
    "Cash on Delivery",
  ];

  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomTxt(
          text: "Order Confirmation",
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            SizedBox(height: 20.0.h),
            CustomTxt(
              text: "Ordered Items",
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: cartController.cart.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cart.keys.toList()[index];
                    final quantity = cartController.cart[product];
                    return _buildOrderItem(product, quantity!);
                  },
                );
              }),
            ),
            const Divider(),
            _buildPaymentMethodSelector(),
            SizedBox(height: 20.0.h),
            _buildTotalPrice(),
            SizedBox(height: 20.0.h),
            _buildActionButtons(context),
          ],
        ),
      )),
    );
  }

  Widget _buildOrderHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTxt(text: "Order Number: #12345", fontSize: 12),
        SizedBox(height: 5.0.h),
        CustomTxt(
            text:
                "Order Date: ${DateTime.now().toLocal().toString().split(' ')[0]}",
            fontSize: 12),
        SizedBox(height: 10.0.h),
        CustomTxt(
            text: "Delivery Address:",
            fontWeight: FontWeight.bold,
            fontSize: 12),
        SizedBox(height: 5.0.h),
        CustomTxt(text: "123 Main Street, City, Country", fontSize: 11),
      ],
    );
  }

  Widget _buildOrderItem(ProductModel product, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60.0.w,
            height: 60.0.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0).r,
              child: Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(width: 5.0.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 250.w,
                  child: CustomTxt(
                    text: product.title,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    fontSize: 10,
                  )),
              SizedBox(height: 5.0.h),
              CustomTxt(
                text: 'Quantity: $quantity',
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              const SizedBox(height: 5.0),
              CustomTxt(
                text: 'Price: \$${product.price.toStringAsFixed(2)}',
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTxt(
            text: "Total Price",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          CustomTxt(
              text: "\$${cartController.totalPrice.toStringAsFixed(2)}",
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ],
      );
    });
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTxt(
          text: "Select Payment Method:",
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        SizedBox(height: 5.0.h),
        ...paymentMethods.map((method) {
          return RadioListTile<String>(
            dense: false,
            contentPadding: EdgeInsets.zero,
            title: CustomTxt(
              text: method,
              fontSize: 12,
            ),
            value: method,
            groupValue: selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                selectedPaymentMethod = value!;
              });
            },
          );
        }),
      ],
    );
  }

  void _showPaymentMethodErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomTxt(text: "Payment Method Required"),
          content: CustomTxt(
            text: "Please select a payment method to proceed.",
            fontSize: 12,
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomTxt(
                text: "OK",
                color: kPrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomBtn(
            label: "Confirm Order",
            fontSize: 10,
            onPressed: () {
              if (selectedPaymentMethod == '') {
                _showPaymentMethodErrorDialog(context);
              } else {
                _showConfirmationDialog(context);
              }
            }),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomTxt(text: "Confirm Order"),
          content: CustomTxt(
            text:
                "Are you sure you want to confirm this order with the payment method: $selectedPaymentMethod?",
            fontSize: 12,
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                cartController.clearCart();
                Get.offAll(() => const HomeView());
              },
              child: CustomTxt(
                text: "Yes",
                color: kPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomTxt(
                text: "No",
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
