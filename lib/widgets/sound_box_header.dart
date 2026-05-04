import 'package:flutter/material.dart';

class SoundBoxHeader extends StatelessWidget {
  const SoundBoxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const String logoImageUrl = "assets/images/logo 2.png";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LOGO và TÊN ỨNG DỤNG
        Row(
          children: [
            ClipOval(
              child: Image.network(
                logoImageUrl,
                width: 35,
                height: 35,
                fit: BoxFit.cover,
                // Trong khi load hoặc lỗi, hiện icon nhạc thay thế
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.music_note,
                  color: Colors.purple,
                  size: 30,
                ),
              ),
            ),

            const SizedBox(width: 8),

            Text(
              "Sound Box",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),

        // CÁC ICONS BÊN PHẢI (Thông báo, Lịch sử, Cài đặt)
        Row(
          children: [
            // Icon Thông báo có dấu đỏ
            Stack(
              children: [
                const Icon(Icons.notifications_none, size: 28),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 15),

            // Icon Lịch sử
            const Icon(Icons.history, size: 28),

            const SizedBox(width: 15),

            // Icon Cài đặt
            const Icon(Icons.settings, size: 28),
          ],
        ),
      ],
    );
  }
}
