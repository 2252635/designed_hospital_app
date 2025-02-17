import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redesign_version/router/router.dart';

class OralHealthPage extends StatefulWidget {
  const OralHealthPage({super.key});

  @override
  State<OralHealthPage> createState() => _OralHealthPageState();
}

class _OralHealthPageState extends State<OralHealthPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  const Text(
                    '科普',
                    style: TextStyle(
                      fontFamily: 'FZYaoTi',
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      letterSpacing: -1.9,
                      color: Color(0xFF054A80),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/language.svg', 
                        height: 30, 
                      ),
                      const SizedBox(width: 10), 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.home);
                        },
                        child: SvgPicture.asset(
                          'assets/images/home.svg',
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('assets/images/oral_health.png', fit: BoxFit.cover),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('assets/images/oral_health.png', fit: BoxFit.cover),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('assets/images/oral_health.png', fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // 指示器
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: _currentPage == index ? 20.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? const Color(0xFF054A80) : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                    '科普分类',
                    style: TextStyle(
                      fontFamily: 'FZYaoTi',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      letterSpacing: -1.9,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.left,
                  ),
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                 _buildCard('口腔科室科普', '213', 'assets/images/oral_health_categories1.svg'),
                _buildCard('日常口腔护理', '213', 'assets/images/oral_health_categories2.svg'),
                _buildCard('儿童口腔常见问题', '213', 'assets/images/oral_health_categories3.svg'),
                _buildCard('老年口腔常见问题', '213', 'assets/images/oral_health_categories4.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String count, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.categoryDetail, arguments: title);
      },
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              height: 65,
              width: 65,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Himalaya',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                letterSpacing: 0,
                color: Color(0xFF404446),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$count 条',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'FZYaoTi',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.3,
                letterSpacing: 0,
                color: Color(0xFF979C9E),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
