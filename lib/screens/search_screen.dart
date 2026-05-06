import 'package:flutter/material.dart';
import '../widgets/sound_box_header.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {
        "title": "Nơi này có anh",
        "author": "Sơn Tùng M-TP",
        "image": "/assets/images/Nơi này có anh.jpg",
      },
      {
        "title": "Lạc Trôi",
        "author": "Sơn Tùng M-TP",
        "image": "/assets/images/Lạc trôi.jpg",
      },
      {
        "title": "Yêu nắm",
        "author": "EMILY-BIGDADDY",
        "image": "/assets/images/Yêu nắm_Emily_Bigdaddy.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Đồng bộ nền trắng
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SoundBoxHeader(),
                const SizedBox(height: 40),

                // ================= TITLE =================
                const Text(
                  "Khám phá",
                  style: TextStyle(
                    color: Colors.black, // Bỏ màu tím
                    fontSize: 26, // Đồng bộ cỡ 26
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // ================= SEARCH BOX =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100, // Đồng bộ khung search
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16, // Đồng bộ cỡ 16
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black, // Bỏ màu tím
                      ),
                      hintText: "Tìm kiếm bài hát, ca sĩ",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16, // Đồng bộ cỡ 16
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // ================= SEARCH RESULT TITLE =================
                const Text(
                  "Kết quả tìm kiếm",
                  style: TextStyle(
                    color: Colors.black, // Bỏ màu tím
                    fontSize: 22, // Đồng bộ cỡ 22 (Tiêu đề phụ)
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // ================= BOOK GRID =================
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.58,
                  ),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            book["image"]!,
                            height: 230,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // TITLE
                        Text(
                          book["title"]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black, // Bỏ màu tím
                            fontSize: 16, // Đồng bộ cỡ 16
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // AUTHOR
                        Text(
                          book["author"]!,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14, // Đồng bộ cỡ 14
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
