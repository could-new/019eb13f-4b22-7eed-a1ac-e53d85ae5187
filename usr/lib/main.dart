import 'package:flutter/material.dart';
import 'models.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(
    AppStateScope(
      state: AppState(),
      child: const ZeldaApp(),
    ),
  );
}

class ZeldaApp extends StatelessWidget {
  const ZeldaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZELDA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.black87,
          surface: Colors.white,
          background: Color(0xFFFAFAFA),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
        // Using a sans-serif look for a modern, premium feel
        fontFamily: 'Helvetica Neue', 
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        if (settings.name == '/product') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product));
        }
        if (settings.name == '/cart') {
          return MaterialPageRoute(builder: (_) => const CartScreen());
        }
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
