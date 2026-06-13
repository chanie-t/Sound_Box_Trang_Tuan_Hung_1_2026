import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Map<String, String>? _currentSong;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  // ================= FAVORITE SYSTEM =================
  // Kho lưu trữ danh sách các bài hát được người dùng thả tim
  final List<Map<String, String>> _favoriteSongs = [];

  // Getters công khai để các màn hình UI lắng nghe thông tin
  Map<String, String>? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  List<Map<String, String>> get favoriteSongs => _favoriteSongs;

  // Trả về đối tượng Duration gốc để màn hình Playing tính toán chính xác bằng mili-giây
  Duration get position => _position;
  Duration get duration => _duration;

  // Giữ lại các getter cũ cho Mini Player ngoài trang chủ
  double get sliderValue => _duration.inSeconds > 0
      ? (_position.inSeconds / _duration.inSeconds) * 100
      : 0.0;

  String get positionText => _formatDuration(_position);
  String get durationText => _formatDuration(_duration);

  AudioProvider() {
    // Lắng nghe sự thay đổi trạng thái phát nhạc từ hệ thống
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    // Lắng nghe tiến trình thời gian bài hát đang chạy
    _audioPlayer.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    // Lắng nghe tổng thời lượng của bài hát được tải
    _audioPlayer.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  // ================= FAVORITE METHODS =================

  // Hàm kiểm tra bài hát bất kỳ đã có trong danh sách yêu thích chưa (để đổi màu icon trái tim)
  bool isFavorite(String songId) {
    return _favoriteSongs.any((song) => song["id"] == songId);
  }

  // Hàm Thêm hoặc Xóa bài hát khỏi danh sách yêu thích
  void toggleFavorite(Map<String, String> song) {
    if (song["id"] == null) return;

    final isExist = _favoriteSongs.any((item) => item["id"] == song["id"]);
    if (isExist) {
      _favoriteSongs.removeWhere((item) => item["id"] == song["id"]);
    } else {
      _favoriteSongs.add(song);
    }
    notifyListeners(); // Báo cho các màn hình (Search, Profile, Playing) vẽ lại giao diện tức thì
  }

  // ================= AUDIO PLAYER METHODS =================

  // Hàm chọn và phát một bài hát (Tự động nhận diện Online URL hoặc Offline File Path)
  Future<void> playSong(Map<String, String> song) async {
    try {
      _currentSong = song;
      notifyListeners();

      String audioUrl = song["audioUrl"] ?? "";

      // Kiểm tra xem nhạc được gắn link dạng nào để chọn cách phát tương ứng:
      if (audioUrl.startsWith('assets/')) {
        await _audioPlayer.setAsset(audioUrl); // 1. Nạp file nhạc có sẵn trong source code
      } else if (audioUrl.startsWith('/') ||
          audioUrl.contains('content://') ||
          File(audioUrl).existsSync()) {
        await _audioPlayer.setFilePath(audioUrl); // Nạp file cục bộ từ máy
      } else {
        // Nếu không phải file máy, mặc định sử dụng link mạng (Nếu chuỗi rỗng thì lấy link test dự phòng)
        String finalUrl = audioUrl.isNotEmpty
            ? audioUrl
            : "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
        await _audioPlayer.setUrl(finalUrl); // Nạp link URL mạng
      }

      _audioPlayer.play();
    } catch (e) {
      debugPrint("Lỗi phát nhạc: $e");
    }
  }

  // Hàm tiện ích: Mở trình chọn tệp trên thiết bị, lấy file và nạp thẳng vào hàm playSong phía trên
  Future<void> pickAndPlayLocalFile() async {
    try {
      // Mở thư mục máy chọn file audio
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result == null || result.files.single.path == null) return;

      String filePath = result.files.single.path!;
      String fileName = result.files.single.name;

      // Đóng gói thông tin tệp vừa chọn thành cấu trúc Map chuẩn dữ liệu của bạn
      Map<String, String> localSong = {
        "id": "local_${DateTime.now().millisecondsSinceEpoch}",
        "title": fileName.replaceAll('.mp3', ''),
        "artist": "Thiết bị của tôi",
        "image":
            "assets/images/default_disk.png", // Đường dẫn asset ảnh đĩa nhạc mặc định của bạn
        "audioUrl": filePath, // Lưu đường dẫn bộ nhớ máy vào đây
      };

      // Gọi lại chính hàm phát nhạc đã được tối ưu nhận diện ở trên
      await playSong(localSong);
    } catch (e) {
      debugPrint("Lỗi khi chọn file từ máy: $e");
    }
  }

  // Hàm Bật / Tắt nhạc nhanh
  void togglePlay() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  // HÀM TUA: Nhận trực tiếp Duration vị trí mới (cho độ chính xác cao nhất)
  void seek(Duration newPosition) async {
    try {
      await _audioPlayer.seek(newPosition);
    } catch (e) {
      debugPrint("Lỗi khi tua nhạc: $e");
    }
  }

  // Định dạng thời gian Duration sang chuỗi MM:SS hiển thị lên màn hình
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
