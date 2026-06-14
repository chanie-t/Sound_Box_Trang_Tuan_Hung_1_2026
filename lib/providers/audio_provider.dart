import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Danh sách bài hát hiện tại (Playlist) đang phát và danh sách gốc phục vụ tắt Shuffle
  List<Map<String, String>> _currentPlaylist = [];
  List<Map<String, String>> _originalPlaylist = [];

  Map<String, String>? _currentSong;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  // Trạng thái các nút điều khiển nâng cao
  bool _isShuffle = false;
  bool _isRepeat = false;

  // Hệ thống lưu trữ danh sách thả tim
  final List<Map<String, String>> _favoriteSongs = [];

  // ================= GETTERS =================
  Map<String, String>? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  List<Map<String, String>> get favoriteSongs => _favoriteSongs;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isShuffle => _isShuffle;
  bool get isRepeat => _isRepeat;

  double get sliderValue => _duration.inSeconds > 0
      ? (_position.inSeconds / _duration.inSeconds) * 100
      : 0.0;

  String get positionText => _formatDuration(_position);
  String get durationText => _formatDuration(_duration);

  AudioProvider() {
    // Theo dõi trạng thái phát của Player
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;

      // Tự động xử lý khi hết một bài hát
      if (state.processingState == ProcessingState.completed) {
        if (_isRepeat) {
          seek(Duration.zero);
          _audioPlayer.play();
        } else {
          nextSong();
        }
      }
      notifyListeners();
    });

    // Cập nhật tiến trình chạy bài hát theo thời gian thực
    _audioPlayer.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    // Cập nhật tổng thời lượng bài hát
    _audioPlayer.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  // ================= PLAYLIST CONTROLS =================
  void setPlaylist(List<Map<String, String>> playlist) {
    _originalPlaylist = List.from(playlist);
    if (_isShuffle) {
      _currentPlaylist = List.from(playlist)..shuffle();
    } else {
      _currentPlaylist = List.from(playlist);
    }
  }

  // Bật/Tắt chế độ trộn bài
  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    if (_isShuffle) {
      if (_currentPlaylist.isNotEmpty) {
        _currentPlaylist.shuffle(Random());
        if (_currentSong != null) {
          _currentPlaylist.removeWhere(
            (song) => song["id"] == _currentSong!["id"],
          );
          _currentPlaylist.insert(0, _currentSong!);
        }
      }
    } else {
      _currentPlaylist = List.from(_originalPlaylist);
    }
    notifyListeners();
  }

  // Bật/Tắt chế độ lặp bài hiện tại
  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  // ================= NEXT & PREVIOUS LOGIC =================
  void nextSong() {
    if (_currentPlaylist.isEmpty) return;

    int currentIndex = _currentPlaylist.indexWhere(
      (song) => song["id"] == _currentSong?["id"],
    );

    if (currentIndex != -1 && currentIndex < _currentPlaylist.length - 1) {
      playSongInternal(_currentPlaylist[currentIndex + 1]);
    } else {
      playSongInternal(_currentPlaylist.first);
    }
  }

  void previousSong() {
    if (_currentPlaylist.isEmpty) return;

    // Nếu bài nhạc đã trôi qua hơn 3 giây, tua lại từ đầu bài thay vì lùi bài mới
    if (_position.inSeconds > 3) {
      seek(Duration.zero);
      return;
    }

    int currentIndex = _currentPlaylist.indexWhere(
      (song) => song["id"] == _currentSong?["id"],
    );

    if (currentIndex > 0) {
      playSongInternal(_currentPlaylist[currentIndex - 1]);
    } else {
      playSongInternal(_currentPlaylist.last);
    }
  }

  // ================= FAVORITE LOGIC =================
  bool isFavorite(String songId) {
    return _favoriteSongs.any((song) => song["id"] == songId);
  }

  void toggleFavorite(Map<String, String> song) {
    if (song["id"] == null) return;

    final isExist = _favoriteSongs.any((item) => item["id"] == song["id"]);
    if (isExist) {
      _favoriteSongs.removeWhere((item) => item["id"] == song["id"]);
    } else {
      _favoriteSongs.add(song);
    }
    notifyListeners();
  }

  // ================= AUDIO LOADER =================
  Future<void> playSong(
    Map<String, String> song, {
    List<Map<String, String>>? playlist,
  }) async {
    if (playlist != null) {
      setPlaylist(playlist);
    } else if (_currentPlaylist.isEmpty ||
        !_currentPlaylist.any((item) => item["id"] == song["id"])) {
      setPlaylist([song]);
    }
    await playSongInternal(song);
  }

  Future<void> playSongInternal(Map<String, String> song) async {
    try {
      _currentSong = song;
      _position = Duration.zero;
      notifyListeners();

      String audioUrl = song["audioUrl"] ?? "";

      if (audioUrl.startsWith('assets/')) {
        await _audioPlayer.setAsset(audioUrl);
      } else if (audioUrl.startsWith('/') ||
          audioUrl.contains('content://') ||
          File(audioUrl).existsSync()) {
        await _audioPlayer.setFilePath(audioUrl);
      } else {
        String finalUrl = audioUrl.isNotEmpty
            ? audioUrl
            : "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
        await _audioPlayer.setUrl(finalUrl);
      }

      _audioPlayer.play();
    } catch (e) {
      debugPrint("Lỗi phát nhạc: $e");
    }
  }

  Future<void> pickAndPlayLocalFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result == null || result.files.single.path == null) return;

      String filePath = result.files.single.path!;
      String fileName = result.files.single.name;

      Map<String, String> localSong = {
        "id": "local_${DateTime.now().millisecondsSinceEpoch}",
        "title": fileName.replaceAll('.mp3', ''),
        "artist": "Thiết bị của tôi",
        "image": "assets/images/default_disk.png",
        "audioUrl": filePath,
      };

      await playSong(localSong);
    } catch (e) {
      debugPrint("Lỗi khi chọn file từ máy: $e");
    }
  }

  void togglePlay() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seek(Duration newPosition) async {
    try {
      await _audioPlayer.seek(newPosition);
    } catch (e) {
      debugPrint("Lỗi khi tua nhạc: $e");
    }
  }

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
