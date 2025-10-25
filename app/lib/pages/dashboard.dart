import 'package:flutter/material.dart';
import 'package:app/pages/profil.dart';
import '../data/kategori.dart';
import 'detail.dart';
import '../models/model.dart';
import 'cart.dart';
import 'favorit.dart'; // 🩷 Tambahan halaman favorit
import 'story.dart';
import 'rat.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentBanner = 0;
  final PageController _pageController = PageController();
  String _selectedCategory = "All";
  List<CartItem> cartItems = [];

  // 🩷 List produk yang difavoritkan
  List<Map<String, String>> favoriteItems = [];

  final List<Map<String, String>> banners = [
    {
      'image': 'assets/images/baner.jpg',
      'text': '20% off on your\nfirst purchase',
    },
    {
      'image': 'assets/images/baner2.jpg',
      'text': 'Buy 1 Get 1 Free\non cold drinks!',
    },
    {
      'image': 'assets/images/baner3.jpg',
      'text': 'Free delivery\nfor orders above 50k!',
    },
  ];

  final Map<String, List<Map<String, String>>> productsByCategory = {
    "Makanan": [
      {
        "name": "Nasi Goreng",
        "price": "12.000",
        "unit": "per porsi",
        "image": "assets/images/n.png",
      },
      {
        "name": "Mie Goreng",
        "price": "10.000",
        "unit": "per porsi",
        "image": "assets/images/mei.png",
      },
    ],
    "Minuman Dingin": [
      {
        "name": "Es Kopi Susu",
        "price": "10.000",
        "unit": "gelas",
        "image": "assets/images/t.png",
      },
      {
        "name": "Es Teh Manis",
        "price": "5.000",
        "unit": "gelas",
        "image": "assets/images/t.png",
      },
    ],
    "Snack": [
      {
        "name": "Kentang Goreng",
        "price": "8.000",
        "unit": "porsi",
        "image": "assets/images/ke.png",
      },
      {
        "name": "Roti Bakar",
        "price": "7.000",
        "unit": "porsi",
        "image": "assets/images/r.png",
      },
    ],
    "Kopi": [
      {
        "name": "Kopi Hitam",
        "price": "6.000",
        "unit": "gelas",
        "image": "assets/images/kopi.png",
      },
      {
        "name": "Cappuccino",
        "price": "9.000",
        "unit": "gelas",
        "image": "assets/images/capu.png",
      },
    ],
    "Dessert": [
      {
        "name": "Pudding Coklat",
        "price": "8.000",
        "unit": "cup",
        "image": "assets/images/pu.png",
      },
      {
        "name": "Cheesecake",
        "price": "15.000",
        "unit": "slice",
        "image": "assets/images/c.png",
      },
    ],
  };

  final Map<String, List<Color>> categoryColors = {
    "All": [Color(0xFF00BFA6), Color(0xFF70EED6)],
    "Makanan": [Color(0xFF32A0D3), Color(0xFFFFA48B)],
    "Minuman Dingin": [Color(0xFF2DA324), Color(0xFF7BE37B)],
    "Snack": [Color(0xFFE6B838), Color(0xFFFFD95B)],
    "Kopi": [Color(0xFF844BEE), Color(0xFFB69CFF)],
    "Dessert": [Color(0xFFF36EB7), Color(0xFFFFA8D9)],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> selectedProducts = [];
    if (_selectedCategory == "All") {
      for (var list in productsByCategory.values) {
        selectedProducts.addAll(list);
      }
    } else {
      selectedProducts = productsByCategory[_selectedCategory] ?? [];
    }

    final Color circleColor = categoryColors[_selectedCategory]![0];
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.015),

                // 🔍 Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: screenWidth * 0.06,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: TextField(
                          readOnly:
                              true, // Supaya langsung pindah halaman ketika diklik
                          decoration: const InputDecoration(
                            hintText: 'Search menu...',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.04),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchStoryPage(),
                              ),
                            );
                          },
                        ),
                      ),

                      IconButton(
                        icon: Icon(Icons.filter_list, size: screenWidth * 0.06),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ApplyFiltersPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // 🖼️ Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  child: SizedBox(
                    height: screenHeight * 0.25,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: banners.length,
                          onPageChanged: (index) =>
                              setState(() => _currentBanner = index),
                          itemBuilder: (context, index) {
                            final banner = banners[index];
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  banner['image']!,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: Colors.black26,
                                  padding: EdgeInsets.all(screenWidth * 0.04),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    banner['text']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Positioned(
                          bottom: screenHeight * 0.01,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              banners.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.01,
                                ),
                                width: _currentBanner == index
                                    ? screenWidth * 0.03
                                    : screenWidth * 0.02,
                                height: screenWidth * 0.015,
                                decoration: BoxDecoration(
                                  color: _currentBanner == index
                                      ? Colors.white
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // 🍔 Categories
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),

                SizedBox(
                  height: screenHeight * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesData.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buildCategory(
                          "All",
                          Icons.grid_view_rounded,
                          categoryColors["All"]![0].withOpacity(0.2),
                          screenWidth,
                        );
                      } else {
                        final cat = categoriesData[index - 1];
                        return buildCategory(
                          cat["name"],
                          cat["icon"],
                          cat["color"].withOpacity(0.2),
                          screenWidth,
                        );
                      }
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // 🍱 Produk Berdasarkan Kategori
                Text(
                  "Kategori: $_selectedCategory",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // 🔹 Grid Produk
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.03,
                  mainAxisSpacing: screenWidth * 0.03,
                  childAspectRatio: 0.75,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: selectedProducts.map((p) {
                    return productCard(
                      p["name"]!,
                      p["price"]!,
                      p["unit"]!,
                      p["image"]!,
                      circleColor,
                      screenWidth,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(screenWidth),
      floatingActionButton: _buildFAB(screenWidth),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // 🟢 FAB
  Widget _buildFAB(double screenWidth) {
    return Container(
      width: screenWidth * 0.18,
      height: screenWidth * 0.18,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(cartItems: cartItems),
            ),
          );
        },
        child: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: screenWidth * 0.08,
        ),
      ),
    );
  }

  // 🩷 Bottom Navbar dengan tombol ke Favorites
  Widget _buildBottomNav(double screenWidth) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: screenWidth * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined),
                iconSize: screenWidth * 0.09,
                color: Colors.green,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline),
                iconSize: screenWidth * 0.09,
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        cartItems: cartItems,
                        favoriteItems: favoriteItems,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                iconSize: screenWidth * 0.09,
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesPage(favoriteItems: favoriteItems),
                    ),
                  );
                },
              ),
              SizedBox(width: screenWidth * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  // 🟢 Widget kategori
  Widget buildCategory(
    String name,
    IconData icon,
    Color bgColor,
    double screenWidth,
  ) {
    final bool isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = name),
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.035),
        width: screenWidth * 0.18,
        child: Column(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.07,
              backgroundColor: isSelected ? Colors.green : bgColor,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black87,
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenWidth * 0.015),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard(
    String name,
    String price,
    String unit,
    String image,
    Color bgColor,
    double screenWidth,
  ) {
    bool isFavorite = favoriteItems.any((item) => item['name'] == name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isFavorite) {
                      favoriteItems.removeWhere((item) => item['name'] == name);
                    } else {
                      favoriteItems.add({
                        "name": name,
                        "price": price,
                        "unit": unit,
                        "image": image,
                      });
                    }
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: screenWidth * 0.06,
                ),
              ),
            ),
          ),

          // --- Gambar Produk ---
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      name: name,
                      price: price,
                      unit: unit,
                      image: image,
                      gradientColors: [
                        bgColor.withOpacity(0.7),
                        bgColor.withOpacity(0.4),
                      ],
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor.withOpacity(0.3),
                    ),
                  ),
                  Image.asset(
                    image,
                    height: screenWidth * 0.22,
                    width: screenWidth * 0.22,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenWidth * 0.02),

          // --- Nama & Harga ---
          Text(
            "Rp$price",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.038,
            ),
          ),
          Text(
            unit,
            style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03),
          ),

          // 🔹 Garis pemisah hitam
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02,
              horizontal: screenWidth * 0.05,
            ),
            child: Container(height: 1, color: Colors.black),
          ),

          // --- Tombol Add to Cart ---
          GestureDetector(
            onTap: () {
              setState(() {
                cartItems.add(
                  CartItem(name: name, price: price, unit: unit, image: image),
                );
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$name berhasil ditambahkan ke keranjang!'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/tas.png',
                    height: screenWidth * 0.08,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
