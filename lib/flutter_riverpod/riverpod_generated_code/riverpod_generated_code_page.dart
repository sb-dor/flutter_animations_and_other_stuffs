import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/get_product/get_product.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter/riverpod_product_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_generated_code_state_managements/product_filter_model.dart';

class RiverpodGeneratedCodePage extends ConsumerWidget {
  const RiverpodGeneratedCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProductProvider);
    final filter = ref.watch(riverpodProductFilterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(getProductProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(riverpodProductFilterProvider.notifier).update(
                      ProductFilterModel(
                        query: value,
                        minPrice: filter.productFilterModel.minPrice,
                        maxPrice: filter.productFilterModel.maxPrice,
                      ),
                    );
              },
            ),
          ),
          Expanded(
            child: products.when(
              data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].name),
                    subtitle: Text('\$${data[index].price}'),
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
