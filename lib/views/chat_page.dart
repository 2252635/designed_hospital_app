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

  Future<void> _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isEmpty || !_useAI || _age == null) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
    });

    _controller.clear();

    Map<String, dynamic> requestData = {
      "part": "牙齿", 
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
        // Uri.parse("http://192.168.147.122/chat"), 
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

    }
    catch (e) {
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
    if (!_hasSelectedAge) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _age = 19;
                _hasSelectedAge = true;
                _messages.add({"role": "user", "text": "已满18岁"});
                _messages.add({"role": "bot", "text": "请问您是否清楚就诊科室？"});
              });
            },
            child: Text("已满18岁"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _age = 17;
                _hasSelectedAge = true;
                _messages.add({"role": "user", "text": "未满18岁"});
                _messages.add({"role": "bot", "text": "请问您是否清楚就诊科室？"});
              });
            },
            child: Text("未满18岁"),
          ),
        ],
      );
    }

    if (!_hasSelectedDeptOption) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = false;
                _messages.add({"role": "user", "text": "我已有明确就诊科室，点此去挂号"});
                _messages.add({"role": "bot", "text": "请前往挂号页面。"});
              });
            },
            child: Text("我已有明确就诊科室，点此去挂号"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = false;
                _messages.add({"role": "user", "text": "我不清楚就诊科室，快速获取"});
                _messages.add({"role": "bot", "text": "请根据常见症状快速匹配科室。"});
              });
            },
            child: Text("我不清楚就诊科室，快速获取"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasSelectedDeptOption = true;
                _useAI = true;
                _messages.add({"role": "user", "text": "我不清楚就诊科室，AI交流"});
                _messages.add({"role": "bot", "text": "请详细描述您的症状，我会为您推荐科室。"});
              });
            },
            child: Text("我不清楚就诊科室，AI交流"),
          ),
        ],
      );
    }

    return SizedBox.shrink(); // 不显示按钮了
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        color: message["role"] == "user" ? Colors.blue : Colors.grey[300],
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
          if (!_hasSelectedDeptOption || !_hasSelectedAge)
            Padding(
              padding: const EdgeInsets.all(8.0),
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
