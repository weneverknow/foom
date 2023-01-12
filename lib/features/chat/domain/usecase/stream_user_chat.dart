import 'package:foom/features/chat/domain/entities/chat.dart';

import '../repository/chat_repository.dart';

class StreamUserChat {
  final ChatRepository repository;
  StreamUserChat(this.repository);

  Stream<List<Chat>?> stream(String userId) => repository.streamChat(userId);
}
