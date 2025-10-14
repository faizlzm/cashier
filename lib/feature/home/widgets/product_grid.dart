import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cashier_viewmodel.dart';
import '../models/product_model.dart';
import '../utils/responsive_util.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CashierViewModel>(
      builder: (context, viewModel, child) {
        final products = viewModel.filteredProducts;
        final crossAxisCount = ResponsiveUtils.getGridCrossAxisCount(context);
        final isMobile = ResponsiveUtils.isMobile(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          context,
                          'SEMUA',
                          viewModel.selectedCategory == 'SEMUA',
                          () => viewModel.setCategory('SEMUA'),
                        ),
                        const SizedBox(width: 10),
                        _buildFilterChip(
                          context,
                          'MAKANAN',
                          viewModel.selectedCategory == 'MAKANAN',
                          () => viewModel.setCategory('MAKANAN'),
                        ),
                        const SizedBox(width: 10),
                        _buildFilterChip(
                          context,
                          'MINUMAN',
                          viewModel.selectedCategory == 'MINUMAN',
                          () => viewModel.setCategory('MINUMAN'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 20,
                        vertical: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: isMobile ? 10 : 15,
                        mainAxisSpacing: isMobile ? 10 : 15,
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

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.grey[200],
      selectedColor: const Color(0xFFFF6B35),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: ResponsiveUtils.isMobile(context) ? 10 : 12,
      ),
      checkmarkColor: Colors.white,
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    IconData productIcon = product.category == 'MAKANAN'
        ? Icons.restaurant
        : Icons.local_drink;

    Color iconColor = product.category == 'MAKANAN'
        ? Colors.orange[300]!
        : Colors.brown[300]!;

    return GestureDetector(
      onTap: () {
        context.read<CashierViewModel>().addToCart(product);

        if (isMobile) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} ditambahkan ke keranjang'),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
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
                margin: EdgeInsets.all(isMobile ? 10 : 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: Center(
                  child: Icon(
                    productIcon,
                    size: isMobile ? 35 : 50,
                    color: iconColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12),
              child: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 12 : 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 8 : 12),
              child: Text(
                'Rp. ${product.price.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isMobile ? 11 : 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
