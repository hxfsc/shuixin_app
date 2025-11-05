import 'package:flutter/material.dart';

class VerticalText extends StatefulWidget {
  const VerticalText({super.key, required this.textContent, required this.from, required this.numberOfSingleLineText, required this.singleLineWidth});

  final String textContent;
  final String from;
  final int numberOfSingleLineText;
  final double singleLineWidth;

  @override
  State<VerticalText> createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  void initState() {
    super.initState();
  }

  // 计算总行数
  int _calculateNumberOfLines() {
    int numberOfLines = widget.textContent.length ~/ widget.numberOfSingleLineText;
    if (widget.textContent.length % widget.numberOfSingleLineText > 0) {
      numberOfLines++;
    }
    return numberOfLines;
  }

  // 获取单行文本
  String _getSingleLineText(int lineIndex, int totalLines) {
    final start = widget.numberOfSingleLineText * lineIndex;
    final end = (lineIndex < totalLines - 1) ? widget.numberOfSingleLineText * (lineIndex + 1) : widget.textContent.length;
    return widget.textContent.substring(start, end);
  }

  // 构建单行文本组件
  Widget _buildTextLine(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: widget.singleLineWidth,
      child: Text(
        text,
        style: TextStyle(fontSize: widget.singleLineWidth + 1),
        textAlign: TextAlign.left,
      ),
    );
  }

  // 反转列表（从右到左显示）
  void _reverseList(List<Widget> list) {
    for (int i = 0; i < list.length ~/ 2; i++) {
      // 使用 ~/ 整除
      Widget temp = list[i];
      list[i] = list[list.length - 1 - i];
      list[list.length - 1 - i] = temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final numberOfLines = _calculateNumberOfLines();
    final List<Widget> allTextLine = [];

    // 构建所有文本行
    for (int i = 0; i < numberOfLines; i++) {
      final singleLineText = _getSingleLineText(i, numberOfLines);
      allTextLine.add(_buildTextLine(singleLineText));
    }

    // 反转列表（如果需要从右到左显示）
    _reverseList(allTextLine);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40, bottom: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: allTextLine),
        ),
        Text('- ${widget.from} -', style: TextStyle(fontSize: (widget.numberOfSingleLineText + 1).toDouble())),
      ],
    );
  }
}
