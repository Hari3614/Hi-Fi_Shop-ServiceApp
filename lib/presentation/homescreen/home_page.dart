import 'package:flutter/material.dart';
import 'package:project1/data/model/product.dart';
import 'package:project1/data/repositories/product_repository.dart';
import 'package:project1/presentation/loginscreen/login_page.dart';
import 'package:project1/presentation/productaddingscreen/add_product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page_helpers.dart'; // Import the helper functions

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  void _loadProducts() async {
    final products = await _productRepository.getProducts();
    setState(() {
      _products = products;
      _filteredProducts = products;
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _deleteProduct(Product product) async {
    try {
      await _productRepository.deleteProduct(product.name);
      _loadProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: ${e.toString()}')),
      );
    }
  }

  void _navigateToAddProductPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
    _loadProducts();
  }

  void _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('isLoggedIn');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 209, 255),
      appBar: buildAppBar(_logout),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchField(_searchController),
            const SizedBox(height: 20),
            Text(
              'Products (${_filteredProducts.length})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? buildNoProductFound()
                  : buildProductGrid(_filteredProducts, _deleteProduct),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProductPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
