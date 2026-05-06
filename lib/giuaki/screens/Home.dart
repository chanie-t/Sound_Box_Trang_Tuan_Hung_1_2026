import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LOGO
                  Image.asset(
                    'assets/images/logo.png',
                    height: 45, // Bạn có thể điều chỉnh chiều cao cho phù hợp
                    fit: BoxFit.contain,
                  ),

                  // MENU
                  Row(
                    children: [
                      navItem("Products", true),
                      navItem("Solutions", false),
                      navItem("Community", false),
                      navItem("Resources", false),
                      navItem("Pricing", false),
                      navItem("Contact", false),
                    ],
                  ),

                  // BUTTONS
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),

                      const SizedBox(width: 16),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ================= BODY =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text("Subtitle", style: TextStyle(fontSize: 32)),

                  const SizedBox(height: 50),

                  // FORM CARD
                  Container(
                    width: 500,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildInput("Name"),
                        const SizedBox(height: 24),

                        buildInput("Surname"),
                        const SizedBox(height: 24),

                        buildInput("Email"),
                        const SizedBox(height: 24),

                        buildTextArea("Message"),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ================= FOOTER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LEFT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LOGO
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: const [
                          Icon(Icons.close, size: 35),
                          SizedBox(width: 20),
                          Icon(Icons.camera_alt_outlined, size: 35),
                          SizedBox(width: 20),
                          Icon(Icons.play_circle_fill, size: 35),
                          SizedBox(width: 20),
                          Icon(Icons.business, size: 35),
                        ],
                      ),
                    ],
                  ),

                  // COLUMN 1
                  footerColumn("Use cases", [
                    "UI design",
                    "UX design",
                    "Wireframing",
                    "Diagramming",
                    "Brainstorming",
                    "Online whiteboard",
                    "Team collaboration",
                  ]),

                  // COLUMN 2
                  footerColumn("Explore", [
                    "Design",
                    "Prototyping",
                    "Development features",
                    "Design systems",
                    "Collaboration features",
                    "Design process",
                    "FigJam",
                  ]),

                  // COLUMN 3
                  footerColumn("Resources", [
                    "Blog",
                    "Best practices",
                    "Colors",
                    "Color wheel",
                    "Support",
                    "Developers",
                    "Resource library",
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= NAV ITEM =================

  Widget navItem(String title, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title, style: const TextStyle(fontSize: 18)),
    );
  }

  // ================= INPUT =================

  Widget buildInput(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 20)),

        const SizedBox(height: 10),

        TextField(
          decoration: InputDecoration(
            hintText: "Value",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // ================= TEXTAREA =================

  Widget buildTextArea(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 20)),

        const SizedBox(height: 10),

        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Value",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // ================= FOOTER COLUMN =================

  Widget footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 24),

        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(item, style: const TextStyle(fontSize: 22)),
          ),
        ),
      ],
    );
  }
}
