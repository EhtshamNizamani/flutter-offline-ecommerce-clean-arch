class CartItem {
  final String productId;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  double get totalPrice => price * quantity;
}