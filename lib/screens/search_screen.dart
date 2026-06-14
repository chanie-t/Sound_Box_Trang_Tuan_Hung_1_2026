import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/sound_box_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Bộ điều khiển ô nhập liệu để kiểm tra trạng thái text rỗng hay không
  final TextEditingController _searchController = TextEditingController();

  // 1. Kho dữ liệu gốc bài hát
  final List<Map<String, String>> _allSongs = [
    {
      "id": "song_1",
      "title": "Nơi này có anh",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Nơi này có anh.jpg",
      "audioUrl": "assets/sound/NoiNayCoAnh_SonTungMTP.mp3",
    },
    {
      "id": "song_2",
      "title": "Lạc Trôi",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Lạc Trôi.jpg",
      "audioUrl": "assets/sound/Lạc Trôi.mp3",
    },
    {
      "id": "song_3",
      "title": "Yêu nắm",
      "artist": "EMILY-BIGDADDY",
      "image": "assets/images/Yêu nắm_Emily_Bigdaddy.jpg",
      "audioUrl": "assets/sound/Yêu Nắm.mp3",
    },
    {
      "id": "morning_1",
      "title": "Mặt trời của em",
      "artist": "Phương Ly",
      "image": "assets/images/Mặt trời của em_Phuongly.jpg",
      "audioUrl": "assets/sound/Mặt Trời Của Em.mp3",
    },
    {
      "id": "morning_2",
      "title": "Muộn rồi mà sao còn",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/muộn rồi mà sao còn.jpg",
      "audioUrl": "assets/sound/Muộn Rồi Mà Sao Còn.mp3",
    },
    {
      "id": "morning_4",
      "title": "Hãy trao cho anh",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Hãy trao cho anh.jpg",
      "audioUrl": "assets/sound/Hãy Trao Cho Anh.mp3",
    },
    {
      "id": "trending_1",
      "title": "Cứ chill thôi",
      "artist": "Chillies",
      "image": "assets/images/Cứ chill thôi_chillies.jpg",
      "audioUrl": "assets/sound/Cứ Chill Thôi.mp3",
    },
    {
      "id": "trending_2",
      "title": "Có công mài sắc",
      "artist": "Ngô Lan Hương",
      "image": "assets/images/Có công mài sắc_Ngolanhuong.jpg",
      "audioUrl": "assets/sound/Có công mài 'Sắc'.mp3",
    },
    {
      "id": "trending_3",
      "title": "Đừng làm trái tim anh đau",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Đừng làm trái tim anh đau.jpg",
      "audioUrl": "assets/sound/Đừng Làm Trái Tim Anh Đau.mp3",
    },
    {
      "id": "trending_4",
      "title": "Người im lặng gặp người hay nói",
      "artist": "Hieuthuhai",
      "image": "assets/images/Người im lặng gặp người hay nói.jpg",
      "audioUrl": "assets/sound/Người Im Lặng Gặp Người Hay Nói.mp3",
    },
  ];

  // 2. Danh sách kết quả lọc sau khi tìm kiếm
  List<Map<String, String>> _foundSongs = [];

  @override
  void initState() {
    super.initState();
    _foundSongs = []; // Mới vào chưa tìm kiếm, danh sách lọc để trống
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 3. Hàm lọc dữ liệu
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.trim().isNotEmpty) {
      results = _allSongs.where((song) {
        final titleMatch = song["title"]!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        );
        final artistMatch = song["artist"]!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        );
        return titleMatch || artistMatch;
      }).toList();
    }

    setState(() {
      _foundSongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    final isSearching = _searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            // Giúp hiệu ứng chuyển động mượt mà không bị lỗi layout tràn viền
            clipBehavior: Clip.none,
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
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // ================= SEARCH BOX =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.black),
                      suffixIcon: isSearching
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                _runFilter("");
                              },
                            )
                          : null,
                      hintText: "Tìm kiếm bài hát, ca sĩ",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // ================= ANIMATED SWITCHER (HIỆU ỨNG RƠI / ĐỔI MÀN HÌNH) =================
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve:
                      Curves.easeOutQuad, // Hiệu ứng rơi thả lỏng mượt mà
                  switchOutCurve: Curves.easeInQuad,
                  // LayoutBuilder giữ cho cấu trúc chiều rộng đồng bộ khi animate
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    );
                  },
                  child: !isSearching
                      ? _buildDefaultSuggestions(
                          audioProvider,
                        ) // Khung gợi ý mặc định
                      : _buildSearchResults(
                          audioProvider,
                        ), // Khung kết quả tìm kiếm rơi xuống
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Khung UI 1: Gợi ý mặc định ban đầu khi chưa gõ chữ
  Widget _buildDefaultSuggestions(AudioProvider audioProvider) {
    return Column(
      key: const ValueKey('DefaultSuggestions'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gợi ý cho bạn",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        _buildSongGrid(_allSongs, audioProvider),
      ],
    );
  }

  // Khung UI 2: Kết quả tìm kiếm (Sẽ xuất hiện bằng hiệu ứng đẩy từ trên xuống)
  Widget _buildSearchResults(AudioProvider audioProvider) {
    return Column(
      key: const ValueKey('SearchResults'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kết quả tìm thấy",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${_foundSongs.length} bài hát",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _foundSongs.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    "Không tìm thấy bài hát nào phù hợp",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            : _buildSongGrid(_foundSongs, audioProvider),
      ],
    );
  }

  // Widget dùng chung để dựng lưới GridView danh sách bài hát công thức chuẩn
  Widget _buildSongGrid(
    List<Map<String, String>> songs,
    AudioProvider audioProvider,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 25,
        childAspectRatio: 0.58,
      ),
      itemBuilder: (context, index) {
        final song = songs[index];
        return GestureDetector(
          onTap: () => audioProvider.playSong(song),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  song["image"]!.startsWith('/')
                      ? song["image"]!.substring(1)
                      : song["image"]!,
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 230,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                song["title"]!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                song["artist"]!,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
