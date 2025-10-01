import 'package:flutter/material.dart';

class Practical7ProductCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical 7: Product Catalog',
      home: LoginScreen7(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen7 extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DashboardScreen7(userName: name),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen7 extends StatelessWidget {
  final String userName;
  DashboardScreen7({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $userName!', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Product Catalog'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductCatalogScreen(userName: userName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCatalogScreen extends StatelessWidget {
  final String userName;
  ProductCatalogScreen({required this.userName});

  final List<Map<String, String>> products = [
    {
      'name': 'Laptop',
      'image': 'https://cdn-icons-png.flaticon.com/512/1792/1792864.png',
      'price': '₹50,000'
    },
    {
      'name': 'Headphones',
      'image': 'https://cdn-icons-png.flaticon.com/512/727/727245.png',
      'price': '₹2,000'
    },
    {
      'name': 'Camera',
      'image': 'https://cdn-icons-png.flaticon.com/512/2921/2921822.png',
      'price': '₹25,000'
    },
    {
      'name': 'Smartphone',
      'image': 'https://cdn-icons-png.flaticon.com/512/747/747376.png',
      'price': '₹15,000'
    },
    {
      'name': 'Watch',
      'image': 'https://cdn-icons-png.flaticon.com/512/747/747376.png',
      'price': '₹3,000'
    },
    {
      'name': 'Speaker',
      'image': 'https://cdn-icons-png.flaticon.com/512/727/727269.png',
      'price': '₹1,500'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Catalog')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Hello, $userName!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    name: product['name']!,
                    imageUrl: product['image']!,
                    price: product['price']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;

  ProductCard({required this.name, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 70, width: 70, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(price, style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}