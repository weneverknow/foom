import 'package:foom/core/firestore/firestore_service.dart';
import 'package:foom/features/chat/data/model/chat_model.dart';

abstract class ChatDatasource {
  Stream<List<ChatModel>?> streamChat(String userId);
  Future<void> sendChat(String userId, String message);
}

class ChatDatasourceImpl implements ChatDatasource {
  final FirestoreService firestoreService;
  ChatDatasourceImpl(this.firestoreService);
  @override
  Stream<List<ChatModel>?> streamChat(String userId) {
    return firestoreService.collectionStream(
        path: "users/$userId/messages",
        builder: (data, docid) => ChatModel.fromJson(data));
  }

  @override
  Future<void> sendChat(String userId, String message) async {
    var uid = DateTime.now().toIso8601String();
    var body = {
      "message": message,
      "date": DateTime.now().millisecondsSinceEpoch,
      "isMe": true,
    };
    firestoreService.setData(path: "users/$userId/messages/$uid", body: body);
  }
}
