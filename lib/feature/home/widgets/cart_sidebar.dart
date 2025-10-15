import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cashier_viewmodel.dart';
import '../models/cart_item_model.dart';
import '../utils/currency_formatter.dart';
import '../utils/responsive_util.dart';

class CartSidebar extends StatelessWidget {
  final ScrollController? scrollController;

  const CartSidebar({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartWidth = ResponsiveUtils.getCartWidth(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Consumer<CashierViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          width: isMobile ? double.infinity : cartWidth,
          color: Colors.white,
          child: Column(
            children: [
              if (isMobile)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: isMobile ? 20 : 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Menu',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: viewModel.cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_outlined,
                                size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              'Keranjang masih kosong',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: viewModel.cartItems.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            cartItem: viewModel.cartItems[index],
                          );
                        },
                      ),
              ),
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                child: SafeArea(
                  top: false,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: viewModel.cartItems.isEmpty
                          ? null
                          : () {
                              viewModel.processPayment();
                              if (isMobile) {
                                Navigator.pop(context);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Pembayaran berhasil diproses!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 14 : 16,
                        ),
                        decoration: BoxDecoration(
                          color: viewModel.cartItems.isEmpty
                              ? Colors.grey[300]
                              : const Color(0xFFFF6B35),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: viewModel.cartItems.isEmpty
                                  ? Colors.grey[500]
                                  : Colors.white,
                              size: isMobile ? 20 : 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${viewModel.cartItemCount} Items',
                              style: TextStyle(
                                color: viewModel.cartItems.isEmpty
                                    ? Colors.grey[600]
                                    : Colors.white,
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              CurrencyFormatter.format(viewModel.totalPrice),
                              style: TextStyle(
                                color: viewModel.cartItems.isEmpty
                                    ? Colors.grey[600]
                                    : Colors.white,
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: viewModel.cartItems.isEmpty
                                  ? Colors.grey[500]
                                  : Colors.white,
                              size: isMobile ? 16 : 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final initials = _getInitials(cartItem.product.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isMobile ? 10 : 12),
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(color: Color(0xFFFF6B35), width: 4),
        ),
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Avatar with Initials
          Container(
            width: isMobile ? 40 : 50,
            height: isMobile ? 40 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${cartItem.quantity} x ${CurrencyFormatter.format(cartItem.product.price)} = ${CurrencyFormatter.format(cartItem.quantity * cartItem.product.price)}',
                  style: TextStyle(
                    fontSize: isMobile ? 11 : 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: isMobile ? 20 : 24,
            ),
            onPressed: () {
              context.read<CashierViewModel>()
                  .removeFromCart(cartItem.product.id);
            },
          ),
        ],
      ),
    );
  }
}