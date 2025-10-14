class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    this.description,
  });
}