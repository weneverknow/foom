import '/features/chat/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    String? message,
    int? date,
    bool? isMe,
  }) : super(
          message: message,
          date: DateTime.fromMillisecondsSinceEpoch(
              date ?? DateTime.now().millisecondsSinceEpoch),
          isMe: isMe,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        message: json['message'],
        date: json['date'],
        isMe: json['isMe'],
      );
}
