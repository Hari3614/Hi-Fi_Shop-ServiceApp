import 'package:flutter/material.dart';
import 'package:project1/presentation/loginscreen/login_page.dart';
import 'package:project1/presentation/homescreen/home_page.dart';
import 'package:project1/presentation/productaddingscreen/add_product_page.dart';
import 'package:project1/presentation/splashscreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Simulated check for user login state
  bool isLoggedIn = await checkUserLoggedInStatus();

  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/add-product': (context) => AddProductPage(),
      },
    );
  }
}

Future<bool> checkUserLoggedInStatus() async {
  final prefs = await SharedPreferences.getInstance();
  // Return true if the user is logged in, else false
  return prefs.getBool('isLoggedIn') ?? false; // Default to false if not set
}
