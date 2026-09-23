import 'package:flutter/material.dart';

// Kartu event yang dipakai di list
class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final IconData icon;
  final VoidCallback? onTap;
  final double? width; 
  final EdgeInsetsGeometry? margin; 

  const EventCard({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.icon,
    this.onTap,
    this.width = 200, 
    this.margin = const EdgeInsets.only(right: 16), 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, 
        margin: margin, 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100, // Dikembalikan ke ukuran semula (100)
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF6A81C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Icon(icon, size: 48, color: Colors.white), // Ukuran ikon disesuaikan
            ),
            Padding(
              padding: const EdgeInsets.all(12), // Padding dikembalikan ke 12
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}