import 'package:flutter/material.dart';
// Lưu ý 1: Hãy sửa lại đường dẫn import này cho khớp với cấu trúc thư mục thực tế của bạn
import '../giuaki/screens/Content.dart'; 
// Lưu ý 2: Import file SettingsScreen mà chúng ta đã tạo ở bước trước
import '../screens/settings_screen.dart'; // Sửa lại đường dẫn này nếu cần

class SoundBoxHeader extends StatelessWidget {
  const SoundBoxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const String logoImagePath = "assets/images/logo 2.png";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LOGO và TÊN ỨNG DỤNG
        Row(
          children: [
            ClipOval(
              // Đã đổi từ Image.network thành Image.asset vì đây là ảnh có sẵn trong máy
              child: Image.asset(
                logoImagePath,
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

        // CÁC ICONS BÊN PHẢI (Giỏ hàng, Thông báo, Lịch sử, Cài đặt)
        Row(
          children: [
            // Icon Giỏ hàng
            GestureDetector(
              onTap: () {
                // Chuyển hướng sang file Content.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentScreen(),
                  ),
                );
              },
              child: const Icon(Icons.shopping_cart_outlined, size: 28),
            ),

            const SizedBox(width: 15),

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

            // Icon Cài đặt (Đã thêm sự kiện chuyển trang)
            GestureDetector(
              onTap: () {
                // Chuyển hướng sang trang SettingsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Icon(Icons.settings, size: 28),
            ),
          ],
        ),
      ],
    );
  }
}