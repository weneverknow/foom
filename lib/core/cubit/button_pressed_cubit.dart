import 'package:bloc/bloc.dart';

class ButtonPressedCubit extends Cubit<bool> {
  ButtonPressedCubit() : super(false);

  update() {
    emit(!state);
  }
}
