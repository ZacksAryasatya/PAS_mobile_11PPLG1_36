import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> favorite;
  final VoidCallback onDelete;

  const FavoriteCard({
    super.key,
    required this.favorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              favorite['image'] ?? '',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 90,
                height: 90,
                color: Colors.grey[100],
                child: Icon(Icons.broken_image_outlined, size: 30, color: Colors.grey[400]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite['title'] ?? 'Nama Produk',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const Spacer(), 
                  Text(
                    '\$${(favorite['price'] as num? ?? 0).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star_rate_rounded, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        "${favorite['rating']} (${favorite['rating_count']} ulasan)",
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: onDelete, 
                icon: Icon(
                  Icons.close, 
                  color: Colors.grey[500],
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}