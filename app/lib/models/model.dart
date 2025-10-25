class CartItem {
  final String name;
  final String price;
  final String unit;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.unit,
    required this.image,
    this.quantity = 1,
  });

  double get totalPrice => double.tryParse(price) != null
      ? double.parse(price) * quantity
      : 0;
}
