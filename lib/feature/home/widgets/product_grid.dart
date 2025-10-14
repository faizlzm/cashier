import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cashier_viewmodel.dart';
import '../models/product_model.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CashierViewModel>(
      builder: (context, viewModel, child) {
        final products = viewModel.filteredProducts;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan jumlah produk dan Filter Chips
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Jumlah Produk
                  Text(
                    '${products.length} Produk Ditemukan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filter Chips untuk Kategori
                  Wrap(
                    spacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('SEMUA'),
                        selected: viewModel.selectedCategory == 'SEMUA',
                        onSelected: (_) {
                          viewModel.setCategory('SEMUA');
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: const Color(0xFFFF6B35),
                        labelStyle: TextStyle(
                          color: viewModel.selectedCategory == 'SEMUA'
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: viewModel.selectedCategory == 'SEMUA'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: const Text('MAKANAN'),
                        selected: viewModel.selectedCategory == 'MAKANAN',
                        onSelected: (_) {
                          viewModel.setCategory('MAKANAN');
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: const Color(0xFFFF6B35),
                        labelStyle: TextStyle(
                          color: viewModel.selectedCategory == 'MAKANAN'
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: viewModel.selectedCategory == 'MAKANAN'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: const Text('MINUMAN'),
                        selected: viewModel.selectedCategory == 'MINUMAN',
                        onSelected: (_) {
                          viewModel.setCategory('MINUMAN');
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: const Color(0xFFFF6B35),
                        labelStyle: TextStyle(
                          color: viewModel.selectedCategory == 'MINUMAN'
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: viewModel.selectedCategory == 'MINUMAN'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        checkmarkColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Grid Produk
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tidak ada produk ditemukan',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tentukan icon berdasarkan kategori
    IconData productIcon = product.category == 'MAKANAN'
        ? Icons.restaurant
        : Icons.local_drink;

    Color iconColor = product.category == 'MAKANAN'
        ? Colors.orange[300]!
        : Colors.brown[300]!;

    return GestureDetector(
      onTap: () {
        context.read<CashierViewModel>().addToCart(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: Center(
                  child: Icon(
                    productIcon,
                    size: 50,
                    color: iconColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Rp. ${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
