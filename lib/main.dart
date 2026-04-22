import 'package:flutter/material.dart';
import 'Songclass.dart';   // Đảm bảo file này tên là Songclass.dart
import 'Listtenclass.dart';

void main() {
  runApp(const MyApp());
}

// --- 1. GENERIC CLASS ---
class SoundBoxContainer<T> {
  T obj;
  SoundBoxContainer(this.obj);

  void printToConsole() {
    print("--- DỮ LIỆU TRONG SOUND BOX ---");
    if (obj is List) {
      for (var item in (obj as List)) {
        print(item);
      }
    } else {
      print(obj);
    }
    print("-------------------------------");
  }
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
  // Khai báo manager để quản lý CRUD
  final Listtenclass manager = Listtenclass();
  
  // Khai báo Container cho yêu cầu Generics
  late SoundBoxContainer<List<Song>> _soundBox;

  final Map<String, dynamic> _appInfo = {
    'version': '2.0.1',
    'user_type': 'Premium',
    'last_update': '15/04/2026',
  };

  var listSuggest = [
    {'id': 1, 'name': 'Waiting For You'},
    {'id': 2, 'name': 'Em Của Ngày Hôm Qua'},
    {'id': 3, 'name': 'Hãy Trao Cho Anh'},
    {'id': 4, 'name': 'Có Chắc Yêu Là Đây'},
  ];

  Song? _currentPlaying;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    
    // --- THỰC HIỆN CRUD TẠI ĐÂY ---
    
    // 1. CREATE: Thêm dữ liệu vào manager
    manager.createSong(Song(id: '01', title: 'Lâu Đài Tình Ái', artist: 'Mỹ Tâm', imageUrl: 'https://picsum.photos/200', audioUrl: 'url1'));
    manager.createSong(Song(id: '02', title: 'Chăm Hoa', artist: 'MONO', imageUrl: 'https://picsum.photos/201', audioUrl: 'url2'));
    manager.createSong(Song(id: '03', title: 'Nơi Này Có Anh', artist: 'Sơn Tùng M-TP', imageUrl: 'https://picsum.photos/202', audioUrl: 'url3'));
    manager.createSong(Song(id: '04', title: 'Lan Man', artist: 'Ronboogz', imageUrl: 'https://picsum.photos/203', audioUrl: 'url4'));
    // 2. UPDATE: Sửa thử một bài hát
    manager.updateSong('01', newTitle: 'Lâu Đài Tình Ái (Remix)');

    // 3. READ: Lấy danh sách đã qua xử lý để đưa vào Generic Container
    List<Song> currentSongs = manager.getAllSongs();
    _soundBox = SoundBoxContainer<List<Song>>(currentSongs);

    // 4. PRINT: Kiểm tra kết quả ở Console
    _soundBox.printToConsole();
    manager.printAll(); 
  }

  void _handlePlay(Song song) {
    setState(() {
      _currentPlaying = song;
      _isPlaying = true;
    });
    song.play(); 
  }

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ Generic Container để vẽ giao diện
    final displayList = _soundBox.obj;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          Expanded(
            child: ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final song = displayList[index]; 
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
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          setState(() {
                            manager.updateSong(song.id, newTitle: "${song.title} (Remix)");
                          });
                        } else if (value == 'delete') {
                          setState(() {
                            manager.deleteSong(song.id);
                          });
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text("Sửa tên")),
                        const PopupMenuItem(value: 'delete', child: Text("Xóa bài")),
                      ],
                    ),
                    onTap: () => _handlePlay(song),
                  ),
                );
              },
            ),
          ),
          
                    // Phần hiển thị Đề xuất
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

          // Thanh Player Control
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
      floatingActionButton: FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      setState(() {
        manager.createSong(Song(
          id: DateTime.now().toString(), 
          title: "Bài hát mới ${manager.getAllSongs().length + 1}",
          artist: "Ca sĩ mới",
          imageUrl: "https://picsum.photos/204",
          audioUrl: "url"
        ));
      });
    },
  ),
);
  }
}