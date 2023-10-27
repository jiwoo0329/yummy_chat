import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  final int price = 2000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Stream builder'),
        actions: [
          IconButton(
              onPressed: () {
                _authentication.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/pVruTdlJjjNxlBW0UXVi/message')
            .snapshots(),
        // stream과 연결되어 지속적으로 데이터 받아옴, snapshots:새로운벨류지속적업데이트해주는메소드
        builder: (context, streamSnapshot) {

          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data!.docs;

          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    docs[index]['text'],
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              });
        }, // builder: 결과를 반영, snapshot: stream의 결과물
      ),
    );
  }

  // body: StreamBuilder<int>(
  // initialData: price, // 최초의 값을 사용할 데이터
  // stream: addStreamValue(), // stream과 연결되어 지속적으로 데이터 받아옴
  // builder: (context, snapshot) {
  // final priceNumber = snapshot.data.toString();
  // return Center(
  // child: Text(priceNumber,
  // style: TextStyle(fontSize: 40,
  // fontWeight: FontWeight.bold,
  // color: Colors.blue),
  // )
  // );
  // }, // builder: 결과를 반영, snapshot: stream의 결과물
  // ),

  Stream<int> addStreamValue() {
    return Stream<int>.periodic(
        Duration(seconds: 1), // 매초마다 1씩 증가
        (count) => price + count);
  }
}
