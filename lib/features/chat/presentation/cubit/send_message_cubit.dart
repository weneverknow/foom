import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/features/chat/domain/usecase/send_user_chat.dart';
import 'package:foom/service_locator.dart';

class SendMessageCubit extends Cubit<String?> {
  SendMessageCubit() : super(null);

  final SendUserChat _userChat = sl<SendUserChat>();

  send(String userId, String message) async {
    final result = await _userChat.call(SendChatParam(message, userId));
    result.fold((l) => emit(l.message), (r) => emit(null));
  }
}
