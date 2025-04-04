import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = []; // 存储聊天记录

  Future<void> _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
    });

    _controller.clear();

    Map<String, dynamic> requestData = {
      "part": "牙齿", // 你可以根据需求修改
      "prompt": userMessage,
      "age": 25, // 你可以改成动态值
      "history": _messages.map((msg) => [msg["role"], msg["text"]]).toList(),
      "max_length": 2048,
      "top_p": 0.7,
      "temperature": 0.95
    };

    try {
      // var response = await http.post(
      //   Uri.parse("http://127.0.0.1:8000/chat"),
      //   headers: {"Content-Type": "application/json"},
      //   body: jsonEncode(requestData),
      // );

      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/chat"), 
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

    //   if (response.statusCode == 200) {
    //         // 确保在解析响应时指定UTF-8编码
    //         var data = utf8.decode(response.bodyBytes); // 使用 utf8 解码响应内容
    //         var jsonData = jsonDecode(data); // 解析 JSON

    //         String botMessage = jsonData["response"] ?? "❌ 无效的响应";

    //         setState(() {
    //           _messages.add({"role": "bot", "text": botMessage});
    //         });
    //       } else {
    //         setState(() {
    //           _messages.add({"role": "bot", "text": "❌ API 发生错误"});
    //         });
    //   }
      
    // }
    }
    catch (e) {
        setState(() {
          _messages.add({"role": "bot", "text": "❌ 无法连接服务器"});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatGLM3 交流")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                      decoration: BoxDecoration(
                        color: message["role"] == "user" ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message["text"] ?? "",
                        style: TextStyle(
                          color: message["role"] == "user" ? Colors.white : Colors.black,
                          fontFamily: "Himalaya" 
                          ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
