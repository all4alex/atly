import 'dart:io';
import 'package:atly/src/presentation/reusable_bloc/image_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/remote/firebase_storage/firebase_storage_service.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final StorageService _storageService;

  ImageBloc(this._storageService) : super(ImageInitial()) {
    on<SelectImage>((event, emit) async {
      emit(ImageLoading());
      try {
        final File imageFile = await _storageService.pickImage();
        final String imageURL = await _storageService.uploadImage(imageFile);
        if (imageURL.isNotEmpty) {
          emit(ImageLoaded(imageURL: imageURL));
        } else {
          emit(ImageError());
        }
      } catch (e) {
        print(e);
        emit(ImageError());
      }
    });
  }
}
