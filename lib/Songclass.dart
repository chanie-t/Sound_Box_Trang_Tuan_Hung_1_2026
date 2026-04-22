/// File: Song.dart
/// Mô tả: Đối tượng mô tả một bài hát cụ thể trong ứng dụng Sound Box

class Song {
  // --- Các biến thành phần (Properties) ---
  final String id;
  String title;
  String artist;
  String imageUrl;
  String audioUrl;
  bool isFavorite;

  // Constructor
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.audioUrl,
    this.isFavorite = false,
  });

  // --- Các phương thức hoạt động (Methods) ---

  // 1. Phương thức hiển thị thông tin rút gọn (hữu ích cho console debug)
  void displayInfo() {
    print("Đang xử lý bài hát: $title - $artist (ID: $id)");
  }

  // 2. Phương thức xử lý trạng thái yêu thích
  void toggleFavorite() {
    isFavorite = !isFavorite;
    print("Đã ${isFavorite ? 'thêm vào' : 'xóa khỏi'} danh sách yêu thích.");
  }

  // 3. Phương thức mô phỏng hành động phát nhạc
  void play() {
    print("🎶 Đang phát nhạc từ nguồn: $audioUrl");
  }

  // 4. Phương thức chuyển đổi sang chuỗi (Yêu cầu chung của bài tập)
  @override
  String toString() {
    return '{ID: $id, Tên bài: $title, Ca sĩ: $artist}';
  }
}