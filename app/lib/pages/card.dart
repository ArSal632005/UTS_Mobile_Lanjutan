import 'package:flutter/material.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  bool makeDefault = true;
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cards",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildCardItem(
              title: "Master Card",
              number: "XXXX XXXX XXXX 5678",
              expiry: "01/22",
              cvv: "908",
              isDefault: true,
              index: 0,
            ),
            const SizedBox(height: 12),
            buildCardItem(
              title: "Visa Card",
              number: "XXXX XXXX XXXX 5678",
              expiry: "01/22",
              cvv: "908",
              index: 1,
            ),
            const SizedBox(height: 12),
            buildCardItem(
              title: "Master Card",
              number: "XXXX XXXX XXXX 5678",
              expiry: "01/22",
              cvv: "908",
              index: 2,
            ),
            const Spacer(),
            // === Save Settings Button ===
          SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton(
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Settings saved!")),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    child: Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          "Save settings",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  Widget buildCardItem({
    required String title,
    required String number,
    required String expiry,
    required String cvv,
    required int index,
    bool isDefault = false,
  }) {
    bool isSelected = selectedCard == index;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "DEFAULT",
                style: TextStyle(
                    color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: title.contains("Visa")
                        ? const AssetImage('assets/images/v.png')
                        : const AssetImage('assets/images/m.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(number, style: const TextStyle(color: Colors.grey)),
                      Text("Expiry: $expiry   CVV: $cvv",
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() => selectedCard = index);
                },
              ),
            ],
          ),
          if (isDefault)
            Column(
              children: [
                const SizedBox(height: 10),
                _buildInputField(Icons.person_outline, "Russell Austin"),
                _buildInputField(Icons.credit_card, number),
                Row(
                  children: [
                    Expanded(child: _buildInputField(Icons.date_range, expiry)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildInputField(Icons.lock_outline, cvv)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Make default",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    Switch(
                      value: makeDefault,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        setState(() => makeDefault = val);
                      },
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
