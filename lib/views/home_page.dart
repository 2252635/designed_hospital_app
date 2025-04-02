import 'package:flutter/material.dart';
import 'package:redesign_version/router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = "智能分诊"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 216, 230), 
      body: Container(
        padding: const EdgeInsets.all(0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            const SizedBox(height: 50), 
            const Padding(
              padding: EdgeInsets.only(left: 20.0), // 添加左边距
              child: Text(
                '口腔AI数字人导诊系统',
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
            ),
            
            const Padding(
              padding: EdgeInsets.only(left: 20.0), 
              child: Text(
                '请在下方选择您的业务类型',
                style: TextStyle(
                  fontFamily: 'Himalaya', 
                  fontSize: 16, 
                  fontWeight: FontWeight.w400, 
                  height: 1.5, 
                  color: Color(0xFF054A80), 
                ),
              ),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                _buildServiceOption("智能分诊"),
                _buildServiceOption("口腔科普"),
                _buildServiceOption("院内导航"),
                _buildServiceOption("健康追踪管理"),
              ],
            ),
            
            const SizedBox(height: 30),

            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight, 
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 375,
                      height: 600, 
                      child: Image.asset(
                        'assets/images/human.png', 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20), 
                      child: ElevatedButton(
                        onPressed: () {
                         if (_selectedOption == "口腔科普") {
                            Navigator.pushNamed(context, AppRouter.oralHealth);
                          }
                          else if(_selectedOption == "智能分诊"){
                            Navigator.pushNamed(context, AppRouter.chat);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '点击此处继续',
                          style: TextStyle(
                            fontFamily: 'Himalaya',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            color: Color(0xFF0A84FF),
                          ),
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
    );
  }

  Widget _buildServiceOption(String title) {
    final bool isSelected = _selectedOption == title; 

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = title; 
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Himalaya', 
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF054A80),
            ),
          ),
          const SizedBox(height: 8), 
          Align(
            alignment: Alignment.centerLeft,  
            child: Container(
              width: 8,
              height: 8, 
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0A94FF) : Colors.white, 
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
