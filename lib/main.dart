/*import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart'; // Đã import màn hình Search của bạn
import 'widgets/sound_box_header.dart';

void main() {
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
      home: const MainScreen(),
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

  // ================= ĐÃ SỬA MẢNG NÀY =================
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(), // <-- Đã bỏ dòng Text tạm thời và gọi SearchScreen()
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

import 'package:flutter/material.dart';
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
}
*/
