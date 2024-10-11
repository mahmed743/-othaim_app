import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:othaim/Controllers/productController.dart';
import 'package:othaim/Models/productModel.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as d;
import 'package:othaim/services/http_service.dart';

class MockHttpService extends Mock implements HttpService {}

class MockConnectivity extends Mock implements Connectivity {
  ConnectivityResult _currentResult = ConnectivityResult.wifi;
  final StreamController<ConnectivityResult> _controller =
      StreamController<ConnectivityResult>();

  // Set the current connectivity result
  void setConnectivityResult(ConnectivityResult result) {
    _currentResult = result;
    _controller.add(_currentResult);
  }

  @override
  Future<ConnectivityResult> checkConnectivity() async {
    return _currentResult;
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return _controller.stream;
  }

  // Method to simulate offline condition
  void simulateOffline() {
    setConnectivityResult(ConnectivityResult.none);
  }

  // Method to simulate mobile connectivity
  void simulateMobile() {
    setConnectivityResult(ConnectivityResult.mobile);
  }

  // Method to simulate WiFi connectivity
  void simulateWifi() {
    setConnectivityResult(ConnectivityResult.wifi);
  }

  void dispose() {
    _controller.close();
  }
}

void main() async {
  // Ensure the Hive is initialized before running tests
  TestWidgetsFlutterBinding.ensureInitialized();
  // Create a temporary directory for the Hive box
  final Directory tempDir = Directory.systemTemp.createTempSync();
  Hive.init(tempDir.path);
  final box = await Hive.openBox('productCacheBox');

  // Create an instance of the controller and mock services
  final productController = ProductController();
  productController.productCacheBox = box;

  // Mocking the HttpService
  final mockHttpService = MockHttpService();
  final mockConnectivity = MockConnectivity();

  productController.httpService = mockHttpService;

  productController.connectivity = mockConnectivity;
  setUp(() {
    box.clear();
    mockConnectivity.setConnectivityResult(ConnectivityResult.wifi);
  });

  tearDown(() async {
    // await box.close();
    mockConnectivity.setConnectivityResult(
        ConnectivityResult.wifi); // Simulate initial connectivity
  });

  tearDownAll(() {
    box.close();
    mockConnectivity.dispose(); // Dispose of the connectivity mock
  });

  test('Fetch products from cache when offline', () async {
    // Arrange: Add a product to the box
    final product = ProductModel(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      description: 'A product for testing.',
      category: Category.ELECTRONICS,
      image: 'test_image.png',
      rating: Rating(rate: 4.5, count: 10),
    );

    // Cache the product
    productController.cacheProducts(RxList<ProductModel>([product]));

    // Simulate offline condition
    mockConnectivity.simulateOffline();
    productController.isOnline.value = false;
    // Act: Call the method to fetch products
    await productController.getProduct();

    // Assert: Verify that the cached product is loaded
    expect(productController.products.length, 1);
    expect(productController.products.first.title, 'Test Product');
  });

  test('Fetch products from API when online', () async {
    // Arrange: Mock an API response
    final mockResponse = [
      {
        "id": 1,
        "title": "Test Product",
        "price": 49.99,
        "description": "Test Description",
        "category": "electronics",
        "image": "test_image_1.png",
        "rating": {"rate": 4.0, "count": 10}
      },
    ];

    when(mockHttpService.request(url: "products", method: Method.GET))
        .thenAnswer((_) async => mockResponse);

    // Simulate offline condition
    mockConnectivity.simulateMobile();
    productController.isOnline.value = true;

    // Act: Call the method to fetch products from the API
    await productController.getProduct();

    // Assert: Verify that products are fetched correctly
    expect(productController.products.length, 1);
    expect(productController.products.first.title, 'Test Product');
  });

  test('Search products', () async {
    final productA = ProductModel(
      id: 1,
      title: 'Test Product',
      price: 50.0,
      description: 'First product',
      category: Category.ELECTRONICS,
      image: 'image_a.png',
      rating: Rating(rate: 4.0, count: 5),
    );

    final productB = ProductModel(
      id: 2,
      title: 'Test Product B',
      price: 75.0,
      description: 'Second product',
      category: Category.JEWELERY,
      image: 'image_b.png',
      rating: Rating(rate: 5.0, count: 15),
    );

    productController.cacheProducts(RxList<ProductModel>([productA, productB]));

    // Act: Search for 'e'
    productController.searchProducts('e');

    // Assert: Verify that only the product containing 'e' is returned
    expect(productController.filteredProducts.length, 1);
    expect(productController.filteredProducts.first.title, 'Test Product');
  });
}
