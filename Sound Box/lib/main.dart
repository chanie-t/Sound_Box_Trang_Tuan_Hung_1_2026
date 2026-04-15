import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// --- 1. ĐỊNH NGHĨA CÁC ĐỐI TƯỢNG (MODELS & VARIABLES) ---
class Song {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sound Box'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // --- YÊU CẦU 2: SỬ DỤNG COLLECTIONS (LIST & MAP) ---
  final List<Song> _songList = [
    Song(id: '01', title: 'Lâu Đài Tình Ái', artist: 'Mỹ Tâm', imageUrl: 'https://picsum.photos/200'),
    Song(id: '02', title: 'Chăm Hoa', artist: 'MONO', imageUrl: 'https://picsum.photos/201'),
    Song(id: '03', title: 'Nơi Này Có Anh', artist: 'Sơn Tùng M-TP', imageUrl: 'https://picsum.photos/202'),
    Song(id: '04', title: 'Lan Man', artist: 'Ronboogz', imageUrl: 'https://picsum.photos/203'),
  ];

  final Map<String, dynamic> _appInfo = {
    'version': '2.0.1',
    'user_type': 'Premium',
    'last_update': '15/04/2026',
  };

  // --- YÊU CẦU 4: TẠO LIST BẰNG LỆNH VAR ---
  var listSuggest = [
    {'id': 1, 'name': 'Waiting For You'},
    {'id': 2, 'name': 'Em Của Ngày Hôm Qua'},
    {'id': 3, 'name': 'Hãy Trao Cho Anh'},
    {'id': 4, 'name': 'Có Chắc Yêu Là Đây'},
  ];

  Song? _currentPlaying;
  bool _isPlaying = false;

  void _handlePlay(Song song) {
    setState(() {
      _currentPlaying = song;
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- YÊU CẦU 3: HIỂN THỊ DỮ LIỆU TỪ MAP (TRÊN CÙNG) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.withOpacity(0.1),
            child: Text(
              'Phiên bản: ${_appInfo['version']} | Gói: ${_appInfo['user_type']}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),

          // --- YÊU CẦU 3: DANH SÁCH CHÍNH (GIỮA) ---
          Expanded(
            child: ListView.builder(
              itemCount: _songList.length,
              itemBuilder: (context, index) {
                final song = _songList[index]; 
                final bool isSelected = _currentPlaying?.id == song.id;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: isSelected ? 4 : 1,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(song.imageUrl),
                    ),
                    title: Text(song.title, 
                      style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                    subtitle: Text(song.artist),
                    trailing: Icon(
                      isSelected && _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    onTap: () => _handlePlay(song),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),

          // --- YÊU CẦU 4: HIỂN THỊ LIST ĐỀ XUẤT ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Đề xuất các bài hát khác:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                for (var item in listSuggest)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      "${item['id']} - ${item['name']}",
                      style: const TextStyle(fontSize: 13, color: Colors.blueGrey),
                    ),
                  ),
              ],
            ),
          ),

          // Player Control Bar (Dưới cùng của màn hình)
          if (_currentPlaying != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Đang phát: ${_currentPlaying!.title} - ${_currentPlaying!.artist}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () => setState(() => _isPlaying = !_isPlaying),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}