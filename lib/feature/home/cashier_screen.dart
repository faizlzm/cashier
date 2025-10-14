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
        body: Row(
          children: [
            // Konten Utama
            Expanded(
              child: Column(
                children: [
                  const AppHeader(),
                  Expanded(child: ProductGrid()),
                ],
              ),
            ),

            // Sidebar Kanan (Cart)
            const CartSidebar(),
          ],
        ),
      ),
    );
  }
}
