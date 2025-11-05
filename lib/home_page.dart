import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shuixin_app/ui/widget/vertical_text.dart';

class HomePage extends StatefulWidget {
  final Function(Map<String, void Function()>)? onReady;

  const HomePage({super.key, this.onReady});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // https://v1.hitokoto.cn/?c=i
  String textContent = "";
  String from = "";
  int numberOfSingleLineText = 10;
  double singleLineWidth = 16;

  String imageUrl = "";

  void loadTextContent() async {
    var url = Uri.parse("https://v1.hitokoto.cn/?c=i");
    var response = await http.get(url);
    Map<String, dynamic> resData = json.decode(response.body);
    setState(() {
      textContent = resData['hitokoto'] ?? "";
      from = resData['from_who'] ?? "";
    });
  }

  void loadImage() async {
    var url = Uri.parse("https://v2.xxapi.cn/api/meinvpic");
    var response = await http.get(url);
    Map<String, dynamic> resData = json.decode(response.body);
    setState(() {
      imageUrl = resData['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    widget.onReady?.call({"text": loadTextContent, 'image': loadImage});
    loadTextContent();
    loadImage();
  }

  Widget avatarWidget() {
    return CircleAvatar(backgroundColor: Colors.white70, foregroundImage: NetworkImage(imageUrl), radius: 90);
  }

  Widget textWidget() {
    return VerticalText(textContent: textContent, from: from, numberOfSingleLineText: numberOfSingleLineText, singleLineWidth: singleLineWidth);
  }

  @override
  Widget build(BuildContext context) {
    // loadTextContent();
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [avatarWidget(), textWidget()]),
      ),
    );
  }
}
