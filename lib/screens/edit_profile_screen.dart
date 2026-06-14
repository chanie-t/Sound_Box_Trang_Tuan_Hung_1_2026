import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Hàm tải dữ liệu người dùng từ Firestore
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _displayNameController.text = data['displayName'] ?? '';
            _usernameController.text = data['username'] ?? '';
            _emailController.text = data['email'] ?? user.email ?? '';
            _dobController.text = data['dob'] ?? '';
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() => _isLoading = false);
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  // Hàm lưu dữ liệu lên Firestore
  Future<void> _updateProfile() async {
    setState(() => _isSaving = true);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'displayName': _displayNameController.text.trim(),
          'username': _usernameController.text.trim(),
          'dob': _dobController.text.trim(),
          // Không cập nhật email ở đây vì đổi email yêu cầu quy trình bảo mật riêng của Firebase Auth
        }, SetOptions(merge: true));

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật hồ sơ thành công!')),
        );
        Navigator.pop(context); // Trở về trang trước sau khi lưu xong
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra khi cập nhật.')),
        );
      }
    }
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hồ sơ của tôi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAnAMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAAAQQFAgMGB//EAC4QAQACAQIFAwMCBwEAAAAAAAABAgMEEQUSITFREyJBMmFxUoIzYnKBkaGxJP/EABcBAQEBAQAAAAAAAAAAAAAAAAABAgP/xAAWEQEBAQAAAAAAAAAAAAAAAAAAARH/2gAMAwEAAhEDEQA/AP0wB0QAAAAEx1mIiN5amj0UUiL5Y3v4n4S3BQxabNl+ik7eZ6QtU4Zbb35Ij8Q0/wADOqzp4XHxln/CrqdJkwdbda+Ybbm9YvSa27SaPn5gX8nDLx/DvFvtPRRtWazMWjaY7xLUqOQFAAAAAAAAAEgu8Lw+pknJb6advy1Vbh9Ippa7d7dZWWKoAgAAKXEtPF8XqVj3U6z94XUZI5qWjzGwPnkOu26G4iAFAAAAAAAEg3tP0wY/6Yejz0076fHMfph6OagAAAB8BPSJB89b6rfmUJmes/lDcRACgAAAAAA7w09TJWm+3NO27l66aeXUY5/mgo2sNPSxVxxO/L8u0oc1AAAAEWjesx5hIDC1OH0Ms033jbeJeS3xSf8A1fthTbiACgAAAAAAmN46x3QA3dNnrmxRMTHN8x4ezH4bfl1MR+qNmwxVAEAABzkvXHSbXmIiHTM4tf30x/3mCCnmyerlvk8y80odEAAAAAAAAAAdUvNLVtXvWd4buDLXNji9fn/TBXOG2tGo5Kz7ZjrDNg1gGVAAJmIiZmdojuwdTl9bPa/xPb8NDi1rRhpET0m3X7syeyxHIDYAAAAAAAAAAlc4VG+qmfFZU9mpwrDNMdslo25u2/hKLwDCgAKXFY308T4sypnq3dVi9bBakd57MOazE7TG0x3ag5EoaQAAAAAAEusdLZLctazM/YHDvFivlnbHWZlf0/DY35s1v2wv0pWkbUjaPszaqnpuHxSebLPNPxEdl2I2SMgAAAAr6nR49R7p9t/MLADDz6TNhmZtG9fMPB9H37qeo4fiydaey327S1KMge+fT5ME7Xr08x2eK6iAFBMQNHh+kjaM2SN9/pif+paPPS6C2Ta2XetfHzLSxYqYo5cdYiHYxqgAAAAAAAAAAAItETG1o3jwpajh9be7DPLP6Z7LwD569bUtNb1msx8S5bes01dRTxeO0sa1LVtNZjrHduVE4oi2SkT2mYfQViIrER0iIBmgAigAAAAAAAAAAAAAHwyuI0rGpnaNt4iZBYP/2Q==',
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Tên hiển thị', _displayNameController),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Tên người dùng (Username)',
                    _usernameController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Email',
                    _emailController,
                    readOnly: true,
                  ), // Chỉ đọc
                  const SizedBox(height: 16),
                  _buildTextField('Ngày sinh (dd/mm/yyyy)', _dobController),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C3EE8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isSaving ? null : _updateProfile,
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Lưu thay đổi',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(color: readOnly ? Colors.grey[600] : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: readOnly ? Colors.grey[200] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
