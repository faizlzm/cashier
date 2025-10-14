import 'package:flutter/material.dart';

import 'models/cart_item_model.dart';
import 'models/product_model.dart';

class CashierViewModel extends ChangeNotifier {
  final List<Product> _allProducts = [
    // MINUMAN
    Product(
      id: '1',
      name: 'Susu Sirup',
      image: 'assets/susu_sirup.png',
      price: 10000,
      category: 'MINUMAN',
    ),
    Product(
      id: '2',
      name: 'Dancow Keju',
      image: 'assets/dancow_keju.png',
      price: 13000,
      category: 'MINUMAN',
    ),
    Product(
      id: '3',
      name: 'Dancow Putih',
      image: 'assets/dancow_putih.png',
      price: 13000,
      category: 'MINUMAN',
    ),
    Product(
      id: '4',
      name: 'Dancow Coklat',
      image: 'assets/dancow_coklat.png',
      price: 12000,
      category: 'MINUMAN',
    ),
    Product(
      id: '5',
      name: 'STMJ',
      image: 'assets/stmj.png',
      price: 13000,
      category: 'MINUMAN',
    ),
    Product(
      id: '6',
      name: 'Milo',
      image: 'assets/milo.png',
      price: 16000,
      category: 'MINUMAN',
    ),
    Product(
      id: '7',
      name: 'Hilo',
      image: 'assets/hilo.png',
      price: 17000,
      category: 'MINUMAN',
    ),
    Product(
      id: '8',
      name: 'Susu Jahe',
      image: 'assets/susu_jahe.png',
      price: 17000,
      category: 'MINUMAN',
    ),
    Product(
      id: '9',
      name: 'Susu Putih',
      image: 'assets/susu_putih.png',
      price: 17000,
      category: 'MINUMAN',
    ),
    Product(
      id: '10',
      name: 'Susu Coklat',
      image: 'assets/susu_coklat.png',
      price: 17000,
      category: 'MINUMAN',
    ),
    Product(
      id: '11',
      name: 'Es Teh',
      image: 'assets/es_teh.png',
      price: 6000,
      category: 'MINUMAN',
    ),
    Product(
      id: '12',
      name: 'Kopi Hitam',
      image: 'assets/kopi.png',
      price: 8000,
      category: 'MINUMAN',
    ),
    // MAKANAN
    Product(
      id: '13',
      name: 'Nasi Goreng',
      image: 'assets/nasi_goreng.png',
      price: 15000,
      category: 'MAKANAN',
    ),
    Product(
      id: '14',
      name: 'Mie Goreng',
      image: 'assets/mie_goreng.png',
      price: 12000,
      category: 'MAKANAN',
    ),
    Product(
      id: '15',
      name: 'Kwetiau Goreng',
      image: 'assets/kwetiau.png',
      price: 14000,
      category: 'MAKANAN',
    ),
    Product(
      id: '16',
      name: 'Nasi Biasa',
      image: 'assets/nasi_biasa.png',
      price: 10000,
      category: 'MAKANAN',
    ),
    Product(
      id: '17',
      name: 'Ayam Goreng',
      image: 'assets/ayam_goreng.png',
      price: 18000,
      category: 'MAKANAN',
    ),
    Product(
      id: '18',
      name: 'Telur Dadar',
      image: 'assets/telur.png',
      price: 8000,
      category: 'MAKANAN',
    ),
  ];

  List<CartItem> _cartItems = [];
  String _selectedCategory = 'SEMUA';
  String _searchQuery = '';

  List<Product> get filteredProducts {
    var products = _allProducts;

    if (_selectedCategory != 'SEMUA') {
      products = products.where((p) => p.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      products = products
          .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return products;
  }

  List<CartItem> get cartItems => _cartItems;
  String get selectedCategory => _selectedCategory;

  int get cartItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void increaseQuantity(String productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void processPayment() {
    print('Processing payment for total: Rp. ${totalPrice.toStringAsFixed(0)}');
    clearCart();
  }
}