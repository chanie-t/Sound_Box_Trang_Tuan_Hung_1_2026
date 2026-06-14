import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final currentSong = audioProvider.currentSong;

    if (currentSong == null) {
      return const Scaffold(
        body: Center(child: Text("Không có bài hát nào đang phát")),
      );
    }

    final position = audioProvider.position;
    final duration = audioProvider.duration;

    double currentMs = position.inMilliseconds.toDouble();
    double totalMs = duration.inMilliseconds.toDouble();

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

              // ================= 2. ALBUM ART =================
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

              // ================= 3. SONG INFO =================
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
                  IconButton(
                    onPressed: () => audioProvider.toggleFavorite(currentSong),
                    icon: Icon(
                      audioProvider.isFavorite(currentSong["id"] ?? "")
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: audioProvider.isFavorite(currentSong["id"] ?? "")
                          ? const Color(0xFF1DB954)
                          : Colors.grey.shade400,
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

              // Thời gian chạy nhạc hiển thị dạng số
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
                  // Nút Phát ngẫu nhiên (Shuffle)
                  IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      size: 28,
                      color: audioProvider.isShuffle
                          ? const Color(0xFF1DB954)
                          : Colors.black87,
                    ),
                    onPressed: () => audioProvider.toggleShuffle(),
                  ),

                  // Nút Lùi bài (Previous)
                  IconButton(
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 38,
                      color: Colors.black87,
                    ),
                    onPressed: () => audioProvider.previousSong(),
                  ),

                  // Nút Play / Pause trung tâm
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

                  // Nút Chuyển bài kế tiếp (Next)
                  IconButton(
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 38,
                      color: Colors.black87,
                    ),
                    onPressed: () => audioProvider.nextSong(),
                  ),

                  // Nút Lặp lại (Repeat)
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      size: 28,
                      color: audioProvider.isRepeat
                          ? const Color(0xFF1DB954)
                          : Colors.black87,
                    ),
                    onPressed: () => audioProvider.toggleRepeat(),
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
