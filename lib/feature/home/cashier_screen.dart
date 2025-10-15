import 'package:cashier/feature/home/utils/currency_formatter.dart';
import 'package:cashier/feature/home/utils/responsive_util.dart';
import 'package:cashier/feature/home/widgets/app_header.dart';
import 'package:cashier/feature/home/widgets/cart_sidebar.dart';
import 'package:cashier/feature/home/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cashier_viewmodel.dart';

class CashierScreen extends StatelessWidget {
  const CashierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CashierViewModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = ResponsiveUtils.isMobile(context);

            if (isMobile) {
              return _MobileLayout();
            } else {
              return _TabletDesktopLayout();
            }
          },
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const AppHeader(),
            Expanded(child: ProductGrid()),
          ],
        ),

        // Floating Cart Button
        Positioned(
          bottom: 20,
          right: 16,
          left: 16,
          child: Consumer<CashierViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.cartItemCount == 0) {
                return const SizedBox.shrink();
              }

              return Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Payment Successful'),
                          content: const Text('Your payment has been processed successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${viewModel.cartItemCount} items',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              CurrencyFormatter.format(viewModel.totalPrice),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TabletDesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const AppHeader(),
              Expanded(child: ProductGrid()),
            ],
          ),
        ),
        const CartSidebar(),
      ],
    );
  }
}