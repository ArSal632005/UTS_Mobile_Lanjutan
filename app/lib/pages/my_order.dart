import 'package:flutter/material.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  int expandedIndex = 0; // indeks card yang terbuka

  final List<Map<String, dynamic>> orders = [
    {
      "id": "#90897",
      "date": "October 19 2021",
      "items": 10,
      "price": 16.90,
      "status": [
        {"label": "Order placed", "date": "Oct 19 2021", "done": true},
        {"label": "Order confirmed", "date": "Oct 20 2021", "done": true},
        {"label": "Order shipped", "date": "Oct 20 2021", "done": true},
        {"label": "Out for delivery", "date": "pending", "done": false},
        {"label": "Order delivered", "date": "pending", "done": false},
      ],
    },
    {
      "id": "#90900",
      "date": "Aug 29 2021",
      "items": 10,
      "price": 16.90,
      "status": [
        {"label": "Order Delivered", "date": "Aug 29 2021", "done": true},
      ],
    },
    {
      "id": "#90901",
      "date": "Aug 29 2021",
      "items": 10,
      "price": 16.90,
      "status": [
        {"label": "Order Delivered", "date": "Aug 29 2021", "done": true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Order",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final bool isExpanded = expandedIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.inventory_2_outlined,
                            color: Colors.green, size: 26),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ${order['id']}",
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Placed on ${order['date']}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Items: ${order['items']}   Items: \$${order['price']}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            expandedIndex = isExpanded ? -1 : index;
                          });
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.green,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status detail
                if (isExpanded)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      children: order['status'].map<Widget>((s) {
                        bool isLast = s == order['status'].last;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timeline
                            Column(
                              children: [
                                Icon(
                                  s['done']
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: s['done']
                                      ? Colors.green
                                      : Colors.grey.shade400,
                                  size: 20,
                                ),
                                if (!isLast)
                                  Container(
                                    width: 2,
                                    height: 28,
                                    color: s['done']
                                        ? Colors.green
                                        : Colors.grey.shade300,
                                  ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s['label'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: s['done']
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                    Text(
                                      s['date'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: s['done']
                                            ? Colors.black87
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
