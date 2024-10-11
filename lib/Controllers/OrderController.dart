import 'package:get/get.dart';
import 'package:othaim/Models/orderModel.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 2));
    orders.value = [
      OrderModel(
        id: '12345',
        totalPrice: 29.99,
        items: [
          OrderItem(productName: 'Product 1', price: 9.99, quantity: 1),
          OrderItem(productName: 'Product 2', price: 19.99, quantity: 1),
        ],
      ),
    ];
    isLoading(false);
  }
}
