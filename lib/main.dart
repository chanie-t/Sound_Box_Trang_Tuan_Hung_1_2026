import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Thêm gói Firebase Core
import 'firebase_options.dart'; // 2. Thêm file cấu hình tự động tạo bởi FlutterFire CLI

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart'; 
import 'widgets/sound_box_header.dart';
import 'screens/login_screen.dart';

// 3. Chuyển hàm main() thành async để đợi Firebase khởi tạo xong
void main() async {
  // Đảm bảo các dịch vụ nền tảng (engine) của Flutter được thiết lập đầy đủ trước
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo ứng dụng Firebase dựa trên cấu hình tự động của thiết bị hiện tại (Android/iOS)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SoundBoxApp());
}

class SoundBoxApp extends StatelessWidget {
  const SoundBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Box',
      theme: ThemeData.light(),
      home: const LoginScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(), 
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // HOME
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 35,
                    color: currentIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // SEARCH
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 35,
                    color: currentIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // MY MUSIC (PROFILE)
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "My Music",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == 2 ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Main của Trang Home:

/*import 'package:flutter/material.dart';
import '/giuaki/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '23010569-BUI THANH TUAN',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: const HomeScreen(),
    );
  }
}*/

/*
//Main trang about 
import 'package:flutter/material.dart';
// 1. Import file About.dart (đảm bảo file này nằm cùng thư mục lib với main.dart)
import '/giuaki/screens/About.dart'; 

void main() {
  runApp(const WorldPeasApp());
}

class WorldPeasApp extends StatelessWidget {
  const WorldPeasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Peas',
      // Tắt biểu ngữ Debug cho đẹp giống bản thiết kế
      debugShowCheckedModeBanner: false, 
      
      theme: ThemeData(
        useMaterial3: true,
        // Sử dụng màu xanh lá đặc trưng từ code của bạn
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43642D)),
        // Bạn có thể định nghĩa Font chữ mặc định ở đây nếu đã cài đặt font Serif
        fontFamily: 'Serif', 
      ),
      
      // 2. Gọi class LandingPage từ file About.dart làm màn hình khởi đầu
      home: const LandingPage(), 
    );
  }
}
*/
