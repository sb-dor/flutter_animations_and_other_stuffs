content = """
# Flutter MVVM Architecture with User, Product, and Cart Management

In this guide, we’ll walk through how to create a Flutter project with an MVVM (Model-View-ViewModel) pattern for multiple screens. We will manage **users**, **products**, and **cart items**, while keeping the logic modular and reusable across screens.

## Project Structure

```bash
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


class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}


class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}


class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}


class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<User> fetchUser(String userId) {
    return _userService.getUser(userId);
  }
}



class ProductRepository {
  final ProductService _productService;

  ProductRepository(this._productService);

  Future<List<Product>> fetchProducts() {
    return _productService.getProducts();
  }
}



class CartRepository {
  final List<CartItem> _cart = [];

  List<CartItem> get cartItems => _cart;

  void addToCart(Product product) {
    var existingItem = _cart.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    
    if (existingItem.quantity == 0) {
      _cart.add(CartItem(product: product, quantity: 1));
    } else {
      existingItem.quantity += 1;
    }
  }

  void removeFromCart(Product product) {
    _cart.removeWhere((item) => item.product.id == product.id);
  }

  double getTotalPrice() {
    return _cart.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }
}



class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserViewModel(this._userRepository);

  Future<void> loadUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    _user = await _userRepository.fetchUser(userId);

    _isLoading = false;
    notifyListeners();
  }
}



class ProductViewModel with ChangeNotifier {
  final ProductRepository _productRepository;

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductViewModel(this._productRepository);

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await _productRepository.fetchProducts();

    _isLoading = false;
    notifyListeners();
  }
}



class CartViewModel with ChangeNotifier {
  final CartRepository _cartRepository;

  CartViewModel(this._cartRepository);

  List<CartItem> get cartItems => _cartRepository.cartItems;
  double get totalPrice => _cartRepository.getTotalPrice();

  void addToCart(Product product) {
    _cartRepository.addToCart(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartRepository.removeFromCart(product);
    notifyListeners();
  }
}


class UserService {
  Future<User> getUser(String userId) async {
    // Fetch user from API
    return User(id: '1', name: 'John Doe');
  }
}


class ProductService {
  Future<List<Product>> getProducts() async {
    // Fetch products from API
    return [
      Product(id: '1', name: 'Product 1', price: 10.0),
      Product(id: '2', name: 'Product 2', price: 20.0),
    ];
  }
}
