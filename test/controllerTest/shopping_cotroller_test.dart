import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:othaim/Controllers/shoppingCartController.dart';
import 'package:othaim/Models/productModel.dart';

void main() {
  late ShoppingCartController shoppingCartController;

  setUp(() {
    shoppingCartController = ShoppingCartController();
  });

  group('ShoppingCartController Tests', () {
    test('Add product to cart', () {
      final product = ProductModel(
        id: 1,
        title: 'Test Product',
        price: 100.0,
        description: 'A test product',
        category: Category.ELECTRONICS,
        image: 'image.png',
        qty: 0,
        rating: Rating(rate: 4.5, count: 10),
      );

      shoppingCartController.adjustProductQuantity(
          product, 2); // Add 2 of the product

      expect(shoppingCartController.cart[product],
          2); // Check if product quantity is 2
      expect(product.qty, 2); // Product model quantity should also be updated
      expect(shoppingCartController.totalPrice.value,
          200.0); // Total price should be 200
    });

    test('Adjust product quantity in cart', () {
      final product = ProductModel(
        id: 2,
        title: 'Another Product',
        price: 50.0,
        description: 'Another test product',
        category: Category.MEN_S_CLOTHING,
        image: 'another_image.png',
        qty: 0, // Initial quantity
        rating: Rating(rate: 4.0, count: 5),
      );

      shoppingCartController.adjustProductQuantity(product, 5);
      shoppingCartController.adjustProductQuantity(product, -3);

      expect(shoppingCartController.cart[product],
          2); // Check if product quantity is 2
      expect(product.qty, 2); // Product model quantity should also be updated
      expect(shoppingCartController.totalPrice.value,
          100.0); // Total price should be 100
    });

    test('Remove product from cart', () {
      final product = ProductModel(
        id: 3,
        title: 'Product to Remove',
        price: 30.0,
        description: 'This product will be removed',
        category: Category.JEWELERY,
        image: 'remove_image.png',
        qty: 0, // Initial quantity
        rating: Rating(rate: 3.5, count: 8),
      );

      shoppingCartController.adjustProductQuantity(product, 3); // Add 3 to cart
      shoppingCartController.removeProductFromCart(product); // Remove from cart

      expect(shoppingCartController.cart.containsKey(product),
          false); // Should not be in cart
      expect(product.qty, 0); // Product quantity should be 0
      expect(shoppingCartController.totalPrice.value,
          0.0); // Total price should be 0
    });

    test('Clear cart', () {
      final product1 = ProductModel(
        id: 4,
        title: 'Product 1',
        price: 20.0,
        description: 'First product in cart',
        category: Category.ELECTRONICS,
        image: 'product1_image.png',
        qty: 0,
        rating: Rating(rate: 4.5, count: 10),
      );

      final product2 = ProductModel(
        id: 5,
        title: 'Product 2',
        price: 40.0,
        description: 'Second product in cart',
        category: Category.ELECTRONICS,
        image: 'product2_image.png',
        qty: 0,
        rating: Rating(rate: 4.5, count: 10),
      );

      shoppingCartController.adjustProductQuantity(
          product1, 1); // Add 1 of product1
      shoppingCartController.adjustProductQuantity(
          product2, 2); // Add 2 of product2

      shoppingCartController.clearCart(); // Clear the cart

      expect(shoppingCartController.cart.isEmpty, true); // Cart should be empty
      expect(shoppingCartController.totalPrice.value,
          0.0); // Total price should be 0
    });

    test('Calculate total price correctly', () {
      final product = ProductModel(
        id: 6,
        title: 'Price Test Product',
        price: 25.0,
        description: 'A product to test total price',
        category: Category.ELECTRONICS,
        image: 'price_test_image.png',
        qty: 0,
        rating: Rating(rate: 4.2, count: 7),
      );

      shoppingCartController.adjustProductQuantity(product, 4); // Add 4 to cart

      expect(shoppingCartController.totalPrice.value,
          100.0); // Total should be 100 (25 * 4)
    });
  });
}
