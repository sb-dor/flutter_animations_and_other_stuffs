import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/get_product/get_product.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_state_managements/product_filter/riverpod_product_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_generated_code_state_managements/product_filter_model.dart';

class RiverpodGeneratedCodePage extends ConsumerStatefulWidget {
  const RiverpodGeneratedCodePage({super.key});

  @override
  ConsumerState createState() => _RiverpodGeneratedCodePageState();
}

class _RiverpodGeneratedCodePageState extends ConsumerState<RiverpodGeneratedCodePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      ref.watch(getProductProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getProductProvider.notifier);
    final filter = ref.watch(riverpodProductFilterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
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
              decoration: const InputDecoration(
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
            child: ListView.builder(
              itemCount: products.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products.list[index].name),
                  subtitle: Text('\$${products.list[index].price}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
