
class Product {
  double price;
  String name;

  Product({required this.price, required this.name});

  // Factory constructor to create a Product from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      price: map['price'],
      name: map['name'],
    );
  }

  // Method to convert a Product to a Map
  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'name': name,
    };
  }
}