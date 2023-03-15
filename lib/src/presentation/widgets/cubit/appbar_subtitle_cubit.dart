import 'package:bloc/bloc.dart';

class AppbarSubtitleCubit extends Cubit<String> {
  AppbarSubtitleCubit() : super('');

  void updateAppbarSubtitle(String title) => emit(title);
}
