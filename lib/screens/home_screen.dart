import 'package:flutter/material.dart';
import '../widgets/sound_box_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> morningSongs = [
      {
        "title": "Nhạc chill",
        "image": "/assets/images/Mặt trời của em_Phuongly.jpg",
      },
      {"title": "Tình yêu", "image": "/assets/images/muộn rồi mà sao còn.jpg"},
      {"title": "V-POP", "image": "/assets/images/Lạc trôi.jpg"},
      {"title": "Vui vẻ", "image": "/assets/images/Hãy trao cho anh.jpg"},
    ];

    final List<String> artists = [
      "/assets/images/Cứ chill thôi_chillies.jpg",
      "/assets/images/Có công mài sắc_Ngolanhuong.jpg",
      "/assets/images/Đừng làm trái tim anh đau.jpg",
      "/assets/images/Người im lặng gặp người hay nói.jpg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SoundBoxHeader(),
              const SizedBox(height: 30),

              // ================= CATEGORIES =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Gợi ý",
                    style: TextStyle(
                      fontSize: 22, // Đồng bộ cỡ 22
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Xem thêm",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryItem("Thịnh hành"),
                    categoryItem("Danh sách yêu thích"),
                    categoryItem("Lượt nghe nhiều nhất"),
                    categoryItem("Dành cho bạn"),
                    categoryItem("Mới phát hành"),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // ================= GOOD MORNING =================
              const Text(
                "Album",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: morningSongs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2.7,
                ),
                itemBuilder: (context, index) {
                  final song = morningSongs[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                          child: Image.network(
                            song["image"]!,
                            width: 70,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              song["title"]!,
                              style: const TextStyle(
                                fontSize: 16, // Đồng bộ cỡ 16
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),

              // ================= NEW SONGS =================
              const Text(
                "Bài hát mới",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "/assets/images/Nơi này có anh.jpg",
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Truyền cảm hứng",
                            style: TextStyle(
                              fontSize: 16, // Đồng bộ cỡ 16
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Danh sách nhạc xu hướng",
                            style: TextStyle(
                              fontSize: 14, // Đồng bộ cỡ 14
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.black,
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // ================= TOP ARTISTS =================
              const Text(
                "Danh sách thịnh hành",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          artists[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Bỏ màu tím, đồng bộ đen
          ),
        ),
      ),
    );
  }
}
