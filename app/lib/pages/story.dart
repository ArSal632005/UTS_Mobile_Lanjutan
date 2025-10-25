import 'package:flutter/material.dart';

class SearchStoryPage extends StatefulWidget {
  const SearchStoryPage({super.key});

  @override
  State<SearchStoryPage> createState() => _SearchStoryPageState();
}

class _SearchStoryPageState extends State<SearchStoryPage> {
  final TextEditingController searchController = TextEditingController();

  final List<String> searchHistory = [
    "Fresh Grocery",
    "Bananas",
    "cheetos",
    "vegetables",
    "Fruits",
    "discounted items",
    "Fresh vegetables"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search keywords..',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(Icons.tune, color: Colors.grey),
              const SizedBox(width: 8),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Search History ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Search History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("clear", style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: searchHistory
                  .map((item) => Chip(
                        label: Text(item),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // === Discover More ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discover more",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("clear", style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: searchHistory
                  .map((item) => Chip(
                        label: Text(item),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ))
                  .toList(),
            ),
            const Spacer(),

            // === Bottom Buttons ===
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text("Image Search"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_none_outlined),
                    label: const Text("Voice Search"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
