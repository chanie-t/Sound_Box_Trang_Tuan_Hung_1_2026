import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng Dụng Nghe Nhạc Pro',
      debugShowCheckedModeBanner: false, // Ẩn chữ Debug góc phải
      theme: ThemeData(
        // Sử dụng Dark Theme làm chủ đạo
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 1. BIẾN TRẠNG THÁI
  int _counter = 0;
  String songTitle = 'Nơi Này Có Anh';
  String artist = 'Sơn Tùng M-TP';
  int playCount = 1500;
  bool isPlaying = false;
  double currentProgress = 30.0; // Biến cho thanh tiến trình bài hát

  // 2. COLLECTIONS (LIST, MAP)
  List<String> nextSongs = [
    'Chạy Ngay Đi',
    'Lạc Trôi',
    'Hãy Trao Cho Anh',
    'Âm Thầm Bên Em'
  ];

  Map<String, Color> genreColors = {
    'Pop': Colors.pinkAccent,
    'R&B': Colors.blueAccent,
    'EDM': Colors.orangeAccent,
    'Ballad': Colors.teal,
    'Acoustic': Colors.brown,
  };

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _togglePlay() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dùng Container bọc toàn bộ body để tạo màu nền Gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1055), // Tím đậm
              Color(0xFF0F0817), // Đen tím
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // Hiệu ứng cuộn mượt
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- 1. PHẦN HEADER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.keyboard_arrow_down, size: 30), onPressed: () {}),
                    const Text('ĐANG PHÁT TỪ PLAYLIST', style: TextStyle(fontSize: 12, letterSpacing: 2, color: Colors.white70)),
                    IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 30),

                // --- 2. ẢNH BÌA BÀI HÁT (ALBUM ART) ---
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple.shade800,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    // Thêm hình ảnh thật nếu có URL, ở đây dùng Icon thay thế
                    gradient: const LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.music_note_rounded, size: 150, color: Colors.white54),
                ),
                const SizedBox(height: 40),

                // --- 3. THÔNG TIN BÀI HÁT ---
                Text(
                  songTitle,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  artist,
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 30),

                // --- 4. THANH TIẾN TRÌNH (SLIDER) ---
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    value: currentProgress,
                    max: 100,
                    onChanged: (value) {
                      setState(() { currentProgress = value; });
                    },
                  ),
                ),
                // Thời gian (Giả lập)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1:20', style: TextStyle(color: Colors.white54, fontSize: 12)),
                      Text('4:30', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // --- 5. BỘ ĐIỀU KHIỂN (CONTROLS) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.shuffle, color: Colors.white54), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.skip_previous, size: 40, color: Colors.white), onPressed: () {}),
                    // Nút Play/Pause cỡ lớn
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        iconSize: 50,
                        color: Colors.black,
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: _togglePlay,
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.skip_next, size: 40, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.repeat, color: Colors.white54), onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 40),

                // --- 6. THỂ LOẠI (MAP -> DẠNG CHUỖI SCROLL NGANG) ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Thể loại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                // Bọc Row bằng SingleChildScrollView ngang để không bị lỗi tràn màn hình khi Map có nhiều item
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      for (final MapEntry<String, Color> entry in genreColors.entries)
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: entry.value.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            entry.key,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- 7. DANH SÁCH CHỜ (LIST -> COLUMN) ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tiếp theo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                Column(
                  children: nextSongs.map((song) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05), // Hiệu ứng kính (Glassmorphism)
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.music_note, color: Colors.white),
                        ),
                        title: Text(song, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(artist, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        trailing: const Icon(Icons.more_horiz, color: Colors.white54),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),

                // --- 8. PHẦN THÔNG TIN SINH VIÊN & BIẾN ĐẾM CŨ ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    children: [
                      const Text('👨‍💻 Thông tin nhóm thực hiện', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                      const Divider(color: Colors.white24),
                      const Text('Nguyễn Đỗ Phi Hùng (23010606)', style: TextStyle(color: Colors.white54)),
                      const Text('Nguyễn Thuỳ Trang (23010606)', style: TextStyle(color: Colors.white54)),
                      const Text('Bùi Thanh Tuân (23010606)', style: TextStyle(color: Colors.white54)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Đã bấm Add: $_counter lần ', style: const TextStyle(color: Colors.amber)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Nút FloatingActionButton vẫn giữ lại để thực hiện hàm đếm
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}