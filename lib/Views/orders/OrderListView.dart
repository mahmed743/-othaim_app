import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othaim/Controllers/OrderController.dart';
import 'package:othaim/Views/orders/OrderDetailsView.dart';
import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_btn.dart';
import 'package:othaim/widgets/custom_txt.dart';

class OrderListView extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: CustomTxt(
          text: 'Order History',
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (orderController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderController.orders.isEmpty) {
            return Center(
              child: CustomTxt(
                text: 'No Orders Found',
                color: Colors.red,
              ),
            );
          }

          return ListView.separated(
            itemCount: orderController.orders.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final order = orderController.orders[index];

              return ListTile(
                title: CustomTxt(
                  text: 'Order #${order.id}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomTxt(
                  text: 'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                  fontSize: 11.sp,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBtn(
                      label: 'View Details',
                      onPressed: () {
                        Get.to(OrderDetailsView(order: order));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
