import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void chekcIfUserHasProfile() async {}
}
