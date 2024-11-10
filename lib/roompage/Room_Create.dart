import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RoomCreateScreen extends StatefulWidget {
  @override
  _RoomCreateScreenState createState() => _RoomCreateScreenState();
}

class _RoomCreateScreenState extends State<RoomCreateScreen> {
  final DatabaseReference _roomsRef = FirebaseDatabase.instance.ref().child('rooms');
  final TextEditingController _roomNameController = TextEditingController();

  void _createRoom() {
    final roomName = _roomNameController.text.trim();
    if (roomName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('방 이름을 입력하세요.')),
      );
      return;
    }

    final newRoom = {
      'name': roomName,
      'createdAt': DateTime.now().toIso8601String(),
      'members': 1, // 방 생성자는 자동으로 첫 참가자로 등록
    };

    // 방의 새 참조를 생성하고 ID를 가져옴
    final newRoomRef = _roomsRef.push();
    newRoomRef.set(newRoom).then((_) {
      String newRoomId = newRoomRef.key!; // 생성된 방의 ID

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('방이 생성되었습니다!')),
      );

      // 방 상세 화면으로 이동하면서 roomId 전달
      Navigator.pushNamed(
        context,
        '/roompage/Room_Detail_Screen',
        arguments: newRoomId, // 생성된 방의 ID를 전달
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('방 생성에 실패했습니다.')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('방 만들기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomNameController,
              decoration: InputDecoration(
                labelText: '방 이름',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createRoom,
              child: Text('생성'),
            ),
          ],
        ),
      ),
    );
  }
}