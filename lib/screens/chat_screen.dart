import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:environment_app/utils/constants.dart';


User? loggedInUser;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();


  String? message;

  void getStreamMessage() async {
    await for (var snapshot in firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void getCurrentUser()async{
    final user = _auth.currentUser;
    try{
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Env-Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        DateTime messageTime = DateTime.now();
                        String formattedTime = DateFormat('HH:mm').format(messageTime);
                        try {
                          if (message != null || message != message!.isEmpty) {
                            messageTextController.clear();
                            //Implement send functionality.
                            firestore.collection('messages').add({
                              'message': message,
                              'user': loggedInUser!.email,
                              'createdOn': FieldValue.serverTimestamp(),
                              'sentTime': formattedTime
                            });
                            print('sent');
                            print('${DateTime.now()}');
                          }
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Type a mesage', style: TextStyle(color: Colors.black),),),);
                        }
                      },
                      child: Icon(Icons.send, color: Colors.black54,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('messages').orderBy('createdon').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['message'];
            final messageSender = message.data()['user'];
            final sentTime = message.data()['sentTime'];
            final currentUser = loggedInUser!.email;

            final messageBubble = MessageBubble(
              message: messageText,
              user: messageSender,
              isMe: currentUser == messageSender,
              time: sentTime.toString(),
            );
            messageBubbles.add(messageBubble);
            print(messageText);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String user;
  final bool isMe;
  final String time;
  MessageBubble({required this.message,required this.user,required this.isMe,required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5.0,
            color: isMe ? Colors.black54 : Colors.white,
            borderRadius: isMe
                ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 15.0, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
          Text(
            user,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
