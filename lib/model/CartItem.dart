

class CartItem {
  final String image;
  final String name;
  int quantity;
  final String color;
  final double price;
  // final Color colorScheme;

  CartItem({
    required this.image,
    required this.quantity,
    required this.name,
    required this.color,
    required this.price,
    // required this.colorScheme,
  });

  // toMap function for Firebase serialization
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'quantity': quantity,
      'color': color,
      'price': price,
    };
  }

  // fromMap factory constructor for deserialization from Firebase
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 1,
      color: map['color'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  // Optional: toString for debugging
  @override
  String toString() {
    return 'CartItem(name: $name, price: $price, quantity: $quantity, color: $color, image: $image)';
  }
}