import 'Songclass.dart';

/// File: Listtenclass.dart
/// Mô tả: Quản lý danh sách đối tượng Song và thực hiện các thao tác CRUD
class Listtenclass {
  // 1. Biến danh sách chứa các đối tượng Song (Tenclass)
  List<Song> _database = [];

  // 2. [READ] - Đọc tất cả các bản ghi
  // Trả về danh sách hiện tại để hiển thị lên UI
  List<Song> getAllSongs() {
    return _database;
  }

  // 3. [CREATE] - Tạo mới một bản ghi và lưu vào danh sách
  void createSong(Song newSong) {
    _database.add(newSong);
    print("✅ Đã thêm bài hát mới: ${newSong.title}");
  }

  // 4. [UPDATE] - Sửa bản ghi theo ID cụ thể
  void updateSong(String id, {String? newTitle, String? newArtist}) {
    try {
      // Tìm bài hát có ID khớp với tham số truyền vào
      var song = _database.firstWhere((s) => s.id == id);
      
      if (newTitle != null) song.title = newTitle;
      if (newArtist != null) song.artist = newArtist;
      
      print("Đã cập nhật thông tin bài hát ID: $id");
    } catch (e) {
      print("Không tìm thấy bài hát có ID: $id để cập nhật.");
    }
  }

  // 5. [DELETE] - Xóa bản ghi (Bổ sung để hoàn thiện CRUD)
  void deleteSong(String id) {
    _database.removeWhere((s) => s.id == id);
    print("🗑️ Đã xóa bài hát có ID: $id");
  }

  // Phương thức hỗ trợ: In toàn bộ danh sách ra Console để kiểm tra
  void printAll() {
    print("\n--- 🎵 DANH SÁCH SOUND BOX HIỆN TẠI 🎵 ---");
    if (_database.isEmpty) {
      print("Danh sách trống.");
    } else {
      for (var s in _database) {
        print(s.toString());
      }
    }
    print("------------------------------------------\n");
  }
}