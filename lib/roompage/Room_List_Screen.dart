import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Room_Detail_Screen.dart'; // main.dart 대신 Room_Detail_Screen.dart에서 import
import 'Room_Create.dart';

class RoomListScreen extends StatefulWidget {
  @override
  _RoomListScreenState createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  final DatabaseReference _roomsRef = FirebaseDatabase.instance.ref().child('rooms');

  // 방에 참여하는 함수
  void _joinRoom(String roomId) {
    // 방에 참여하는 로직을 추가 (ex: 참가자 수 증가, 방 상세 화면 이동 등)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoomDetailScreen(roomId: roomId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('방 목록'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoomCreateScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _roomsRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          Map<dynamic, dynamic> rooms = snapshot.data!.snapshot.value as Map<dynamic, dynamic>? ?? {};
          List<Widget> roomWidgets = [];

          rooms.forEach((roomId, roomData) {
            roomWidgets.add(ListTile(
              title: Text(roomData['name']),
              subtitle: Text('참가자: ${roomData['members'] ?? 0}명'),
              trailing: ElevatedButton(
                onPressed: () => _joinRoom(roomId),
                child: Text('참여하기'),
              ),
            ));
          });

          return ListView(children: roomWidgets);
        },
      ),
    );
  }
}