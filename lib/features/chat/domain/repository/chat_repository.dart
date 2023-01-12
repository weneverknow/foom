import 'package:dartz/dartz.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:foom/features/chat/domain/entities/chat.dart';

abstract class ChatRepository {
  Stream<List<Chat>?> streamChat(String userId);
  Future<Either<Failure, void>> sendChat(String userId, String message);
}
