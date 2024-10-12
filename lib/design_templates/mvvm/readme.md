structure of MVVM:

        lib/
        ├── models/
        │    ├── user.dart
        │    ├── product.dart
        │    └── cart_item.dart
        ├── viewmodels/
        │    ├── user_viewmodel.dart
        │    ├── product_viewmodel.dart
        │    └── cart_viewmodel.dart
        ├── repositories/
        │    ├── user_repository.dart
        │    ├── product_repository.dart
        │    └── cart_repository.dart
        ├── services/
        │    ├── user_service.dart
        │    ├── product_service.dart
        │    └── cart_service.dart
        ├── views/
        │    ├── user_screen.dart
        │    ├── product_screen.dart
        │    └── cart_screen.dart
        └── main.dart