import 'package:flutter_bloc/flutter_bloc.dart';

class PageSelectedCubit extends Cubit<bool> {
  PageSelectedCubit() : super(true);

  changeToRegister() {
    emit(false);
  }

  changeToLogin() {
    emit(true);
  }
}
