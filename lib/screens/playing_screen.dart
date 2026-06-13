import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  // Hàm chuyển đổi từ Duration (thời gian) sang chuỗi định dạng mm:ss (Ví dụ: 03:45)
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    // Gọi AudioProvider để lắng nghe dữ liệu và trạng thái bài hát đang phát
    final audioProvider = Provider.of<AudioProvider>(context);
    final currentSong = audioProvider.currentSong;

    // Trường hợp phòng hờ nếu không có bài hát nào được chọn mà trang này vô tình mở ra
    if (currentSong == null) {
      return const Scaffold(
        body: Center(child: Text("Không có bài hát nào đang phát")),
      );
    }

    // Lấy thời gian hiện tại và tổng thời lượng từ provider (mặc định Duration.zero nếu null)
    final position = audioProvider.position;
    final duration = audioProvider.duration;

    // Chuyển đổi sang mili-giây phục vụ việc tính toán cho Slider
    double currentMs = position.inMilliseconds.toDouble();
    double totalMs = duration.inMilliseconds.toDouble();

    // Giới hạn giá trị Slider tránh lỗi crash khi luồng stream nhạc chưa load kịp duration
    if (totalMs <= 0) totalMs = 1.0;
    currentMs = currentMs.clamp(0.0, totalMs);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ================= 1. HEADER BAR =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 32,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    children: [
                      Text(
                        "PLAYING FROM PARTY",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      size: 28,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Button Party View
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/50'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E2E2E),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "12",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Switch to party view",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ================= 2. ALBUM ART DỰA TRÊN BÀI HÁT ĐANG PHÁT =================
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: DecorationImage(
                      image: currentSong["image"]!.startsWith('assets')
                          ? AssetImage(currentSong["image"]!) as ImageProvider
                          : NetworkImage(currentSong["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // ================= 3. SONG INFO (ĐÃ SỬA NÚT YÊU THÍCH ĐỘNG) =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong["title"]!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          currentSong["artist"] ?? "Chưa rõ nghệ sĩ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Bọc InkWell/IconButton để tương tác bật tắt Yêu thích
                  IconButton(
                    onPressed: () {
                      audioProvider.toggleFavorite(currentSong);
                    },
                    icon: Icon(
                      // Nếu đã có trong danh sách thích thì hiện tim đặc, ngược lại hiện tim rỗng viền
                      audioProvider.isFavorite(currentSong["id"] ?? "")
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: audioProvider.isFavorite(currentSong["id"] ?? "")
                          ? const Color(
                              0xFF1DB954,
                            ) // Màu xanh Spotify khi đã thích
                          : Colors.grey.shade400, // Màu xám khi chưa thích
                      size: 32,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ================= 4. MUSIC PROGRESS SLIDER =================
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3.5,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 7.0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 14.0,
                  ),
                  activeTrackColor: Colors.black87,
                  inactiveTrackColor: Colors.grey.shade200,
                  thumbColor: Colors.black87,
                ),
                child: Slider(
                  min: 0.0,
                  max: totalMs,
                  value: currentMs,
                  onChanged: (value) {
                    final newPosition = Duration(milliseconds: value.toInt());
                    audioProvider.seek(newPosition);
                  },
                ),
              ),

              // Dòng hiển thị thời gian số (Ví dụ: 01:20 / 04:05)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(position),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _formatDuration(duration),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= 5. CONTROLLER BUTTONS =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shuffle,
                      size: 28,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 38,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),

                  // NÚT PLAY / PAUSE CHÍNH GIỮA MÀN HÌNH
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1C1F22),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        audioProvider.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () => audioProvider.togglePlay(),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 38,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.repeat,
                      size: 28,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
