import 'package:get/get.dart';

import 'package:othaim/Models/productModel.dart';

class ShoppingCartController extends GetxController {
  RxBool isLoading = false.obs;
  RxMap<ProductModel, int> cart = <ProductModel, int>{}.obs;

  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    calculateTotalPrice();
  }

  void adjustProductQuantity(ProductModel product, int qty) {
    isLoading(true);
    if (cart.containsKey(product)) {
      if (qty > 0) {
        cart[product] = cart[product]! + qty;
        product.qty += qty;
      } else if (qty < 0) {
        if (cart[product]! + qty > 0) {
          cart[product] = cart[product]! + qty;
          product.qty += qty;
        } else {
          cart.remove(product);
          product.qty = 0;
        }
      }
    } else if (qty > 0) {
      cart[product] = qty;
      product.qty += qty;
    }
    calculateTotalPrice();
    isLoading(false);
  }

  // Clear all items from the cart
  void clearCart() {
    isLoading(true);
    var productsInCart = List<ProductModel>.from(cart.keys);

    for (var product in productsInCart) {
      adjustProductQuantity(product, -cart[product]!);
    }
    cart.clear();
    calculateTotalPrice();
    isLoading(false);
  }

  // Remove product from cart
  void removeProductFromCart(ProductModel product) {
    isLoading(true);
    adjustProductQuantity(product, -cart[product]!);
    cart.remove(product);
    calculateTotalPrice();
    isLoading(false);
  }

  // Calculate total price of all items in the cart
  void calculateTotalPrice() {
    double total = 0.0;
    cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    totalPrice.value = total;
  }

  // Function to get the number of items in the cart
  int get cartItemCount => cart.length;
}
