import 'package:flutter/material.dart';

void main() {
  runApp(const SoundboxApp());
}

class SoundboxApp extends StatelessWidget {
  const SoundboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soundbox Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ), // Màu nền tối hiện đại (bạn đang set nền trắng ở đây)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const SoundboxHomeScreen(),
    );
  }
}

class SoundboxHomeScreen extends StatelessWidget {
  const SoundboxHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------------
    // YÊU CẦU 1: Sử dụng các biến liên quan đến ứng dụng phát nhạc
    // ---------------------------------------------------------
    String currentSong = "Nơi Này Có Anh";
    double volumeLevel = 80.0;
    bool isPlaying = true;

    // ---------------------------------------------------------
    // YÊU CẦU 2: Sử dụng Collections (Map, List)
    // ---------------------------------------------------------
    Map<String, String> trackInfo = {
      'Ca sĩ': 'Sơn Tùng M-TP',
      'Thể loại': 'Pop / R&B',
      'Năm phát hành': '2017',
      'Định dạng': 'Lossless (FLAC)',
    };

    List<String> upNextPlaylist = [
      'Chạy Ngay Đi',
      'Hãy Trao Cho Anh',
      'Muộn Rồi Mà Sao Còn',
      'Có Chắc Yêu Là Đây',
    ];

    // ---------------------------------------------------------
    // YÊU CẦU 4: Tạo List tương ứng đối tượng (Object) trong Project
    // ---------------------------------------------------------
    List<SongObject> objectPlaylist = [
      SongObject(
        title: 'Âm Thầm Bên Em',
        artist: 'Sơn Tùng M-TP',
        duration: '4:55',
      ),
      SongObject(title: 'Lạc Trôi', artist: 'Sơn Tùng M-TP', duration: '3:53'),
      SongObject(
        title: 'Chúng Ta Của Hiện Tại',
        artist: 'Sơn Tùng M-TP',
        duration: '5:01',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sound Box',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color.fromARGB(240, 20, 20, 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Thêm ScrollView bọc ngoài để tránh lỗi tràn màn hình ở máy nhỏ
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- YÊU CẦU 1: HIỂN THỊ BIẾN CƠ BẢN ---
            const Text(
              'Đang phát',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 20, 20, 20),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5E35B1),
                    Color(0xFF3949AB),
                  ], // Gradient Tím - Xanh
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5E35B1).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note_rounded,
                        color: Color.fromARGB(255, 249, 249, 249),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          currentSong,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.volume_up_rounded,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${volumeLevel.toInt()}%',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(252, 74, 73, 73),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isPlaying ? 'Đang phát' : 'Tạm dừng',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- YÊU CẦU 3: HIỂN THỊ DỮ LIỆU TỪ MAP BẰNG TEXT ---
            const Text(
              'Thông tin Track',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 4, 4, 4),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(
                  0xFF262A34,
                ), // Màu xám đen nổi bật trên nền tối
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var entry in trackInfo.entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.indigoAccent[100],
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${entry.key}: ',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- YÊU CẦU 3: HIỂN THỊ DỮ LIỆU TỪ LIST BẰNG ROW ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tiếp theo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(179, 7, 7, 7),
                  ),
                ),
                Icon(Icons.queue_music_rounded, color: Colors.white70),
              ],
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: upNextPlaylist.map((song) {
                  return Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(
                        0.15,
                      ), // Màu nền nhẹ nhàng
                      border: Border.all(
                        color: Colors.indigoAccent.withOpacity(0.3),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ), // Hình dáng viên thuốc (pill)
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.indigoAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          song,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 6, 6, 6),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),

            // --- YÊU CẦU 4: HIỂN THỊ LIST ĐỐI TƯỢNG (OBJECT) ---
            const Text(
              'Danh sách phát (Từ List Object)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 7, 7, 7),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: objectPlaylist.map((songObj) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF262A34,
                    ), // Màu nền tối đồng bộ với khối Map
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.music_video_rounded,
                        color: Colors.indigoAccent,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songObj.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              songObj.artist,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        songObj.duration,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30), // Lề dưới cùng
          ],
        ),
      ),
    );
  }
}

// =========================================================
// YÊU CẦU 4: Class định nghĩa Đối tượng (Object)
// =========================================================
class SongObject {
  final String title;
  final String artist;
  final String duration;

  SongObject({
    required this.title,
    required this.artist,
    required this.duration,
  });
}
