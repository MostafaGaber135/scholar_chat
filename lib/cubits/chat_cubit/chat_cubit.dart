import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    getMessages();
  }
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messagesList = [];

  void sendMessage(String email, String message) {
    try {
      messages.add(
        {
          kMessaage: message,
          kCreatedAt: DateTime.now(),
          'id': email,
        },
      ).then((_) {
      }).catchError((error) {
        log('Failed to send message: $error');
      });
    } on Exception catch (e) {
      log('Exception occurred: $e');
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(
          Message.fromJson(doc),
        );
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
