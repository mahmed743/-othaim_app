# Othaim - eCommerce Flutter App

Welcome to Othaim, a Flutter-based eCommerce application designed to provide a smooth and modern shopping experience. Whether you're a beginner or an advanced developer, this project can be a great starting point or reference for building scalable and efficient mobile applications.
<br>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/1.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/2.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/3.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/4.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/5.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/6.png" width="15%"></img>
<img src="https://github.com/mahmed743/-othaim_app/blob/master/screenshot/7.png" width="15%"></img>
<br>
# App Structure
* lib/ <br>
    config/   <br>
- app_color.dart<br>
    controllers/
	   <br>
	- OrderController.dart<br>
	- proderController.dart<br>
	- shoppingController.dart<br>
	models/
	 <br>
	- orderModel.dart<br>
	- prodeuctMode.dart<br>
	services/
	 <br>
	- http_sevice.dart<br>
	view/
	 <br>
	- orders /<br>
		- OrderListView.dart <br>
		- OrderDetailsView.dart <br>
	 - profile /<br>
		- profileView.dart<br>
	  - shoppingCart <br>
		- orderConfirmationView.drt <br>
		- ShoppingCartView.drt <br>
	widgets/
	main.dart


## **Installation**

To install Project Title, follow these steps:

1. Clone the repository: **`https://github.com/mahmed743/-othaim_app.git`**
2. Navigate to the project directory: **`cd -othaim_app`**
3. Install dependencies: **`flutter pub get`**
4. Build the project: **`flutter run`**


## **Unit tests and TDD**
1. Product Management
Test Files: productController_test.dart

Coverage:

Offline Product Fetching: When the app is offline, it retrieves products from the local cache using Hive. Tests cover the scenario where a product is cached and fetched correctly while offline.
Online Product Fetching: The app fetches products from an API when online. Unit tests mock the API response and verify that the products are correctly populated in the controller.
Product Searching: Unit tests check whether the search functionality works as expected by filtering the cached products based on user input.
TDD Approach: For fetching products both online and offline, the tests were written first. This ensured that both caching mechanisms and the API fetching logic were implemented to satisfy the test cases. This provided better assurance that the product retrieval logic works under different conditions (online/offline).

2. Shopping Cart Management
Test Files: shoppingCartController_test.dart

Coverage:

Add to Cart: Tests cover the behavior when products are added to the shopping cart. It verifies that product quantities and total prices are updated correctly.
Adjust Quantity: Unit tests ensure that adjusting the quantity of a product in the cart works as expected, and total price is recalculated accordingly.
Remove from Cart: This test ensures that a product can be successfully removed from the shopping cart and that both the cart and total price are updated.
Clear Cart: Verifies that clearing the cart results in an empty cart and a total price of zero.
Total Price Calculation: Tests ensure that the total price is calculated accurately based on the quantities and prices of the items in the cart.
TDD Approach: For the shopping cart functionality, tests were written before the implementation of each feature. The initial tests for adding, adjusting, and removing products were created to define the desired behavior, and the implementation was carried out to ensure these tests passed.
## **packages**
- dio ^5.7.0 : Dio is a powerful HTTP client for Dart, offering features like interceptors, global configuration, form data, request cancellation, and file downloading.
- dbadges: ^3.1.2 : This package allows you to add badges to widgets, useful for displaying notifications or counts.
- flutter_screenutil: ^5.9.3 : This package is designed to help with responsive design by providing a way to scale UI elements based on screen size.
- iconly: ^1.0.1 : Iconly provides a set of beautifully designed icons that can be easily integrated into Flutter applications.
- hive: ^2.0.0 :  Hive is a lightweight and fast key-value database for Flutter, ideal for local storage.
- hive_flutter: ^1.0.0 : This package adds Flutter-specific functionality to Hive, such as support for listening to data changes.
- connectivity_plus: ^3.0.0 : This package allows you to check the device's internet connectivity and listen for changes in connectivity status.
-  path_provider: ^2.1.4 : This package provides a platform-agnostic way to access commonly used locations on the device's filesystem, such as the temp and app documents directory.
-  cached_network_image: ^3.2.1 : This package allows you to cache images fetched from the internet to improve loading times and reduce data usage.



  <br>
    controllers/
	models/
	services/
	view/
	widgets/
	main.dart

- dio ^5.7.0 : Dio is a powerful HTTP client for Dart, offering features like interceptors, global configuration, form data, request cancellation, and file downloading.
- dbadges: ^3.1.2 : This package allows you to add badges to widgets, useful for displaying notifications or counts.
- flutter_screenutil: ^5.9.3 : This package is designed to help with responsive design by providing a way to scale UI elements based on screen size.
- iconly: ^1.0.1 : Iconly provides a set of beautifully designed icons that can be easily integrated into Flutter applications.
- hive: ^2.0.0 :  Hive is a lightweight and fast key-value database for Flutter, ideal for local storage.
- hive_flutter: ^1.0.0 : This package adds Flutter-specific functionality to Hive, such as support for listening to data changes.
- connectivity_plus: ^3.0.0 : This package allows you to check the device's internet connectivity and listen for changes in connectivity status.
-  path_provider: ^2.1.4 : This package provides a platform-agnostic way to access commonly used locations on the device's filesystem, such as the temp and app documents directory.
-  cached_network_image: ^3.2.1 : This package allows you to cache images fetched from the internet to improve loading times and reduce data usage.


