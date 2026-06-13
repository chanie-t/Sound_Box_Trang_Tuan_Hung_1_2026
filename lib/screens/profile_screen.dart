import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/sound_box_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _searchQuery = ""; // Từ khóa để lọc trong danh sách yêu thích

  @override
  Widget build(BuildContext context) {
    // Lắng nghe trực tiếp từ AudioProvider để biết danh sách bài hát yêu thích thay đổi lúc nào
    final audioProvider = Provider.of<AudioProvider>(context);
    final allFavorites = audioProvider.favoriteSongs;

    // Lọc danh sách yêu thích dựa trên từ khóa người dùng nhập vào TextField
    final filteredFavorites = allFavorites.where((song) {
      final titleMatch = song["title"]!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final artistMatch = song["artist"]!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return titleMatch || artistMatch;
    }).toList();

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

              // --- Tiêu đề ---
              const Text(
                "Danh sách nhạc",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
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
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value; // Cập nhật từ khóa lọc UI
                    });
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey.shade600),
                    hintText: "Tìm bài hát hoặc tên ca sĩ yêu thích",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Danh sách hiển thị bài hát đã thích ---
              Expanded(
                child: allFavorites.isEmpty
                    ? const Center(
                        child: Text(
                          "Chưa có bài hát nào trong danh sách yêu thích",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    : filteredFavorites.isEmpty
                    ? const Center(
                        child: Text(
                          "Không tìm thấy bài hát phù hợp",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredFavorites.length,
                        itemBuilder: (context, index) {
                          final song = filteredFavorites[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: InkWell(
                              onTap: () {
                                // Bấm vào bài hát yêu thích sẽ phát ngay lập tức
                                audioProvider.playSong(song);
                              },
                              child: Row(
                                children: [
                                  // Ảnh bìa
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      song['image']!.startsWith('/')
                                          ? song['image']!.substring(1)
                                          : song['image']!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey.shade200,
                                              child: const Icon(
                                                Icons.music_note,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Thông tin chữ
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song['title']!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          song['artist']!,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Nút bỏ yêu thích nhanh ngay tại danh sách
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite_rounded,
                                      color: Color(
                                        0xFF1DB954,
                                      ), // Trái tim xanh Spotify
                                    ),
                                    onPressed: () {
                                      audioProvider.toggleFavorite(song);
                                    },
                                  ),
                                ],
                              ),
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
