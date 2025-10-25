import 'package:flutter/material.dart';
import 'package:app/auth/login.dart';
import 'cart.dart';
import 'dashboard.dart';
import 'about.dart';
import 'my_order.dart';
import 'favorit.dart';
import 'package:app/models/model.dart'; // ⬅️ penting agar CartItem dikenali
import 'my_adres.dart';
import 'card.dart';
import 'sek.dart';
import 'notif.dart';
// ----- Model untuk data menu profil
class ProfileMenuItem {
  final IconData icon;
  final String title;

  ProfileMenuItem(this.icon, this.title);
}

// --------------------------------------------------------------------------
// ----- Kelas Halaman Profil (ProfileScreen)
// --------------------------------------------------------------------------
class ProfileScreen extends StatefulWidget {
  final List<CartItem> cartItems; // ✅ sekarang pakai CartItem bukan Map
  final List<Map<String, String>> favoriteItems;

  const ProfileScreen({
    super.key,
    required this.cartItems,
    required this.favoriteItems,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final List<ProfileMenuItem> menuItems = [
    ProfileMenuItem(Icons.person_outline, 'About me'),
    ProfileMenuItem(Icons.inventory_2_outlined, 'My Orders'),
    ProfileMenuItem(Icons.favorite_border, 'My Favorites'),
    ProfileMenuItem(Icons.location_on_outlined, 'My Address'),
    ProfileMenuItem(Icons.credit_card_outlined, 'Credit Cards'),
    ProfileMenuItem(Icons.money_outlined, 'Transactions'),
    ProfileMenuItem(Icons.notifications_none, 'Notifications'),
    ProfileMenuItem(Icons.logout, 'Sign out'),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildProfileHeader(),
            const SizedBox(height: 20),
            buildMenuList(context),
          ],
        ),
      ),

      // 🔽 Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
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
            height: screenWidth * 0.22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 🏠 Dashboard
                IconButton(
                  icon: const Icon(Icons.home_outlined),
                  iconSize: screenWidth * 0.1,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                ),
                // 👤 Profile
                IconButton(
                  icon: const Icon(Icons.person),
                  iconSize: screenWidth * 0.1,
                  color: Colors.green,
                  onPressed: () {},
                ),
                // ❤️ Favorites
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  iconSize: screenWidth * 0.1,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FavoritesPage(favoriteItems: widget.favoriteItems),
                      ),
                    );
                  },
                ),

                SizedBox(width: screenWidth * 0.12),
              ],
            ),
          ),
        ),
      ),

      // 🛒 Floating Action Button
      floatingActionButton: Container(
        width: screenWidth * 0.2,
        height: screenWidth * 0.2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CartPage(cartItems: widget.cartItems), // ✅ fix type
              ),
            );
          },
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
            size: screenWidth * 0.1,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // Widget Header Profil
  Widget buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              const CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                  'https://disdikbud.acehtengahkab.go.id/thumbnail/700x0/media/2023.08/lumba-lumba1.jpg',
                ),
                backgroundColor: Colors.white,
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6E9A34),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Lumba"',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'akbar@gmail.com',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Widget List Menu Profil
  Widget buildMenuList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: menuItems.map((item) {
          bool isSignOut = item.title == 'Sign out';
          return CustomListTile(
            icon: item.icon,
            title: item.title,
            isSignOut: isSignOut,
            onTap: () {
              if (item.title == 'About me') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutMePage()),
                );
              } else if (item.title == 'My Orders') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyOrderPage()),
                );
              } else if (item.title == 'My Favorites') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FavoritesPage(favoriteItems: widget.favoriteItems),
                  ),
                );
              } else if (item.title == 'My Address') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAddressPage(),
                  ),
                );
              } else if (item.title == 'Credit Cards') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCardsPage()),
                );
              } else if (item.title == 'Transactions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionsPage(),
                  ),
                );
              }else if (item.title == 'Notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  NotificationPage(),
                  ),
                );
              } else if (isSignOut) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPages()),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

// ----- Widget Custom ListTile -----
class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSignOut;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSignOut = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSignOut ? Colors.red : Colors.black;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          leading: Icon(icon, color: color, size: 30),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: isSignOut ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          trailing: isSignOut
              ? null
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  color: Colors.grey,
                ),
          onTap: onTap,
        ),
        if (!isSignOut)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 2, color: Colors.black12),
          ),
      ],
    );
  }
}
