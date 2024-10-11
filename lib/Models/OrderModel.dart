class OrderModel {
  final String id;
  final double totalPrice;
  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });
}

class OrderItem {
  final String productName;
  final double price;
  final int quantity;

  OrderItem({
    required this.productName,
    required this.price,
    required this.quantity,
  });
}
