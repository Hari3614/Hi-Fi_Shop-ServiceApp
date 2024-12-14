import 'package:project1/data/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  Future<void> saveProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsData = prefs.getStringList('products') ?? [];

    // Deserialize existing products
    List<Product> products = [];
    try {
      products = productsData.map((data) => Product.fromJson(data)).toList();
    } catch (e) {
      // Clear corrupted data and reinitialize
      productsData = [];
      await prefs.setStringList('products', []);
    }

    // Check for duplicate product names
    if (products.any((p) => p.name == product.name)) {
      throw Exception('Duplicate product name');
    }

    // Serialize the new product to JSON
    final String serializedProduct = product.toJson();

    // Add the new product to the list
    productsData.add(serializedProduct);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('products', productsData);
  }

  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsData = prefs.getStringList('products') ?? [];

    // Deserialize safely
    try {
      return productsData.map((data) => Product.fromJson(data)).toList();
    } catch (e) {
      // Reset corrupted data
      await prefs.setStringList('products', []);
      return [];
    }
  }

  Future<void> deleteProduct(String name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsData = prefs.getStringList('products') ?? [];

    // Filter out the product to be deleted
    final updatedData = productsData
        .where((data) => Product.fromJson(data).name != name)
        .toList();

    await prefs.setStringList('products', updatedData);
  }
}
