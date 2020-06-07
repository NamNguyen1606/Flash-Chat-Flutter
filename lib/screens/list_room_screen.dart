import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _firestore = Firestore.instance;

class ListRoomScreen extends StatefulWidget {
  ListRoomScreen({this.roomName, this.roomID});
  static const id = 'ListRoomScreen';
  final roomName;
  final roomID;

  @override
  _ListRoomScreenState createState() => _ListRoomScreenState();
}

class _ListRoomScreenState extends State<ListRoomScreen> {
  var roomName;

  void getAlert() {
    Alert(
      context: context,
      title: 'Create New Room',
      style: AlertStyle(titleStyle: TextStyle(color: Colors.white)),
      content: TextField(
        onChanged: (value) {
          roomName = value;
        },
        decoration: InputDecoration(hintText: 'Input Room Name'),
      ),
      buttons: [
        DialogButton(
            child: Text('Create'),
            onPressed: () {
              Firestore.instance.collection('ChatRoom').document().setData({
                'RoomId':
                    DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
                'RoomName': roomName,
                'TimeStamp': DateTime.now().toUtc().millisecondsSinceEpoch
              });
              Navigator.pop(context);
            }),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Room'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: RoomStream(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getAlert();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RoomStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ChatRoom')
          .orderBy('TimeStamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rooms = snapshot.data.documents;
          final List<RoomFlatButton> listFlatRoom = [];
          for (var room in rooms) {
            final roomName = room.data['RoomName'];
            final roomFlat = RoomFlatButton(
              nameRoom: roomName,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              roomId: room.data['RoomId'],
                              roomName: roomName,
                            )));
              },
            );
            listFlatRoom.add(roomFlat);
          }
          return ListView(
            children: listFlatRoom.reversed.toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class RoomFlatButton extends StatelessWidget {
  RoomFlatButton({this.nameRoom, this.onTap});

  final String nameRoom;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              nameRoom,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
