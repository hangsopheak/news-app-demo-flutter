import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifiers/counter_notifier.dart';
import 'notifiers/shopping_cart_notifier.dart';





final counterProvider = NotifierProvider<Counter, int>(Counter.new);
final shoppingCartProvider = NotifierProvider<ShoppingCart, CartState>(ShoppingCart.new);


class NotifierDemoScreen extends ConsumerWidget {
  const NotifierDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final cart = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifier Demo'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'What is Notifier?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Notifier manages mutable state with business logic. '
                'Use for complex operations and validation.',
          ),
          const SizedBox(height: 24),

          // Counter Example
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Counter Example',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$count',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => ref.read(counterProvider.notifier).decrement(),
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(counterProvider.notifier).reset(),
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(counterProvider.notifier).increment(),
                        child: const Text('+'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Shopping Cart Example
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shopping Cart',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (cart.items.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref.read(shoppingCartProvider.notifier).clear(),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Items: ${cart.items.length}'),
                  Text('Total: \$${cart.total.toStringAsFixed(2)}'),
                  const SizedBox(height: 16),
                  if (cart.items.isEmpty)
                    const Text('Cart is empty')
                  else
                    ...cart.items.map((item) => ListTile(
                      title: Text(item.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${item.price.toStringAsFixed(2)}'),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () => ref
                                .read(shoppingCartProvider.notifier)
                                .removeItem(item.id),
                          ),
                        ],
                      ),
                    )),
                  const Divider(),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => ref
                            .read(shoppingCartProvider.notifier)
                            .addItem('Laptop', 999),
                        child: const Text('Add Laptop \$999'),
                      ),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(shoppingCartProvider.notifier)
                            .addItem('Mouse', 29),
                        child: const Text('Add Mouse \$29'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}