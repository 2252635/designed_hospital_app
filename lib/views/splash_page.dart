import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redesign_version/router/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.light.copyWith(
    //     statusBarColor: const Color(0xFF1976D2), 
    //     systemNavigationBarColor: const Color(0xFF1976D2), 
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light, 
    //   ),
    // );
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, 
      systemNavigationBarColor: Colors.transparent, 
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark, 
    ),
  );
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.home);
    }
  }

  // @override
  // void dispose() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.transparent, 
  //     systemNavigationBarColor: Colors.white,
  //     systemNavigationBarIconBrightness: Brightness.dark, 
  //     statusBarIconBrightness: Brightness.dark, 
  //   ));
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 71,
                height: 69,
              ),
              const Text(
                "口腔AI数字人导诊系统",
                style: TextStyle(
                  fontFamily: 'FZYaoTi',
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: -1.9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}