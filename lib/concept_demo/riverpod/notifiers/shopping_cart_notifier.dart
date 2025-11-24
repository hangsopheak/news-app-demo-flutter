import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_cart_notifier.g.dart';

class CartItem {
  final String id;
  final String name;
  final double price;

  CartItem({required this.id, required this.name, required this.price});
}

// The Notifier: Manages the List<CartItem>
@riverpod
class ShoppingCartNotifier extends _$ShoppingCartNotifier {

  @override
  List<CartItem> build() {
    return []; // Initial state is an empty list
  }

  // Business Logic: Add item
  void addItem(String name, double price) {
    final newItem = CartItem(
      id: DateTime.now().toString(),
      name: name,
      price: price,
    );
    // Update state using spread operator (immutable update)
    state = [...state, newItem];
  }

  // Business Logic: Remove item
  void removeItem(String id) {
    state = [
      for (final item in state)
        if (item.id != id) item,
    ];
  }

  // Business Logic: Clear cart
  void clear() {
    state = [];
  }
}
