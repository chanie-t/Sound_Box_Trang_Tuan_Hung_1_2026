import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/sound_box_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gọi AudioProvider để lấy thông tin bài hát và danh sách yêu thích
    final audioProvider = Provider.of<AudioProvider>(context);

    final List<Map<String, String>> morningSongs = [
      {
        "id": "morning_1",
        "title": "Nhạc chill",
        "artist": "Phương Ly",
        "image": "assets/images/Mặt trời của em_Phuongly.jpg",
        "audioUrl": "assets/sound/Mặt Trời Của Em.mp3",
      },
      {
        "id": "morning_2",
        "title": "Tình yêu",
        "artist": "Sơn Tùng M-TP",
        "image": "assets/images/muộn rồi mà sao còn.jpg",
        "audioUrl": "assets/sound/Muộn Rồi Mà Sao Còn.mp3",
      },
      {
        "id": "morning_3",
        "title": "V-POP",
        "artist": "Sơn Tùng M-TP",
        "image": "assets/images/Lạc Trôi.jpg",
        "audioUrl": "assets/sound/Lạc Trôi.mp3",
      },
      {
        "id": "morning_4",
        "title": "Vui vẻ",
        "artist": "Sơn Tùng M-TP",
        "image": "assets/images/Hãy trao cho anh.jpg",
        "audioUrl": "assets/sound/Hãy Trao Cho Anh.mp3",
      },
    ];

    // Đã chuyển đổi từ danh sách ảnh thành danh sách bài hát có thể phát nhạc
    final List<Map<String, String>> trendingSongs = [
      {
        "id": "trending_1",
        "title": "Cứ chill thôi",
        "artist": "Chillies",
        "image": "assets/images/Cứ chill thôi_chillies.jpg",
        "audioUrl":
            "assets/sound/Cứ Chill Thôi.mp3", // Bạn có thể thay bằng assets/sound/...
      },
      {
        "id": "trending_2",
        "title": "Có công mài sắc",
        "artist": "Ngô Lan Hương",
        "image": "assets/images/Có công mài sắc_Ngolanhuong.jpg",
        "audioUrl":
            "assets/sound/Có công mài 'Sắc'.mp3", // Bạn có thể thay bằng assets/sound/...
      },
      {
        "id": "trending_3",
        "title": "Đừng làm trái tim anh đau",
        "artist": "Sơn Tùng M-TP",
        "image": "assets/images/Đừng làm trái tim anh đau.jpg",
        "audioUrl":
            "assets/sound/Đừng Làm Trái Tim Anh Đau.mp3", // Bạn có thể thay bằng assets/sound/...
      },
      {
        "id": "trending_4",
        "title": "Người im lặng gặp người hay nói",
        "artist": "Hieuthuhai",
        "image": "assets/images/Người im lặng gặp người hay nói.jpg",
        "audioUrl":
            "assets/sound/Người Im Lặng Gặp Người Hay Nói.mp3", // Bạn có thể thay bằng assets/sound/...
      },
    ];

    final List<Map<String, dynamic>> musicUtilities = [
      {"label": "Nhận diện", "icon": Icons.radar_rounded},
      {"label": "Hẹn giờ", "icon": Icons.hourglass_top_rounded},
      {"label": "Bộ chỉnh âm", "icon": Icons.tune_rounded},
      {"label": "Tải về", "icon": Icons.download_for_offline_rounded},
      {"label": "Radio & Pod", "icon": Icons.radio_rounded},
    ];

    final Map<String, String> newSong = {
      "id": "new_song_1",
      "title": "Come My Way",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Comemyway.jpg",
      "audioUrl": "assets/sound/Comemyway.mp3",
    };

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

              // ================= 1. CATEGORIES (GỢI Ý) =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Gợi ý",
                    style: TextStyle(
                      fontSize: 22,
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
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: categoryItem(
                          "Thịnh hành",
                          const Color(0xFFFCE4E4),
                          100,
                          Icons.local_fire_department_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: categoryItem(
                          "Danh sách yêu thích",
                          const Color(0xFFE8E0F5),
                          100,
                          Icons.favorite_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: categoryItem(
                          "Lượt nghe nhiều",
                          const Color(0xFFE3F2FD),
                          115,
                          Icons.trending_up_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: categoryItem(
                          "Dành cho bạn",
                          const Color(0xFFFFF3E0),
                          115,
                          Icons.auto_awesome_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: categoryItem(
                          "Mới phát hành",
                          const Color(0xFFE8F5E9),
                          115,
                          Icons.fiber_new_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // ================= 2. QUICK UTILITIES =================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: musicUtilities.map((utility) {
                    return utilityItem(utility["icon"], utility["label"]);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 35),

              // ================= 3. ALBUM =================
              const Text(
                "Album hot",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: morningSongs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.6,
                ),
                itemBuilder: (context, index) {
                  final song = morningSongs[index];
                  return GestureDetector(
                    onTap: () => audioProvider.playSong(song),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                            ),
                            child: _buildImage(
                              song["image"]!,
                              width: 65,
                              height: double.infinity,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                song["title"]!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // ================= 4. NEW SONGS (ĐÃ SỬA ĐỒNG BỘ TRÁI TIM) =================
              const Text(
                "Bài hát mới",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _buildImage(
                        newSong["image"]!,
                        width: 110,
                        height: 110,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newSong["title"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            newSong["artist"]!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Thay thế icon cũ bằng IconButton kết nối logic từ AudioProvider
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  audioProvider.isFavorite(newSong["id"] ?? "")
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color:
                                      audioProvider.isFavorite(
                                        newSong["id"] ?? "",
                                      )
                                      ? const Color(
                                          0xFF1DB954,
                                        ) // Màu xanh Spotify
                                      : Colors.grey.shade600,
                                  size: 26,
                                ),
                                onPressed: () {
                                  audioProvider.toggleFavorite(newSong);
                                },
                              ),
                              GestureDetector(
                                onTap: () => audioProvider.playSong(newSong),
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3A60E5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
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
              const SizedBox(height: 30),

              // ================= 5. TOP ARTISTS =================
              const Text(
                "Danh sách thịnh hành",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingSongs.length,
                  itemBuilder: (context, index) {
                    final song = trendingSongs[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: GestureDetector(
                        onTap: () => audioProvider.playSong(song),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _buildImage(
                            song["image"]!,
                            width: 110,
                            height: 110,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(
    String imagePath, {
    required double width,
    required double height,
  }) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade200,
            child: const Icon(Icons.music_note_rounded, color: Colors.grey),
          );
        },
      );
    }
  }

  Widget categoryItem(
    String title,
    Color backgroundColor,
    double height,
    IconData icon,
  ) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(icon, size: 32, color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget utilityItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF3A60E5)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
