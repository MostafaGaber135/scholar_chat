// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  final TextEditingController controller = TextEditingController();

  ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages
            .orderBy(
              kCreatedAt,
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBuble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFriend(
                                message: messagesList[index],
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        _sendMessage(email, data);
                        messages.add(
                          {
                            kMessaage: data,
                            kCreatedAt: DateTime.now(),
                            'id': email,
                          },
                        );
                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Messge',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _sendMessage(email, controller.text);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                        // suffixIcon: const Icon(
                        //   Icons.send,
                        //   color: kPrimaryColor,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
        });
  }

  void _sendMessage(String email, String message) {
    if (message.isNotEmpty) {
      messages.add(
        {
          kMessaage: message,
          kCreatedAt: DateTime.now(),
          'id': email,
        },
      );
      controller.clear();
      _controller.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
