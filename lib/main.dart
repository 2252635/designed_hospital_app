import 'package:flutter/material.dart';
import 'package:redesign_version/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '口腔AI数字人导诊系统',
      initialRoute: AppRouter.splash, 
      onGenerateRoute: AppRouter.generateRoute,
    );
  }

  
}
