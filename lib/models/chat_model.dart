import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'message_model.dart';

class Chat extends Equatable {
  final String id;
  final String userId;
  final String matchedUserId;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.messages,
  });

  @override
  List<Object?> get props => [id, userId, matchedUserId, messages];

  static Chat fromSnapshot(
    DocumentSnapshot snap,
    String? userId,
  ) {
    Chat chat = Chat(
      id: snap.id,
      userId: userId ?? snap['userId'] as String,
      matchedUserId: snap['matchedUserId'] as String,
      messages: (snap['messages'] as List<Message>)
          .map((message) => Message.fromSnapshot(message as DocumentSnapshot))
          .toList(),
    );
    return chat;
  }

  static List<Chat> chats = [
    Chat(
      id: '1',
      userId: 'fI2i47nJ3Uez9lF142QAGvJtXk12',
      matchedUserId: 'NriuQHjTmXOOH3ZQqNbQNVZz8cZ2',
      messages: Message.messages
          .where((message) =>
              (message.senderId == 'fI2i47nJ3Uez9lF142QAGvJtXk12' &&
                  message.receiverId == 'NriuQHjTmXOOH3ZQqNbQNVZz8cZ2') ||
              (message.senderId == 'NriuQHjTmXOOH3ZQqNbQNVZz8cZ2' &&
                  message.receiverId == 'fI2i47nJ3Uez9lF142QAGvJtXk12'))
          .toList(),
    ),
  ];
}
