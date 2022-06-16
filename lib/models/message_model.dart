import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        message,
        dateTime,
        timeString,
      ];

  static Message fromSnapshot(DocumentSnapshot snap) {
    Message message = Message(
      id: snap.id,
      senderId: snap['senderId'] as String,
      receiverId: snap['receiverId'] as String,
      message: snap['message'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(snap['dateTime'] as int),
      timeString: DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(snap['dateTime'] as int)),
    );
    return message;
  }

  static List<Message> messages = [
    Message(
        id: '1',
        senderId: 'fI2i47nJ3Uez9lF142QAGvJtXk12',
        receiverId: 'NriuQHjTmXOOH3ZQqNbQNVZz8cZ2',
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
  ];
}
