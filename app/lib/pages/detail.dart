import 'package:flutter/material.dart';
import 'cart.dart'; // pastikan file cart.dart ada
import '../models/model.dart'; // pastikan CartItem ada di sini
import 'rev.dart';
class ProductDetailPage extends StatefulWidget {
  final String name;
  final String price;
  final String unit;
  final String image;
  final List<Color> gradientColors;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    required this.image,
    required this.gradientColors,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  List<CartItem> cartItems = []; // 🛒 keranjang lokal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Bagian atas (gambar + gradasi)
            Stack(
              children: [
                Container(
                  height: 330,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      widget.image,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🟣 Bagian detail produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp${widget.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.unit,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  // ⭐ Rating + Review
                GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReviewsPage()),
    );
  },
  child: Row(
    children: const [
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star_half, color: Colors.amber, size: 18),
      SizedBox(width: 6),
      Text(
        "4.5 (89 reviews)",
        style: TextStyle(color: Colors.grey),
      ),
    ],
  ),
),


                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black87, height: 1.5),
                      children: [
                        TextSpan(
                          text:
                              "Organic Mountain works as a seller for many organic growers of organic lemons. "
                              "They are easy to spot in your produce aisle and considered the world’s finest lemons for juicing. ",
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // 🔹 Quantity + tombol "-"
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Quantity",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🔹 Angka
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // 🔹 Tombol "+"
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () => setState(() => quantity++),
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 🛒 Tombol Add to Cart (fungsi diperbaiki)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // 🟢 Tambah item ke keranjang
                        final newItem = CartItem(
                          name: widget.name,
                          price: widget.price,
                          unit: widget.unit,
                          image: widget.image,
                          quantity: quantity,
                        );

                        setState(() {
                          cartItems.add(newItem);
                        });

                        // 🟢 Tampilkan snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${widget.name} ditambahkan ke keranjang (${quantity}x)",
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        // 🟢 Pindah ke halaman keranjang
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CartPage(cartItems: cartItems),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
