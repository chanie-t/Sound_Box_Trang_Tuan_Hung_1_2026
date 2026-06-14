# 🎵 SoundBox - Ứng dụng nghe nhạc thông minh

SoundBox là ứng dụng phát nhạc được xây dựng bằng Flutter, cung cấp giao diện hiện đại và thân thiện với người dùng. Ứng dụng hỗ trợ phát nhạc, tìm kiếm bài hát, quản lý danh sách yêu thích và quản lý tài khoản cá nhân.
---

# Đội ngũ phát triển (Đại học Phenikaa)
* **Trang Nguyen Thuy**  (MSSV: 23010487) 
* **Bui Thanh Tuan**     (MSSV: 23010569)
* **Nguyen Do Phi Hung** (MSSV: 23010606)

## ✨ Chức năng chính
* Đăng ký tài khoản và đăng nhập bằng Firebase Authentication.
* Phát nhạc trực tuyến.
* Tìm kiếm bài hát theo tên bài hát hoặc ca sĩ.
* Thêm và xóa bài hát khỏi danh sách yêu thích.
* Điều khiển phát nhạc (Phát/Tạm dừng, Bài tiếp theo, Bài trước).
* Hỗ trợ chế độ phát ngẫu nhiên và lặp lại.
* Quản lý thông tin cá nhân.
* Chỉnh sửa hồ sơ người dùng.
* Đăng xuất khỏi hệ thống.

## Công nghệ sử dụng
* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Provider State Management
* Just Audio
* Material Design


## 📂 Cấu trúc thư mục
lib/
│
├── providers/
│      audio_provider.dart
│
├── screens/
│      login_screen.dart
│      register_screen.dart
│      home_screen.dart
│      search_screen.dart
│      playing_screen.dart
│      profile_screen.dart
│      edit_profile_screen.dart
│      settings_screen.dart
│
├── widgets/
│
├── Songclass.dart
├── Listenclass.dart
├── firebase_options.dart
└── main.dart

## 🔥 Cơ sở dữ liệu
Ứng dụng sử dụng:
* Firebase Authentication để xác thực tài khoản người dùng.
* Cloud Firestore để lưu trữ thông tin người dùng.


## UI/UX
https://www.figma.com/design/TFAEh7uTfj4vnbiXpBWHhL/Sound-box?node-id=0-1&t=g7YQnvEy5MWAdeXV-1


## Phân chia công việc giữa kỳ
Dựa trên Framework bài tập của nhóm, mỗi sinh viên trong nhóm xây dựng các trang theo định dạng như sau:

BÙI THANH TUÂN-23010569:
Trang Home
https://www.figma.com/proto/oZ6y2zCSyLZJXvDxA359LG/FREE-Mobile-App-Mockups--Community-?node-id=202-2948&t=NkwlUcw32mPBr6YM-1

NGUYỄN ĐÕ PHI HÙNG-23010606:
Trang Content
https://www.figma.com/proto/fbjspFedt90T1p34Ty2xPI/Figma-basics?node-id=4368-321123 (Links to an external site.)

NGUYỄN THÙY TRANG-23010487
Trang About
https://www.figma.com/proto/fbjspFedt90T1p34Ty2xPI/Figma-basics?node-id=4368-321106
