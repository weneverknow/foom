import 'package:equatable/equatable.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/chat/domain/repository/chat_repository.dart';

class SendUserChat implements UseCase<void, SendChatParam> {
  final ChatRepository repository;
  SendUserChat(this.repository);
  @override
  Future<Either<Failure, void>> call(SendChatParam param) async {
    return await repository.sendChat(param.userId, param.message);
  }
}

class SendChatParam extends Equatable {
  final String userId;
  final String message;
  SendChatParam(this.message, this.userId);
  @override

  // TODO: implement props
  List<Object?> get props => [
        userId,
        message,
      ];
}
