import 'dart:convert';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});

  // Serialize to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }

  // Serialize to JSON
  String toJson() => json.encode(toMap());

  // Deserialize from JSON
  factory Product.fromJson(String source) {
    final data = json.decode(source);
    return Product(
      name: data['name'],
      price: data['price'],
      image: data['image'],
    );
  }
}
