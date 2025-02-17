import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redesign_version/router/router.dart';

class DetailViewPage extends StatefulWidget {
  final String appBarTitle;
  final String cardTitle;
  final String description;
  final String imagePath;
  final String author;
  final String time;
  final String content;

  const DetailViewPage({
    super.key,
    required this.appBarTitle,
    required this.cardTitle,
    required this.description,
    required this.imagePath,
    required this.author,
    required this.time,
    required this.content,
  });

  @override
  State<DetailViewPage> createState() => _DetailViewPageState();
}

class _DetailViewPageState extends State<DetailViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.appBarTitle,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
              'assets/images/language.svg',
              height: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.home);
              },
              child: SvgPicture.asset(
                'assets/images/home.svg',
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 16.0, 16.0, 16.0), 
            child: Text(
              widget.cardTitle,
              style: const TextStyle(
                fontFamily: 'Microsoft Himalaya',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 20 / 16, 
                letterSpacing: 0, 
                color: Color(0xFF404446), 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 8.0, 16.0, 8.0), 
            child: Text(
              widget.author,
              style: const TextStyle(
                fontFamily: 'Microsoft Himalaya',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 20 / 14, 
                letterSpacing: 0, 
                color: Color(0xFF404446), 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 0, 16.0, 16.0), 
            child: Text(
              widget.time,
              style: const TextStyle(
                fontFamily: 'Microsoft Himalaya',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 16 / 12, 
                letterSpacing: 0, 
                color: Color(0xFF878C9E), 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 16.0), 
            child: Text(
              widget.content,
              style: const TextStyle(
                fontFamily: 'Microsoft Himalaya',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 20 / 14, 
                letterSpacing: 0, 
                color: Color(0xFF404446), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
