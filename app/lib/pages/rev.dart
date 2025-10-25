import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ReviewCard(
            image: 'assets/images/baner.jpg',
            name: 'Haylie Aminoff',
            time: '32 minutes ago',
            rating: 4.5,
            text: 'Lorem ipsum dolor sit amet, consectetur sadi sspcing elitr, sed diam nonumy',
          ),
          ReviewCard(
            image: 'assets/images/baner.jpg',
            name: 'Carla Septimus',
            time: '32 minutes ago',
            rating: 4.5,
            text: 'Lorem ipsum dolor sit amet, consectetur sadi sspcing elitr, sed diam nonumy',
          ),
          ReviewCard(
            image: 'assets/images/baner.jpg',
            name: 'Carla George',
            time: '32 minutes ago',
            rating: 4.5,
            text: 'Lorem ipsum dolor sit amet, consectetur sadi sspcing elitr, sed diam nonumy',
          ),
          ReviewCard(
            image: 'assets/images/baner.jpg',
            name: 'Maren Kentor',
            time: '32 minutes ago',
            rating: 4.5,
            text: 'Lorem ipsum dolor sit amet, consectetur sadi sspcing elitr, sed diam nonumy',
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String image, name, time, text;
  final double rating;

  const ReviewCard({
    super.key,
    required this.image,
    required this.name,
    required this.time,
    required this.rating,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 24,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                rating.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star_half, color: Colors.amber, size: 18),
            ],
          ),
          const SizedBox(height: 5),
          Text(text, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
