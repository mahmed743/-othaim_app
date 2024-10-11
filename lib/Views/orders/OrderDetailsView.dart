import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othaim/Models/orderModel.dart';
import 'package:othaim/widgets/custom_txt.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTxt(
          text: 'Order Details',
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTxt(
                text: 'Order ID: ${order.id}', fontWeight: FontWeight.bold),
            SizedBox(height: 10.h),
            CustomTxt(
                text: 'Total Price: \$${order.totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 10.h),
            CustomTxt(text: 'Items:', fontWeight: FontWeight.bold),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return CustomTxt(
                  text:
                      '${item.productName} (x${item.quantity}) - \$${item.price.toStringAsFixed(2)}',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
