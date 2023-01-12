import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String? message;
  final DateTime? date;
  final bool? isMe;
  const Chat({
    this.message,
    this.date,
    this.isMe,
  });
  @override
  List<Object?> get props => [
        message,
        date,
        isMe,
      ];
}
