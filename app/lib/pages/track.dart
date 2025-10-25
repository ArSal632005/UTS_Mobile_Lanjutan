import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Order Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9F9EF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.inventory_2,
                        color: Colors.green, size: 42),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Order #90897",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Placed on October 19, 2021",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Items: 10   Total: \$16.90",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 Order Tracking Timeline
            buildTimelineItem(
              icon: Icons.inventory_2,
              title: "Order Placed",
              subtitle: "October 21, 2021",
              active: true,
              isLast: false,
            ),
            buildTimelineItem(
              icon: Icons.check_circle_outline,
              title: "Order Confirmed",
              subtitle: "October 21, 2021",
              active: true,
              isLast: false,
            ),
            buildTimelineItem(
              icon: Icons.local_shipping_outlined,
              title: "Order Shipped",
              subtitle: "October 21, 2021",
              active: true,
              isLast: false,
            ),
            buildTimelineItem(
              icon: Icons.delivery_dining,
              title: "Out for Delivery",
              subtitle: "Pending",
              active: false,
              isLast: false,
            ),
            buildTimelineItem(
              icon: Icons.shopping_cart_checkout,
              title: "Order Delivered",
              subtitle: "Pending",
              active: false,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Widget untuk setiap langkah (timeline item)
  Widget buildTimelineItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFE9F9EF) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: active ? Colors.green : Colors.grey,
                size: 36,
              ),
            ),
            if (!isLast)
              Container(
                width: 3,
                height: 70,
                color: active
                    ? Colors.green.withOpacity(0.6)
                    : Colors.grey.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: active ? Colors.black : Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: active ? Colors.black54 : Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
