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
  // 1. Kho lưu trữ danh sách gốc tất cả các bài hát (Dữ liệu mẫu của bạn)
  final List<Map<String, String>> _allSongs = [
    {
      "id": "song_1",
      "title": "Nơi này có anh",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Nơi này có anh.jpg",
      // 👉 GẮN LINK MẠNG HOẶC ĐƯỜNG DẪN ASSETS TẠI ĐÂY:
      "audioUrl": "assets/sound/NoiNayCoAnh_SonTungMTP.mp3",
    },
    {
      "id": "song_2",
      "title": "Lạc Trôi",
      "artist": "Sơn Tùng M-TP",
      "image": "assets/images/Lạc trôi.jpg",
      "audioUrl": "assets/sound/Lạc Trôi.mp3", // (Ví dụ dùng nhạc lưu sẵn trong thư mục code)
    },
    {
      "id": "song_3",
      "title": "Yêu nắm",
      "artist": "EMILY-BIGDADDY",
      "image": "assets/images/Yêu nắm_Emily_Bigdaddy.jpg",
      "audioUrl": "assets/sound/Yêu Nắm.mp3",
    },
    // BỔ SUNG CÁC BÀI HÁT TỪ TRANG CHỦ VÀO ĐÂY ĐỂ TÌM KIẾM
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
      "title": "Gặp người hay nói",
      "artist": "Unknown",
      "image": "assets/images/Người im lặng gặp người hay nói.jpg",
      "audioUrl": "assets/sound/Người Im Lặng Gặp Người Hay Nói.mp3",
    },
  ];

  // 2. Danh sách biến động hiển thị lên màn hình sau khi lọc
  List<Map<String, String>> _foundSongs = [];

  @override
  void initState() {
    super.initState();
    // Ban đầu khi chưa gõ gì, hiển thị toàn bộ bài hát
    _foundSongs = _allSongs;
  }

  // 3. Hàm xử lý logic lọc tìm kiếm (Không phân biệt chữ hoa, chữ thường)
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allSongs;
    } else {
      results = _allSongs.where((song) {
        final titleMatch = song["title"]!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        );
        final artistMatch = song["artist"]!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        );
        return titleMatch ||
            artistMatch; // Tìm theo cả Tên bài hát HOẶC Tên ca sĩ
      }).toList();
    }

    // Cập nhật lại UI hiển thị kết quả mới
    setState(() {
      _foundSongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
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
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // ================= SEARCH BOX (KẾT NỐI HÀM LỌC) =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(
                      value,
                    ), // Mỗi khi gõ chữ, gọi hàm lọc lập tức
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.black),
                      hintText: "Tìm kiếm bài hát, ca sĩ",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // ================= SEARCH RESULT TITLE =================
                const Text(
                  "Gợi ý cho bạn",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // ================= SONG GRID (DỮ LIỆU ĐỘNG) =================
                _foundSongs.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Không tìm thấy bài hát nào phù hợp",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _foundSongs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 25,
                              childAspectRatio: 0.58,
                            ),
                        itemBuilder: (context, index) {
                          final song = _foundSongs[index];

                          // Đã bọc GestureDetector để khi bấm vào bài nào, bài đó lập tức phát nhạc
                          return GestureDetector(
                            onTap: () {
                              audioProvider.playSong(song);

                              // [Tùy chọn]: Nếu muốn bấm vào bài hát rồi tự động mở màn hình PlayingScreen lên luôn
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayingScreen()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IMAGE (Đã sửa từ Image.network sang Image.asset để đọc file từ máy đúng chuẩn)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    // Xóa dấu gạch chéo ở đầu nếu có để đường dẫn assets hoạt động chuẩn
                                    song["image"]!.startsWith('/')
                                        ? song["image"]!.substring(1)
                                        : song["image"]!,
                                    height: 230,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Phòng hờ nếu thiếu file ảnh thật trong thư mục assets, app hiện khung xám thay vì crash
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

                                // TITLE
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

                                // AUTHOR
                                Text(
                                  song["artist"]!, // Đồng bộ dùng key "artist" thay cho "author" để khớp với AudioProvider
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
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
