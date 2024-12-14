import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/data/model/product.dart';

PreferredSizeWidget buildAppBar(Function onLogout) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 182, 127, 237),
    title: Text(
      'Hi-Fi Shop & Service',
      style: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.logout,
          color: Color.fromARGB(255, 9, 9, 9),
        ),
        onPressed: () => onLogout(),
        tooltip: 'Logout',
      ),
    ],
  );
}

Widget buildSearchField(TextEditingController searchController) {
  return TextField(
    controller: searchController,
    decoration: InputDecoration(
      labelText: 'Search Products',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

Widget buildProductCard(Product product, Function deleteProduct) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: product.image.isNotEmpty
              ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Image.file(
                    File(product.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Container(
                    color: const Color.fromARGB(255, 49, 49, 49),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteProduct(product),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProductGrid(List<Product> products, Function deleteProduct) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2 / 3,
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return buildProductCard(product, deleteProduct);
    },
  );
}

Widget buildNoProductFound() {
  return const Center(
    child: Text('No Product Found'),
  );
}
