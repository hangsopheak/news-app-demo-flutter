import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/concept_demo/riverpod/notifiers/counter_notifier.dart';
import 'package:news_app_demo_flutter/concept_demo/riverpod/notifiers/shopping_cart_notifier.dart';


/// This is an INTERACTIVE screen, but it uses ConsumerWidget (which is Stateless).
/// This works because Riverpod moves the "Brain" (the state variable and the logic)
/// OUT of the widget and into the Notifier. The Widget is now just a "TV Screen"
/// that automatically rebuilds when the external state (the provider) changes.
class NotifierDemoScreen extends ConsumerWidget {
  const NotifierDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ---------------------------------------------------------
    // 1. WATCH: Rebuilds this widget when state changes
    // ---------------------------------------------------------
    final count = ref.watch(counterProvider);
    final cartItems = ref.watch(shoppingCartProvider);

    // Derived State: Calculate total on the fly (UI Logic)
    final total = cartItems.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text('2. Notifier Demo')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [

          // =========================================
          // DEMO 1: Simple Counter
          // =========================================
          const Text('1. Simple State', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          Center(
            child: Text(
                '$count',
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)
            ),
          ),

          const SizedBox(height: 16),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---------------------------------------------------------
              // 2. READ: Access the class (.notifier) to call methods
              // ---------------------------------------------------------
              IconButton.outlined(
                onPressed: () => ref.read(counterProvider.notifier).decrement(),
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => ref.read(counterProvider.notifier).reset(),
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              IconButton.outlined(
                onPressed: () => ref.read(counterProvider.notifier).increment(),
                icon: const Icon(Icons.add),
              ),
            ],
          ),

          const Divider(height: 48),

          // =========================================
          // DEMO 2: Shopping Cart
          // =========================================
          const Text('2. Complex Logic', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // Summary Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items: ${cartItems.length}'),
              Text(
                'Total: \$${total.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // List of Items
          if (cartItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Cart is empty', style: TextStyle(color: Colors.grey)),
            ),

          // Using spread operator to show items
          ...cartItems.map((item) => ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(item.name),
            subtitle: Text('\$${item.price.toStringAsFixed(0)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              // Call logic method
              onPressed: () => ref.read(shoppingCartProvider.notifier).removeItem(item.id),
            ),
          )),

          const SizedBox(height: 16),

          // Add Buttons
          Wrap(
            spacing: 12,
            children: [
              OutlinedButton(
                onPressed: () => ref.read(shoppingCartProvider.notifier).addItem('Laptop', 999),
                child: const Text('Add Laptop'),
              ),
              OutlinedButton(
                onPressed: () => ref.read(shoppingCartProvider.notifier).addItem('Mouse', 29),
                child: const Text('Add Mouse'),
              ),
              TextButton(
                onPressed: () => ref.read(shoppingCartProvider.notifier).clear(),
                child: const Text('Clear All'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}