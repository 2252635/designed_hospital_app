import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:redesign_version/router/router.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];

  int? _age;
  bool _hasSelectedAge = false;
  bool _hasSelectedDeptOption = false;
  bool _useAI = false;
  String? _selectedPart;  // 存储用户选择的部位

  Future<void> _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isEmpty || !_useAI || _age == null || _selectedPart == null) return;

  


    setState(() {
      _messages.add({"role": "user", "text": userMessage});
    });

    _controller.clear();

    Map<String, dynamic> requestData = {
      "part": _selectedPart, // 这里使用用户选择的部位
      "prompt": userMessage,
      "age":  _age,
      "history": _messages.map((msg) => [msg["role"], msg["text"]]).toList(),
      "max_length": 2048,
      "top_p": 0.7,
      "temperature": 0.95
    };

    try {
      var response = await http.post(
        Uri.parse("http://101.37.170.240:8000/chat"),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String botMessage = data["response"];

        setState(() {
          _messages.add({"role": "bot", "text": botMessage});
        });
      } else {
        setState(() {
          _messages.add({"role": "bot", "text": "❌ API 发生错误"});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "bot", "text": "❌ 无法连接服务器"});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _messages.add({
      "role": "bot",
      "text": "您好，我是您的口腔健康管理师小白，很高兴为您服务！请问您的年龄是？"
    });
  }

  Widget _buildInitialInteraction() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!_hasSelectedAge) ...[
            _buildStyledButton("已满18岁", () {
              setState(() {
                _age = 19;
                _hasSelectedAge = true;
                _messages.add({"role": "user", "text": "已满18岁"});
                _messages.add({"role": "bot", "text": "请问您是否清楚就诊科室？"});
              });
            }),
            _buildStyledButton("未满18岁", () {
              setState(() {
                _age = 17;
                _hasSelectedAge = true;
                _messages.add({"role": "user", "text": "未满18岁"});
                _messages.add({"role": "bot", "text": "请问您是否清楚就诊科室？"});
              });
            }),
          ] else if (!_hasSelectedDeptOption) ...[
            _buildStyledButton("我已有明确就诊科室，点此去挂号", () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = false;
                _messages.add({"role": "user", "text": "我已有明确就诊科室，点此去挂号"});
                _messages.add({"role": "bot", "text": "请前往挂号页面。"});
              });
            }),
            _buildStyledButton("我不清楚就诊科室，快速获取", () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = false;
                _messages.add({"role": "user", "text": "我不清楚就诊科室，快速获取"});
                Navigator.pushNamed(context, AppRouter.quickGetDept);
              });
            }),
            _buildStyledButton("我不清楚就诊科室，AI交流", () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = true;
                _messages.add({"role": "user", "text": "我不清楚就诊科室，AI交流"});
                _messages.add({"role": "bot", "text": "请选择您感到不适的部位。"});
              });
            }),
          ] else if (_useAI && _selectedPart == null) ...[
            if(_age!>=18)...[
             _buildAIButtons(),
            ]
            else ...[
              _buildStyledButton("牙齿", () {
                setState(() {
                  _selectedPart = "牙齿";
                  _messages.add({"role": "user", "text": "牙齿"});
                  _messages.add({"role": "bot", "text": "请描述您的症状，我会为您推荐科室。"});
                  _sendMessage();
                });
              }),
              _buildStyledButton("更多其他症状请于儿童口腔就诊", () {
                setState(() {
                  _messages.add({"role": "user", "text": "更多其他症状请于儿童口腔就诊"});
                  _messages.add({"role": "bot", "text": "请前往儿童口腔科就诊。"});
                });
              }),
            ]
          ]
        ],
      ),
    );
  }

Widget _buildAIButtons() {
  List<String> parts = [
    "牙齿", "智齿", "牙龈", "牙根", "口腔黏膜", "嘴唇", "舌头", "腮腺", "颞下颌关节", "颌面部","整体口腔"
  ];

  return Container(
    height: 200,  
    padding: EdgeInsets.symmetric(vertical: 6), 
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: parts.map((part) {
          return _buildStyledButton(part, () {
            setState(() {
              _selectedPart = part;
              _messages.add({"role": "user", "text": part});
              _messages.add({"role": "bot", "text": "请描述您的症状，我会为您推荐科室。"});
              _sendMessage();
            });
          });
        }).toList(),
      ),
    ),
  );
}

  Widget _buildStyledButton(String text, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '智能分诊系统',
          style: TextStyle(
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
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message["role"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: message["role"] == "user" ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message["text"] ?? "",
                        style: TextStyle(
                          color: message["role"] == "user" ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (!_hasSelectedDeptOption || !_hasSelectedAge||_selectedPart==null)
            SafeArea(
              child: _buildInitialInteraction(),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: "输入消息..."),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
