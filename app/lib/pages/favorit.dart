import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoritesPage extends StatefulWidget {
  final List<Map<String, String>> favoriteItems;

  const FavoritesPage({super.key, required this.favoriteItems});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Map<String, int> itemCounts = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.favoriteItems) {
      itemCounts[item['name']!] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: widget.favoriteItems.isEmpty
          ? const Center(child: Text('Belum ada favorit'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.favoriteItems.length,
              itemBuilder: (context, index) {
                final item = widget.favoriteItems[index];
                final name = item['name']!;
                final image = item['image']!;
                final price = item['price']!;
                final unit = item['unit']!;
                final count = itemCounts[name] ?? 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Slidable(
                    key: ValueKey(name),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              widget.favoriteItems.removeAt(index);
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                image,
                                width: screenWidth * 0.18,
                                height: screenWidth * 0.18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$$price x 4",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6AB04A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    unit,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol + dan - serta jumlah
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      itemCounts[name] = count + 1;
                                    });
                                  },
                                  child: const Icon(Icons.add,
                                      color: Colors.green, size: 22),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    count.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (count > 1) {
                                      setState(() {
                                        itemCounts[name] = count - 1;
                                      });
                                    }
                                  },
                                  child: const Icon(Icons.remove,
                                      color: Colors.green, size: 22),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
