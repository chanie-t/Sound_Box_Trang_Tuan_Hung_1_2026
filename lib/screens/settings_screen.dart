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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã đăng xuất thành công')),
    );

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
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && mounted) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _displayName = data['displayName'] ?? data['username'] ?? 'Người dùng';
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
                      'https://i.pravatar.cc/150?img=11', 
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
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          ).then((_) => _loadUsername()); // Tải lại username khi quay lại
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
    required List<String> items
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
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
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