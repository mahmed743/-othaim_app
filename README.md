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
lib/
│
├── config/             # Configuration files for routing, themes, and global settings
│   ├── app_routes.dart    # Defines named routes for the app
│   ├── app_theme.dart     # Theme data (colors, fonts, styles)
│
├── controllers/        # Controllers for state management (e.g., GetX or other providers)
│   ├── auth_controller.dart  # Handles authentication logic and state
│   ├── home_controller.dart  # Manages the home screen state and logic
│
├── models/             # Data models representing the structure of data used in the app
│   ├── user_model.dart     # User model, representing user-related data
│   ├── product_model.dart  # Product model, representing product-related data
│
├── services/           # Services like API calls, local storage, or other business logic
│   ├── api_service.dart     # Handles network requests using Dio
│   ├── storage_service.dart # Manages local data storage (Hive, SharedPreferences)
│
├── view/               # The UI screens of the app (e.g., login, dashboard, profile)
│   ├── login_view.dart      # UI for the login screen
│   ├── home_view.dart       # UI for the home screen
│   ├── profile_view.dart    # UI for the profile screen
│
├── widgets/            # Reusable UI components like buttons, forms, etc.
│   ├── custom_button.dart   # A custom button widget
│   ├── app_drawer.dart      # A drawer widget for navigation
│
└── main.dart           # Entry point of the application

- dio ^5.7.0 : Dio is a powerful HTTP client for Dart, offering features like interceptors, global configuration, form data, request cancellation, and file downloading.
- dbadges: ^3.1.2 : This package allows you to add badges to widgets, useful for displaying notifications or counts.
- flutter_screenutil: ^5.9.3 : This package is designed to help with responsive design by providing a way to scale UI elements based on screen size.
- iconly: ^1.0.1 : Iconly provides a set of beautifully designed icons that can be easily integrated into Flutter applications.
- hive: ^2.0.0 :  Hive is a lightweight and fast key-value database for Flutter, ideal for local storage.
- hive_flutter: ^1.0.0 : This package adds Flutter-specific functionality to Hive, such as support for listening to data changes.
- connectivity_plus: ^3.0.0 : This package allows you to check the device's internet connectivity and listen for changes in connectivity status.
-  path_provider: ^2.1.4 : This package provides a platform-agnostic way to access commonly used locations on the device's filesystem, such as the temp and app documents directory.
-  cached_network_image: ^3.2.1 : This package allows you to cache images fetched from the internet to improve loading times and reduce data usage.


