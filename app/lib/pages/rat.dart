import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ApplyFiltersPage extends StatefulWidget {
  const ApplyFiltersPage({super.key});

  @override
  State<ApplyFiltersPage> createState() => _ApplyFiltersPageState();
}

class _ApplyFiltersPageState extends State<ApplyFiltersPage> {
  double rating = 4.0;
  bool discount = false;
  bool freeShipping = true;
  bool sameDay = true;

  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Apply Filters",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              setState(() {
                minController.clear();
                maxController.clear();
                rating = 0;
                discount = false;
                freeShipping = false;
                sameDay = false;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === PRICE RANGE ===
            _buildSection(
              title: "Price Range",
              child: Row(
                children: [
                  Expanded(
                    child: _buildInputField("Min.", minController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField("Max.", maxController),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // === STAR RATING ===
            _buildSection(
              title: "Star Rating",
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 28,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() => rating = value);
                      },
                    ),
                    const SizedBox(width: 10),
                    Text("${rating.toStringAsFixed(1)} stars"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // === OTHERS ===
            _buildSection(
              title: "Others",
              child: Column(
                children: [
                  _buildOptionRow(
                    icon: Icons.local_offer_outlined,
                    label: "Discount",
                    value: discount,
                    onChanged: (v) => setState(() => discount = v),
                  ),
                  _buildOptionRow(
                    icon: Icons.local_shipping_outlined,
                    label: "Free shipping",
                    value: freeShipping,
                    onChanged: (v) => setState(() => freeShipping = v),
                  ),
                  _buildOptionRow(
                    icon: Icons.delivery_dining_outlined,
                    label: "Same day delivery",
                    value: sameDay,
                    onChanged: (v) => setState(() => sameDay = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // === APPLY BUTTON ===
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika filter di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Apply filter",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF2F3F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildOptionRow({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label),
      trailing: IconButton(
        icon: Icon(
          value ? Icons.check_circle : Icons.radio_button_unchecked,
          color: value ? Colors.green : Colors.grey,
        ),
        onPressed: () => onChanged(!value),
      ),
    );
  }
}
