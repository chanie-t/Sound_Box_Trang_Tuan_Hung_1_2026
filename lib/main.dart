import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/playing_screen.dart';
import 'providers/audio_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioProvider(),
      child: const SoundBoxApp(),
    ),
  );
}

class SoundBoxApp extends StatelessWidget {
  const SoundBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Box',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final currentSong = audioProvider.currentSong;

    // --- TÍNH TOÁN TIẾN TRÌNH THỜI GIAN THỰC CHO LINE PROGRESS BAR ---
    double progressFactor = 0.0;
    if (currentSong != null) {
      final positionMs = audioProvider.position.inMilliseconds.toDouble();
      final durationMs = audioProvider.duration.inMilliseconds.toDouble();
      if (durationMs > 0) {
        progressFactor = (positionMs / durationMs).clamp(0.0, 1.0);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= MINI PLAYER THEO MẪU 4 (KHÍT DẦM) =================
          if (currentSong != null)
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const FractionallySizedBox(
                    heightFactor: 0.93,
                    child: PlayingScreen(),
                  ),
                );
              },
              child: Container(
                height: 68,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors
                      .white, // Chuyển sang màu trắng/sáng theo ảnh mẫu của bạn
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade100, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    // 1. Ảnh vuông nhỏ bài hát
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: currentSong["image"]!.startsWith('assets')
                          ? Image.asset(
                              currentSong["image"]!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              currentSong["image"]!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 12),

                    // 2. Tiêu đề và ca sĩ nghệ sĩ
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong["title"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            currentSong["artist"] ?? "Chưa rõ nghệ sĩ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // 3. Biểu tượng tai nghe kết nối (Mẫu số 4)
                    IconButton(
                      icon: Icon(
                        Icons.headphones_outlined,
                        color: Colors.grey.shade700,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),

                    // 4. Biểu tượng trái tim xanh lá cây ĐÃ ĐỒNG BỘ LOGIC
                    IconButton(
                      icon: Icon(
                        audioProvider.isFavorite(currentSong["id"] ?? "")
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: audioProvider.isFavorite(currentSong["id"] ?? "")
                            ? const Color(
                                0xFF1DB954,
                              ) // Màu xanh Spotify khi đã thích
                            : Colors.grey.shade400, // Màu xám khi chưa thích
                        size: 24,
                      ),
                      onPressed: () {
                        audioProvider.toggleFavorite(currentSong);
                      },
                    ),

                    // 5. Nút bấm Play/Pause nguyên bản đen gọn
                    IconButton(
                      icon: Icon(
                        audioProvider.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.black87,
                        size: 30,
                      ),
                      onPressed: () => audioProvider.togglePlay(),
                    ),
                  ],
                ),
              ),
            ),

          // ================= LINE PROGRESS BAR MẢNH ĐÃ ĐỒNG BỘ THỜI GIAN THỰC =================
          if (currentSong != null)
            Container(
              height: 2.5, // Độ dày thanh tiến trình siêu mảnh tinh tế
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor:
                      progressFactor, // Đồng bộ trực tiếp theo thời gian phát thực tế
                  child: Container(color: Colors.black87),
                ),
              ),
            ),

          // ================= NAVIGATION BOTTOM BAR CHUẨN MẪU =================
          Container(
            height: 80,
            color: const Color(0xFFFAFAFA),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_filled, "Home", 0),
                _buildNavItem(Icons.search_rounded, "Search", 1),
                _buildNavItem(Icons.library_music_rounded, "Your Library", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => setState(() => currentIndex = index),
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? Colors.black87 : Colors.grey.shade500,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black87 : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
