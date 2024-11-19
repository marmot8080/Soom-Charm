import 'package:flutter/material.dart';

class OnOffButton extends StatefulWidget {
  final Function(bool) onToggle; // 상태가 변경될 때 호출될 콜백 함수

  const OnOffButton({required this.onToggle, Key? key}) : super(key: key);

  @override
  _OnOffButtonState createState() => _OnOffButtonState();
}

class _OnOffButtonState extends State<OnOffButton> {
  bool isOn = false;

  void toggleButton() {
    setState(() {
      isOn = !isOn;
    });
    widget.onToggle(isOn); // 상태 변경 시 콜백 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOn ? Color(0xFF77BCFF) : Color(0xFFA3D2FF),
        shape: CircleBorder(),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.11),
        elevation: 12,
        side: BorderSide(
          color: isOn ? Color(0xFFA3D2FF) : Color(0xFF77BCFF),
          width: 3
        )
      ),
      child: Text(
        isOn ? 'STOP' : 'START',
        style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.045, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
