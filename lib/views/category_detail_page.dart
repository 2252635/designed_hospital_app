import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redesign_version/router/router.dart';

class CategoryDetailPage extends StatefulWidget {
  final String title;

  const CategoryDetailPage({super.key, required this.title});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  Widget buildCard(String title, String description, String imagePath) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 172,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: SizedBox(
                  height: 172,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'Microsoft JhengHei UI',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 20 / 14,
                              letterSpacing: 0,
                              color: Color(0xFF404446),
                            ),
                          ),
                          const SizedBox(height: 14.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              description,
                              style: const TextStyle(
                                fontFamily: 'Abril Fatface',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                height: 16.0 / 12.0,
                                letterSpacing: 0.0,
                                color: Color(0xFF404446),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                           onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.detailView, 
                              arguments: {
                                'appBarTitle': widget.title,      
                                'cardTitle': title,               
                                'description': description,    
                                'imagePath': imagePath            
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF0A94FF),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 10.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            '浏览',
                            style: TextStyle(
                              fontFamily: 'Microsoft JhengHei UI',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              height: 1.0,
                              letterSpacing: 0.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'FZYaoTi',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            height: 1,
            letterSpacing: 0,
            color: Color(0xFF404446),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/return.svg',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '搜索',
                  hintStyle: TextStyle(
                    fontFamily: 'FZYaoTi',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1,
                    letterSpacing: 0,
                    color: Color(0xFF979C9E),
                  ),
                  suffixIcon: Icon(Icons.search, color: Color(0xFF979C9E)),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: 3, 
                itemBuilder: (context, index) {
                  return buildCard(
                    // '标题 ${index + 1}', 
                    '标题',
                    // '这是描述信息 ${index + 1}',
                    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                    'assets/images/detail.png', 
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}