import 'package:flutter/material.dart';

// InheritedNotifier to provide AppState down the tree
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.notifier!;
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> sizes;
  final List<Color> colors;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sizes,
    required this.colors,
  });
}

class CartItem {
  final Product product;
  final String selectedSize;
  final Color selectedColor;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });
}

class AppState extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  double get cartTotal {
    return _cart.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }

  void addToCart(Product product, String size, Color color) {
    // Check if item already exists in cart with same size and color
    final existingIndex = _cart.indexWhere((item) => 
      item.product.id == product.id && 
      item.selectedSize == size && 
      item.selectedColor == color
    );

    if (existingIndex >= 0) {
      _cart[existingIndex].quantity += 1;
    } else {
      _cart.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(item);
    } else {
      item.quantity = newQuantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

// Dummy Data
final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'ZELDA Essential Brief',
    description: 'Our classic essential brief. Breathable cotton blend with our signature stay-put waistband for all-day comfort.',
    price: 24.00,
    imageUrl: 'https://images.unsplash.com/photo-1560362614-890275988e89?auto=format&fit=crop&q=80&w=600',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: [Colors.black, Colors.white, Colors.grey.shade800],
  ),
  Product(
    id: '2',
    name: 'ZELDA Performance Boxer',
    description: 'Engineered for motion. Moisture-wicking micro-mesh fabric keeps you cool during intense workouts.',
    price: 32.00,
    imageUrl: 'https://images.unsplash.com/photo-1628169123015-7ce3c9b78809?auto=format&fit=crop&q=80&w=600',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: [Colors.blue.shade900, Colors.black, Colors.red.shade800],
  ),
  Product(
    id: '3',
    name: 'ZELDA Silk Trunk',
    description: 'Luxury meets daily wear. Premium silk blend fabric offering unparalleled softness and a sleek profile.',
    price: 45.00,
    imageUrl: 'https://images.unsplash.com/photo-1588620353536-121db5b248eb?auto=format&fit=crop&q=80&w=600',
    sizes: ['M', 'L', 'XL'],
    colors: [Colors.black, const Color(0xFF3B1E4A)],
  ),
  Product(
    id: '4',
    name: 'ZELDA Modal Boxer Brief',
    description: 'Ultra-soft sustainably sourced modal fabric. Feels like a second skin, preventing chafing and riding up.',
    price: 28.00,
    imageUrl: 'https://images.unsplash.com/photo-1522066708682-1ee90aaac6da?auto=format&fit=crop&q=80&w=600',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: [Colors.black, Colors.grey.shade400, Colors.teal.shade800],
  ),
];
