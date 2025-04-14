import 'package:flutter/material.dart';
import 'package:redesign_version/views/splash_page.dart';
import 'package:redesign_version/views/home_page.dart';
import "package:redesign_version/views/oral_health_page.dart";
import 'package:redesign_version/views/category_detail_page.dart';
import 'package:redesign_version/views/detail_view_page.dart';
import 'package:redesign_version/views/chat_page.dart';
import 'package:redesign_version/views/quick_get_dept_page.dart';


class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String oralHealth = '/oral_health';
  static const String categoryDetail = '/category_detail';
  static const String detailView = '/detail_view';
  static const String quickGetDept = '/quick_get_dept';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case oralHealth:
        return MaterialPageRoute(builder: (_) => const OralHealthPage());
      case categoryDetail:
        final args = settings.arguments as String; 
        return MaterialPageRoute(
          builder: (_) => CategoryDetailPage(title: args),
        );
      case detailView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetailViewPage(
            appBarTitle: args['appBarTitle'],
            cardTitle: args['cardTitle'],
            description: args['description'],
            imagePath: args['imagePath'],
            author: args['author'],
            time: args['time'],
            content: args['content'],
          ),
        );
      case chat:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case quickGetDept: 
        return MaterialPageRoute(builder: (_) => QuickGetDeptPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("页面未找到")),
          ),
        );
    }
  }
}
