import 'package:flutter/material.dart';
import '../widgets/sound_box_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> morningSongs = [
      {
        "title": "Rock This",
        "image": "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f",
      },
      {
        "title": "Feelin’ Myself",
        "image": "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f",
      },
      {
        "title": "This is Beyonce",
        "image": "https://images.unsplash.com/photo-1516280440614-37939bbacd81",
      },
      {
        "title": "Dope AF",
        "image": "https://images.unsplash.com/photo-1501386761578-eac5c94b800a",
      },
    ];

    final List<String> artists = [
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
      "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
      "https://images.unsplash.com/photo-1521119989659-a83eee488004",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SoundBoxHeader(),
              const SizedBox(height: 30),

              // ================= CATEGORIES =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 22, // Đồng bộ cỡ 22
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "See more",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryItem("Art"),
                    categoryItem("Business"),
                    categoryItem("Comedy"),
                    categoryItem("Drama"),
                    categoryItem("Music"),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // ================= GOOD MORNING =================
              const Text(
                "Good morning",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: morningSongs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2.7,
                ),
                itemBuilder: (context, index) {
                  final song = morningSongs[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                          child: Image.network(
                            song["image"]!,
                            width: 70,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              song["title"]!,
                              style: const TextStyle(
                                fontSize: 16, // Đồng bộ cỡ 16
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),

              // ================= NEW SONGS =================
              const Text(
                "New songs added",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Alternative Hip-Hop",
                            style: TextStyle(
                              fontSize: 16, // Đồng bộ cỡ 16
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Playlist • New, leftfield and for the real hip-hop stans!",
                            style: TextStyle(
                              fontSize: 14, // Đồng bộ cỡ 14
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.black,
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // ================= TOP ARTISTS =================
              const Text(
                "Recent top artists",
                style: TextStyle(
                  fontSize: 26, // Đồng bộ cỡ 26
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          artists[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Bỏ màu tím, đồng bộ đen
          ),
        ),
      ),
    );
  }
}
