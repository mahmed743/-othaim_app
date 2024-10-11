import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:othaim/Models/productModel.dart';
import 'package:othaim/services/http_service.dart';
import 'package:dio/dio.dart' as d;

class ProductController extends GetxController {
  HttpService httpService = HttpService();
  RxBool isLoading = false.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxBool isOnline = false.obs;

  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  late Box productCacheBox;
  @override
  void onInit() {
    super.onInit();
    httpService.init();

    connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });

    _checkInitialConnectionStatus();
    initHiveBox();
    getProduct();
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    isLoading(false);
    super.onClose();
  }

  // Initialize Hive cache box
  Future<void> initHiveBox() async {
    productCacheBox = Hive.box('productCacheBox');
  }

  // Check initial connection status
  Future<void> _checkInitialConnectionStatus() async {
    final connectivityResult = await connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void sortProducts(String sortBy) {
    switch (sortBy) {
      case "Price: Low to High":
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Price: High to Low":
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "Alphabetically: A to Z":
        filteredProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Alphabetically: Z to A":
        filteredProducts.sort((a, b) => b.title.compareTo(a.title));
        break;
      default:
        break;
    }
    update();
  }

  // Method to clear sorting and reset products
  void clearSort() {
    filteredProducts.assignAll(products);
    update();
  }

  // Update connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    print("Connectivity result: $result");

    if (result == ConnectivityResult.none) {
      isOnline(false);
      print("Offline mode activated");
    } else {
      isOnline(true);
      print("Online mode activated");
    }
    update();
  }

  // Get product method
  getProduct() async {
    isLoading(true);
    await _checkInitialConnectionStatus();
    if (isOnline.value) {
      // Fetch from API if online
      await _fetchProductsFromApi();
    } else {
      // Fetch from cache if offline
      _fetchProductsFromCache();
    }

    isLoading(false);
    update();
  }

  // Fetch products from API
  Future<void> _fetchProductsFromApi() async {
    try {
      final result =
          await httpService.request(url: "products", method: Method.GET);
      if (result != null && result is d.Response) {
        products.value = (result.data as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        filteredProducts.assignAll(products);

        cacheProducts(products);
      }
    } catch (e) {
      print(e);
    }
  }

  // Fetch products from Hive cache
  void _fetchProductsFromCache() {
    final cachedProducts = productCacheBox.get('products');
    if (cachedProducts != null) {
      products.value = (cachedProducts as List)
          .map((item) => ProductModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      filteredProducts.assignAll(products);
    } else {
      print("No cached products available");
    }
  }

  // Cache products using Hive
  void cacheProducts(RxList<ProductModel> products) {
    final productList = products.map((p) => p.toJson()).toList();
    productCacheBox.put('products', productList);
  }

  // Method to search for products
  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase())),
      );
    }
    update();
  }
}
