import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String id;
  final String name;
  final double price;

  const CartItem({required this.id, required this.name, required this.price});

  CartItem copyWith({String? id, String? name, double? price}) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}

class CartState {
  final List<CartItem> items;
  final double total;

  CartState({required List<CartItem> items, required this.total})
      : items = List.unmodifiable(items);

  factory CartState.initial() => CartState(items: const [], total: 0);

  CartState copyWith({List<CartItem>? items, double? total}) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}


// ShoppingCart Notifier
class ShoppingCart extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState(items: [], total: 0);
  }

  void addItem(String name, double price) {
    final newItem = CartItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      price: price,
    );

    state = CartState(
      items: [...state.items, newItem],
      total: state.total + price,
    );
  }

  void removeItem(String id) {
    final item = state.items.where((i) => i.id == id).firstOrNull;
    if (item == null) return;

    state = CartState(
      items: state.items.where((i) => i.id != id).toList(),
      total: state.total - item.price,
    );
  }

  void clear() {
    state = CartState(items: [], total: 0);
  }
}
