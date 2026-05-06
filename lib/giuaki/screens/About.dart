import 'package:flutter/material.dart';

void main() {
  runApp(const WorldPeasApp());
}

class WorldPeasApp extends StatelessWidget {
  const WorldPeasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43642D)),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- PHẦN 1: HEADER & HERO (Screenshot 2026-05-06 072131.png) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                children: [
                  const Text(
                    'World Peas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF43642D),
                      fontFamily: 'Serif',
                    ),
                  ),
                  const Spacer(),
                  _navItem('Shop'),
                  _navItem('Newstand'),
                  _navItem('Who we are'),
                  _navItem('My profile'),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43642D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Basket (3)'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 64, color: Colors.black, height: 1.1),
                      children: [
                        TextSpan(text: "We’re "),
                        TextSpan(text: "farmers, ", style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: "purveyors, ", style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: "and "),
                        TextSpan(text: "eaters ", style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: "of\norganically grown food."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43642D),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Browse our shop', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),

            // --- PHẦN 2: IMAGE SHOWCASE (Screenshot 2026-05-06 072149.jpg) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1540420773420-3366772f4999', // Ảnh minh họa lá rau
                      height: 600,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1518843875459-f738682238a6', // Ảnh minh họa củ cải/bánh mì
                          height: 450,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Central California — The person who grew these was located in Central California and, er, hopefully very well-compensated.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),

            // --- PHẦN 3: BELIEVE SECTION (Screenshot 2026-05-06 072204.png) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'WHAT WE BELIEVE',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'We believe in produce. Tasty produce. Produce like:',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Apples. Oranges. Limes. Lemons. Guavas. Carrots. Cucumbers. Jicamas. Cauliflowers. Brussels sprouts. Shallots. Japanese eggplants. Asparagus. Artichokes—Jerusalem artichokes, too. Radishes. Broccoli. Baby broccoli. Broccolini. Bok choy. Scallions. Ginger. Cherries. Raspberries. Cilantro. Parsley. Dill.',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'What are we forgetting?',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Oh! Onions. Yams. Avocados. Lettuce. Arugula (to some, “rocket”). Persian cucumbers, in addition to aforementioned “normal” cucumbers. Artichokes. Zucchinis. Pumpkins. Squash (what some cultures call pumpkins). Sweet potatoes and potato-potatoes. Jackfruit. Monk fruit. Fruit of the Loom. Fruits of our labor (this website). Sorrel. Pineapple. Mango. Gooseberries. Blackberries. Tomatoes. Heirloom tomatoes. Beets. Chives. Corn. Endive. Escarole, which, we swear, we’re vendors of organic produce, but if you asked us to describe what escaroles are...',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      ],
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

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
