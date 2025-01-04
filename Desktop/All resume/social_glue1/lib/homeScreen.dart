import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final DatabaseReference _productsRef =
      FirebaseDatabase.instance.ref('products');
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  void _fetchProducts() async {
    final snapshot = await _productsRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        products =
            data.values.map((e) => Map<String, dynamic>.from(e)).toList();
        filteredProducts = List.from(products); // Initially show all products
      });
    } else {
      print('No data found in Firebase');
    }
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) {
        return product['name'].toLowerCase().contains(query) ||
            product['color'].toLowerCase().contains(query) ||
            product['rupees'].toString().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 77, 133)),
        backgroundColor: Colors.grey[50],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Online',
                    style: TextStyle(
                      color: Color.fromARGB(255, 218, 136, 13),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: ' Shop',
                    style: TextStyle(
                      color: Color.fromARGB(255, 10, 77, 133),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/logo.png',
              height: 55,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[50],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png', // Replace with your image URL
                    height: 65, // Adjust size as needed
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Online Shop',
                    style: TextStyle(
                      color: Color.fromARGB(255, 218, 136, 13),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gpp_good_outlined,
                          color: Color.fromARGB(255, 10, 77, 133)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Eat, Sleep and Relax',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 10, 77, 133)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Color.fromARGB(
                      255, 218, 136, 13)), // Set the icon color to white
              title: const Text(
                'Home',
                style: TextStyle(color: const Color.fromARGB(255, 10, 77, 133)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: Color.fromARGB(
                      255, 218, 136, 13)), // Set the icon color to white
              title: const Text(
                'Profile',
                style: TextStyle(color: const Color.fromARGB(255, 10, 77, 133)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Color.fromARGB(
                      255, 218, 136, 13)), // Set the icon color to white
              title: const Text(
                'Setting',
                style: TextStyle(color: const Color.fromARGB(255, 10, 77, 133)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_sharp,
                  color: Color.fromARGB(
                      255, 218, 136, 13)), // Set the icon color to white
              title: const Text(
                'Logout',
                style: TextStyle(color: const Color.fromARGB(255, 10, 77, 133)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search container
          Center(
            child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey[100], // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[700], // Icon color
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search', // Placeholder text
                        border: InputBorder.none, // Remove underline
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Product grid view
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 165,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(product['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 15, 0),
            child: Text(
              product['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${product['rupees']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('Product selected: ${product['name']}');
                  },
                  icon: const Icon(
                    Icons.add_box_rounded,
                    size: 30,
                    color: Color.fromARGB(255, 218, 136, 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
