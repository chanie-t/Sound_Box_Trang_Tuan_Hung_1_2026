import 'package:flutter/material.dart';
import '../widgets/sound_box_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        "title": "Đừng làm trái tim anh đau",
        "author": "Sơn Tùng M-TP",
        "imageUrl": "/assets/images/Đừng làm trái tim anh đau.jpg",
      },
      {
        "title": "Mượn rượu tỏ tình",
        "author": "EMILY-BIGDADDY",
        "imageUrl": "/assets/images/Mượn rượu tỏ tình_Emily_Bigdaddy.jpg",
      },
      {
        "title": "Thích quá rùi nà",
        "author": "Tlinh",
        "imageUrl": "/assets/images/Thích quá rùi nà_Tlinh.jpg",
      },
      {
        "title": "Chăm hoa",
        "author": "MONO",
        "imageUrl": "/assets/images/Chăm hoa_MONO.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SoundBoxHeader(),
              const SizedBox(height: 30),

              // --- Tiêu đề "Thư viện" ---
              const Text(
                "Danh sách nhạc",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26, // Cỡ 26 chuẩn
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // --- Thanh tìm kiếm ---
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16, // Đồng bộ cỡ 16
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Tìm bài hát hoặc tên ca sĩ",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 16, // Đồng bộ cỡ 16
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Danh sách Audiobooks ---
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          // Ảnh bìa sách
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Tăng góc bo một xíu cho đẹp
                            child: Image.network(
                              book['imageUrl']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Thông tin sách
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title']!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16, // Cỡ 16 chuẩn
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  book['author']!,
                                  style: TextStyle(
                                    color:
                                        Colors.grey.shade700, // Đồng bộ màu xám
                                    fontSize: 14, // Tăng lên 14 chuẩn
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
