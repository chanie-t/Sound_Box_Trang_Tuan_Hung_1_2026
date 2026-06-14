import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// QUAN TRỌNG: Sửa lại đường dẫn này cho đúng với vị trí file đăng nhập của bạn
import 'login_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _displayName = "Đang tải...";

  // Hàm xử lý đăng xuất đã được cập nhật
  Future<void> _logout(BuildContext context) async {
    // 1. Gọi Firebase để đăng xuất
    await FirebaseAuth.instance.signOut();

    // 2. Hiển thị thông báo
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã đăng xuất thành công')));

    // 3. Chuyển về màn hình đăng nhập và xóa toàn bộ ngăn xếp màn hình (stack)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // false nghĩa là xóa hết các trang cũ
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && mounted) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _displayName =
              data['displayName'] ?? data['username'] ?? 'Người dùng';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.grey[100]!;
    const Color cardColor = Colors.white;
    const Color textColor = Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cài đặt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- Phần Profile ---
            Container(
              color: cardColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAnAMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAAAQQFAgMGB//EAC4QAQACAQIFAwMCBwEAAAAAAAABAgMEEQUSITFREyJBMmFxUoIzYnKBkaGxJP/EABcBAQEBAQAAAAAAAAAAAAAAAAABAgP/xAAWEQEBAQAAAAAAAAAAAAAAAAAAARH/2gAMAwEAAhEDEQA/AP0wB0QAAAAEx1mIiN5amj0UUiL5Y3v4n4S3BQxabNl+ik7eZ6QtU4Zbb35Ij8Q0/wADOqzp4XHxln/CrqdJkwdbda+Ybbm9YvSa27SaPn5gX8nDLx/DvFvtPRRtWazMWjaY7xLUqOQFAAAAAAAAAEgu8Lw+pknJb6advy1Vbh9Ippa7d7dZWWKoAgAAKXEtPF8XqVj3U6z94XUZI5qWjzGwPnkOu26G4iAFAAAAAAAEg3tP0wY/6Yejz0076fHMfph6OagAAAB8BPSJB89b6rfmUJmes/lDcRACgAAAAAA7w09TJWm+3NO27l66aeXUY5/mgo2sNPSxVxxO/L8u0oc1AAAAEWjesx5hIDC1OH0Ms033jbeJeS3xSf8A1fthTbiACgAAAAAAmN46x3QA3dNnrmxRMTHN8x4ezH4bfl1MR+qNmwxVAEAABzkvXHSbXmIiHTM4tf30x/3mCCnmyerlvk8y80odEAAAAAAAAAAdUvNLVtXvWd4buDLXNji9fn/TBXOG2tGo5Kz7ZjrDNg1gGVAAJmIiZmdojuwdTl9bPa/xPb8NDi1rRhpET0m3X7syeyxHIDYAAAAAAAAAAlc4VG+qmfFZU9mpwrDNMdslo25u2/hKLwDCgAKXFY308T4sypnq3dVi9bBakd57MOazE7TG0x3ag5EoaQAAAAAAEusdLZLctazM/YHDvFivlnbHWZlf0/DY35s1v2wv0pWkbUjaPszaqnpuHxSebLPNPxEdl2I2SMgAAAAr6nR49R7p9t/MLADDz6TNhmZtG9fMPB9H37qeo4fiydaey327S1KMge+fT5ME7Xr08x2eK6iAFBMQNHh+kjaM2SN9/pif+paPPS6C2Ta2XetfHzLSxYqYo5cdYiHYxqgAAAAAAAAAAAItETG1o3jwpajh9be7DPLP6Z7LwD569bUtNb1msx8S5bes01dRTxeO0sa1LVtNZjrHduVE4oi2SkT2mYfQViIrER0iIBmgAigAAAAAAAAAAAAAHwyuI0rGpnaNt4iZBYP/2Q==',
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          ).then(
                            (_) => _loadUsername(),
                          ); // Tải lại username khi quay lại
                        },
                        child: const Text(
                          'View profile',
                          style: TextStyle(
                            color: Color(0xFF4C3EE8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- Các Nhóm Cài đặt ---
            _buildSettingGroup(
              cardColor: cardColor,
              textColor: textColor,
              items: ['Thông báo', 'Dữ liệu và bộ nhớ'],
            ),
            const SizedBox(height: 15),
            _buildSettingGroup(
              cardColor: cardColor,
              textColor: textColor,
              items: ['Gói đăng ký', 'Tài khoản liên kết'],
            ),
            const SizedBox(height: 15),
            _buildSettingGroup(
              cardColor: cardColor,
              textColor: textColor,
              items: ['Giới thiệu về Sound Box'],
            ),

            const SizedBox(height: 40),

            // --- Nút Đăng xuất ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFFF5E3A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _logout(context), // Gọi hàm _logout ở đây
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Color(0xFFFF5E3A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingGroup({
    required Color cardColor,
    required Color textColor,
    required List<String> items,
  }) {
    return Container(
      color: cardColor,
      child: Column(
        children: items.map((title) {
          int index = items.indexOf(title);
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              if (index < items.length - 1)
                Divider(
                  color: Colors.grey[200],
                  height: 1,
                  thickness: 1,
                  indent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
