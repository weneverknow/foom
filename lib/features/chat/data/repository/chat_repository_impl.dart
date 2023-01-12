import 'package:foom/core/exceptions/exceptions.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/features/chat/data/datasource/chat_datasource.dart';
import 'package:foom/features/chat/domain/entities/chat.dart';

import '/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource datasource;
  ChatRepositoryImpl(this.datasource);
  @override
  Stream<List<Chat>?> streamChat(String userId) {
    return datasource.streamChat(userId);
  }

  @override
  Future<Either<Failure, void>> sendChat(String userId, String message) async {
    try {
      await datasource.sendChat(userId, message);
      return right(() {});
    } catch (e) {
      throw DatabaseException("message can\'t send");
    }
  }
}
